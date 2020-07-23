Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6BFC433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7ECD2086A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raQyvSFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7ECD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYgw-0002YT-Nq
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyYdt-0007Le-3r
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:40:01 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:33749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyYdp-0006P8-CX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:40:00 -0400
Received: by mail-oo1-xc43.google.com with SMTP id g18so172236ooa.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3JOO8k+0aVYcSy+vn/mcWn3Qw1qfzRw9x1qAV2XvUeM=;
 b=raQyvSFPn+Jgh34J5vthlpV1WaxXcWU1xmVnfuXiwJFcCUM+TxRLSL4O6mjZIgMjkx
 qzTP8RclUciggyGRULxX5GNXY6SlVOhc+dUMfBOKpF6xVeKuS3LrebEJKj5YC6GL59f7
 D48OvyUAyerOc4kqpm+8Jp1B7qTTtK5LZLfpAjRusbAC5cCGAL6p31Ve1etFwtdUIVnU
 ZwPNrRs2O5bmEQbd9bt1gZpbnU3yjdLCjZ8kSHr0OuSASljqJv/Y06zcE9KYf9nyNI6x
 P+cXHHwL3Pf0Koae3u62IsOdVgh38ESrFQym1VHk5qMSmyPIBp7awRgCrkwjoP9/sLrw
 9gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3JOO8k+0aVYcSy+vn/mcWn3Qw1qfzRw9x1qAV2XvUeM=;
 b=jhVfSPPh1AweysepcVaeJS9NM34gdmFDqf+VBqUt2f8xbG6RoECTNWojcbnefQj2+V
 CLUZ+MKXPkV9x2fy29peENF2ubCA7WKyC+GOIvqLKkAxdcc10tL1tbQW4bGjfcQ5po2o
 6PN2j++SybF8uP9XtIfEUaaN2BvgTRWpsBZab4zrMY3o1k5+yOz5dHSmap8ygnNZVOgx
 dJMr/tn0sX+OLrgfd4GqcM16vzMfwtSf0AScTED/RSE+x1Eskv34geKaEwX1Tj9ckMeu
 2Qe1lOYGGt4CN4tHVehLuYGH4A6wAghvZQ+GnKR2z4jBmCL31hBKnF+6anYFUJQcYjzU
 66CQ==
X-Gm-Message-State: AOAM533MDlPMb5burNpGQ3Yd3f1NB9amx5N+riQi7B1FezfjosK2rSLK
 sHcQ4GDFdk1lpMpX/7KKSjwdwDU/x/S0fXt/1nco1w==
X-Google-Smtp-Source: ABdhPJwmkCst75fjZJsnBjFzv5DvxulZzEyUxz5JqFvltwWCgvF+WmOc8wxDyeNMdFQ8tfxWoEcdb55i3ibfJcSzE0M=
X-Received: by 2002:a4a:4949:: with SMTP id z70mr844610ooa.85.1595500796220;
 Thu, 23 Jul 2020 03:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200723084355.18370-1-guang.zeng@intel.com>
In-Reply-To: <20200723084355.18370-1-guang.zeng@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jul 2020 11:39:45 +0100
Message-ID: <CAFEAcA94d5s6fqabi39pVQnJPJrwXOkk4XeTMmCMD_ji7Vh4Hg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/edu: support pci device state migration
To: Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, wei.w.wang@intel.com,
 Jiri Slaby <jslaby@suse.cz>, chao.gao@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jul 2020 at 10:01, Zeng Guang <guang.zeng@intel.com> wrote:
>
> Currently edu device doesn't support live migration. Part of PCI
> configuration information would be lost after migration.
>
> PCI device state in source VM:
>      Bus  0, device   3, function 0:
>      Class 0255: PCI device 1234:11e8
>      PCI subsystem 1af4:1100
>      IRQ 11, pin A
>      BAR0: 32 bit memory at 0xfea00000 [0xfeafffff].
>      id ""
>
> PCI device state in destination VM:
>      Bus  0, device   3, function 0:
>      Class 0255: PCI device 1234:11e8
>      PCI subsystem 1af4:1100
>      IRQ 0, pin A
>      BAR0: 32 bit memory at 0xffffffffffffffff [0x000ffffe].
>      id ""
>
> Add VMState for edu device to support migration.
>
> Signed-off-by: Gao Chao <chao.gao@intel.com>
> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> Reviewed-by: Wei Wang <wei.w.wang@intel.com>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

