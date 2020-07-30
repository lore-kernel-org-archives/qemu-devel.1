Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC7BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D849720809
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFCg0D1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D849720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k15cp-00017A-7U
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15bm-00009t-Gk; Thu, 30 Jul 2020 06:16:18 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15bk-0003yT-Ug; Thu, 30 Jul 2020 06:16:18 -0400
Received: by mail-oi1-x244.google.com with SMTP id u24so13419736oiv.7;
 Thu, 30 Jul 2020 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZP4adMN7iC/Ot+lCHb7BuEnsV4Yd5lwShgkKZ48Qb7E=;
 b=AFCg0D1B+2dl6CqMTh2t6q0CM2UWj6iJm4tYzvDJTl7HFs6EWvTPlsQH7dRjTjNlTP
 wlcf5nHT9JICVMtnBit5nt7HxTDKk+oWpCKywzhQRMHh+9xAkY0JsBm6jN/F3bNFuWHl
 +a/h9bpJq3QusFPgm4ic0OArgOSWSrbr1KzgoS9gkB95QvURBn602iR1Ao+ON9aZVXNU
 fhaYMcOWO9iSDi5TXvUE+x2v1TOTO19Bg78eG96w/d1+UjPMYn5UnCRONhW/KMLt5vpC
 BReQDl5H1jrmYNs+UDM7qgxKx5UbK58HjyR7Z8jZURdgoghNPX8p2mW5p3cY13PS6UDX
 haog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZP4adMN7iC/Ot+lCHb7BuEnsV4Yd5lwShgkKZ48Qb7E=;
 b=G42nvYY0HBG1hnouixw6s4r7YLB0arPnL3iAVxeG9ZIiuR4uOhC4Z/kwVa/hQGH8rp
 D8rqZ5TKkc46DH2mMq4N8jn65TmUCMqKDi+yg0fGmsD4cnOmzrwqF58v1T+nhJnWUgmO
 hCJw2hOGwp9u3n31mDeYXKSoSLOYj1Qx5uviAFxQd0pr2egqB5nFe8BhK/EcBvtgeuP7
 aCIsOqzniBF1PV2SyeO2+C4smjZSNdsnKETstQj317QFvPJdJsWZkZBPXTlW6LDuyanX
 LhUMd6W8GliWPBSnMyHyM+/3YKmqkFgFC5AmFO3DYtPOfwVR1FC+bMQIx1nhu5DJfWNg
 zz8Q==
X-Gm-Message-State: AOAM532nfyqVJFBIzJ13FQXTYB7ZI/+0uuRkluO4VF4PQZTMk5/VlPIm
 rOXs1tWHoDS9dEDLVPjn8t4wR1aGj/sgSGhOuW1e2KMw
X-Google-Smtp-Source: ABdhPJxb3UJRKw91rkJxqT4Bt8gvPfXS1ihYkIEcVVIUTsVDhPpkhcfC7d6mLzieGOBmQzG7fgPYemqKDgKR+jiFNkQ=
X-Received: by 2002:aca:4345:: with SMTP id q66mr7870727oia.151.1596104175565; 
 Thu, 30 Jul 2020 03:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200729220638.344477-1-its@irrelevant.dk>
 <20200729220638.344477-6-its@irrelevant.dk>
In-Reply-To: <20200729220638.344477-6-its@irrelevant.dk>
From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Thu, 30 Jul 2020 19:16:04 +0900
Message-ID: <CAA7jztcXbbe8XtEN5r1wQ53QbuRRB7J_kdo0-PsoKFXiLgLcGQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] hw/block/nvme: destroy request iov before reuse
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 7:06 AM Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Make sure the request iov is destroyed before reuse; fixing a memory
> leak.
>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Looks good to me and Thanks for splitting this up.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

