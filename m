Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FC9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85B72082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHHHGSE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85B72082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k15ad-0007XK-7t
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15a4-00076z-8H; Thu, 30 Jul 2020 06:14:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15a2-0003cN-Ld; Thu, 30 Jul 2020 06:14:31 -0400
Received: by mail-oi1-x242.google.com with SMTP id y22so23255168oie.8;
 Thu, 30 Jul 2020 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1VFoFEpw4aMFgDVSLWZwQ6jmstub8A0ucj/v5uTmwzg=;
 b=lHHHGSE5DxbLi0k+plxzFWmwxasPVMwQT2AD4lCfnjM4OHy9Nc3dQIkJgOW+O4aehl
 snb8nh2/vgPqdYgiXVoNiIuFAS2M6B7JBjqwuJU1/qPaA8oT12MVGKfgI0mFZ0MVXGWd
 vYP3unWJPqSbKwUIBJfcQrw5cy15GODVm/OHxb6bYZd3KsCxO/MYF4L4BAoBlZdtrjQH
 5p2ulQP3+BkmE0A06ahtT+GWYhvYGkfRdyPuFdHLPfq646HTgmUddQkhQqYaZVr0JdQi
 JZZvrcV0wRFwTz2NqWr4pCNTObr/SGxJhaOlthgGuKBnFcuDpyv00uWK95OpEN37jAx0
 K/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1VFoFEpw4aMFgDVSLWZwQ6jmstub8A0ucj/v5uTmwzg=;
 b=C0f1XI6RSNcVSRRa0FL6bJLjm+7Qyw6zTlmh9pM5eM/x6Lh4BMX6o9vZJbtXSc7aDI
 4GQ3aimbGetLHsa44OaTcA9MIsXIsS9a1s2ehplxM/D2cy4Zdos8hPXJc2aDzsFjArNI
 pUcHQXIiXLNpRR181HfycH7f/wSehE3x8inpv/rcjjyDjq+VRV87MFViHYiD1muxkYFB
 ywTlXAHkhc0ViwwFIaL0oor18CcBE91KigHxjLfzhv42yJWBOCZ8TqvRBvaZm6NEcQ00
 VmTjfsT5i7V2vkra75ofjk4orH9B7zV6VA1ABwOBrdKD3Kk0Y3Ny/WkNOTPRUobGxIFy
 ja5w==
X-Gm-Message-State: AOAM532QhDkIRBuUWJkerKtfbuXG/YcKpvLnm3MjF9TSG5ZA6nC1DBVy
 irFXaZoGC6G8QwJ//3D6mu4S6iABg0H5++T5zTQ=
X-Google-Smtp-Source: ABdhPJwGdjag6t9OZnhHBm7Q53SFSg34sR406jyymLptgFPT/C06VbDLFuxW98dw428nc97XwtCalqHSfntmkLoTgzM=
X-Received: by 2002:aca:4345:: with SMTP id q66mr7865578oia.151.1596104068838; 
 Thu, 30 Jul 2020 03:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200729220638.344477-1-its@irrelevant.dk>
 <20200729220638.344477-2-its@irrelevant.dk>
In-Reply-To: <20200729220638.344477-2-its@irrelevant.dk>
From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Thu, 30 Jul 2020 19:14:18 +0900
Message-ID: <CAA7jztcaTcd0cKKXeXpxHfgZu3Xro3bFZuyCkvOvcuid9J8c-Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] hw/block/nvme: memset preallocated requests
 structures
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-oi1-x242.google.com
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
> This is preparatory to subsequent patches that change how QSGs/IOVs are
> handled. It is important that the qsg and iov members of the NvmeRequest
> are initially zeroed.
>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

