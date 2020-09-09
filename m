Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6BCC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 06:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3E52087D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 06:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFtW4d/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3E52087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFu1p-00068U-Bt
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 02:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFu0Y-0005RW-5V
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 02:55:06 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFu0V-0001sA-VA
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 02:55:05 -0400
Received: by mail-io1-xd41.google.com with SMTP id j2so2021635ioj.7
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MFGhA0w7SMAP5sLeLxoQqm/ujyfkWRQ8BwGBhsq83+g=;
 b=OFtW4d/OI2P2jy/4ZMpoz2BUtDO/AfyYaxjNlBvOdZAtB9bDCUkKCR8XFywmevL7F0
 o3RYQEPsX5tIpx99PKCVYlCInF1QML/vGNbkjayp8h3/X2116flX/Dk6RmNJa/N4LEcK
 bZXA4MhJC9ozYPlsXaupB7Fj2g4o0Lacy4ynvxBXi5r038pHISFX3UUY/6EmtpkW0On8
 LzlbgOFu+aROpb1Ro8dnDK8UK9dudm1eoRYQHXG73d+ZMkSZbk2p4NwP2Pe+FJycbRVF
 aj06JrZ8CZq4gzFp0AI433oYY/DikAM/t7Vfz7vvtlHvuziU+rzlNzJZK5mKyoUEDW/K
 jEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MFGhA0w7SMAP5sLeLxoQqm/ujyfkWRQ8BwGBhsq83+g=;
 b=p+oTfhl6yL2Ritl7a2GTFjFhukCd3dg9VgZTUsePfDG5f1GdIKHnNFi/H1MEemE2xu
 moBw1oQ9godbgYDfQ3e2UQQKFtsOiW/0v/G6tYOpG98E8dH+E/zWksz0IY8bqwYwU1ho
 RZZBP0MgMhNh+irCsZoc3LTFGxNw4EymvrxilVq9P6FSWhtN0St/4TWjj4bj6QdaLAYa
 zR7JzvxQbmC+q5eUkeDdJ60SF5bowRPchof7dC36KwJcyhXW4OsQWCubelwXOXZy3Ruh
 zDo80+h1gtbVpgvTY+7RjpwCzvlfFvIGM1ajFZcP7i6zHjXlj+JSZay6GODUB0PFHNQ5
 Hdrw==
X-Gm-Message-State: AOAM5321d2yuTLJlKa44SiuFo8bTSYP4zx4uhcXv/5+6qo90IGKOPW9o
 Ceb4ItV8jo8W9HyYdv9YxpQDbC5qJmxHTzYHRhNZ
X-Google-Smtp-Source: ABdhPJzz2dRPU/uBsW9KPafRCpYZV/1RiU7EeSuTwCeu1JWUDuDJWTWXOznKlorrocKwbZXud2S42q/BZFTS1Ijb2S8=
X-Received: by 2002:a05:6638:224e:: with SMTP id
 m14mr2738501jas.101.1599634502710; 
 Tue, 08 Sep 2020 23:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <04a3f2e202d9e84cefa431101eaf4c7e0cbd1a0d.1599549462.git.haibo.xu@linaro.org>
 <20200908110317.efr2bwgkityzepbg@kamzik.brq.redhat.com>
In-Reply-To: <20200908110317.efr2bwgkityzepbg@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Wed, 9 Sep 2020 14:54:51 +0800
Message-ID: <CAJc+Z1EcJAFCCbzofEGc+ViLBZTUb6Chc_iJ0bd=jMfo3P9MXA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] hw/arm/virt: Move post cpu realize check into
 its own function
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 19:03, Andrew Jones <drjones@redhat.com> wrote:
>
> On Tue, Sep 08, 2020 at 08:13:25AM +0000, Haibo Xu wrote:
> > From: Andrew Jones <drjones@redhat.com>
> >
> > We'll add more to this new function in coming patches so we also
> > state the gic must be created and call it below create_gic().
> >
> > No functional change intended.
> >
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
>
> This is the wrong version of this patch. You should use v2, for which
> Peter has given his r-b
>
> Thanks,
> drew
>

Will fix it in v3.

Thanks,
Haibo

