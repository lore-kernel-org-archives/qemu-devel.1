Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81010C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DEDD20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZQQXuG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEDD20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRyL-0007nx-Kn
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRva-0004DR-2d
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:28:30 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRvY-0004Y3-EX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:28:29 -0400
Received: by mail-ot1-x343.google.com with SMTP id k4so2058129otr.7
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dBHI6XnyQBCVvqfjrKwDTVT77lOgCq640799Y784rVc=;
 b=bZQQXuG6RMJvLi6W4yl6iCvmyC+sHMc10E5QKG+mhSDtg/chEf9FIag5ni77/CjD5R
 Otj7rWotZFiu39tgsstMvC/iNaHbefawoV81BeTPhuliWK9yhd0cU6Zr/VIboVdymSnd
 NAJcfxYaQgv8EIjsVb6gLbLLTmzROquPD/YTNlFpWPSp99jD5putitFPZV3g+tiyNhZN
 PdeQ5yMxcN6Jeeje0F9dtHNpHb83H9VslM34Xy1pMUIilj30FthTiM2G/0VUK+OgGw4W
 FDsDPjtSTgaTDeucNAzJZGZlwxfstDwvYkDeVzKYSpXW/D6DFWEtETFILBDbgTFIeY1v
 yGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dBHI6XnyQBCVvqfjrKwDTVT77lOgCq640799Y784rVc=;
 b=lSjXnEWc2CYBVu2He8nifDlPpPCkEewuUjTuOfK1MIw+UdsIo1lwNvf7YXeaW40bXl
 H9+gc2RtSvNDGWH9VnOJ2ae0TAwVqgUdjoq0QPVr9SwSXimO3ybShsAXMA7/I/29c6YS
 XTidbSWLYJ2t02ANuSCCgmNPYYpdEY58gD0njMeWJYjtPuthASe3Lfmlx++wQJlzCkqj
 JXNZnuap6G67m5sntECjtZxr8Vu37Kl7B/Qug1QuLeXz+s6crrKIg6gKpAaALI1madvJ
 RWvp33rll8RKXHH0aJQSVw4uJ3DxqdHES42oajRZ1VYplAZ9bcxQWaHfmdY/U/8b0YoJ
 rvfg==
X-Gm-Message-State: AOAM533UrmV5SOYyS6q4tcIHFa5bSIwfHId3294aW1TUTEB4YXqxums7
 tsrAt2XuitoKNEAHhwtTt2NrbEweu0/LCwQR+a/B4Q==
X-Google-Smtp-Source: ABdhPJxXT907mRNBgbLR9l2Y/QKccuYilfP+yF2pbqKYYHtg6iOeg4yaHPSwGnL+V8o17grGEFS0t494pWaJd2FE5SY=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr27497695ooi.85.1593091707225; 
 Thu, 25 Jun 2020 06:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 14:28:16 +0100
Message-ID: <CAFEAcA-ePgr2OLEtf1nRr_5SduQ0R=ZW__7Zzw81LBHkqgN4wA@mail.gmail.com>
Subject: Re: [PATCH v8 00/45] target/arm: Implement ARMv8.5-MemTag, system mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 8 incorporates quite a bit of review (thanks, PMM):
>
>  * Include HCR_DCT in the HCR_EL2 update.
>  * Use a separate decode function for ADDG/SUBG.
>  * Use the system arm_cpu_do_unaligned_access for user-only as well.
>  * Fix alignment for LDG.
>  * Fix no-fault for mte_probe1.
>  * Rearrage how tagged pages are recorded.

I think I've reviewed everything that didn't already have review now.

thanks
-- PMM

