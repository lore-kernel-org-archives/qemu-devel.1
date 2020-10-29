Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D05EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F38520838
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wbMVUEWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F38520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY91P-0006Yx-8g
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY8x1-0000Do-U6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:30:51 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:40821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY8wz-0006YA-Hj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:30:51 -0400
Received: by mail-ed1-x52f.google.com with SMTP id p93so3244548edd.7
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=opvRuqJyiV2yRPu8IkaawHj6ighldjLANhBzIJFl3xY=;
 b=wbMVUEWVwtLpc9mj0zmNCzoMESTbSjSkGVslYRZJr7QWEP0fz8Wn2VMMwxrFnvH5ok
 +dpHHY5tT2yw7GauefqfS/RGYQCv+67txpl0DqgDQsgxO4fmwDA358jI1JbtqUCgZD9I
 0NWdW1VjuTUslqsRYUXMYy4pmKjzz48jTGe2Qhz6CfF6F8BJF2lUvnLcPC33Qo1C6IGJ
 v8GtKuTdKok6DfApAcCAFJpAuDf/Snw84q223PXkpWEDmLG7umdNCuZ8j/OgGZkYMTnC
 CiWky4CAMsM4rFCTzII4G1AAqouFKhvg7KAQefVO5qrOhFmC77L5mL2MCw9EY5tsQAQD
 AGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=opvRuqJyiV2yRPu8IkaawHj6ighldjLANhBzIJFl3xY=;
 b=FJpDkHiKLRdAgj/Q1zBuyECt7jw+GDOUgQNsrTLbQP5Pd9K0bEOAKqjKWLKLGeVhI2
 SAR1KbVl2IhD99ZOPvJ3TDDHEp/14VQ8E7TJGehHo2eUnOVGl3L/P2QbIv/353msayzS
 NZxdyk4rIrbsmSlB8O3Mh0jk1cNWkr66PlIqRT7M5nQlJ+KLGJltX5jNYuTs5O6RCUFI
 QTvV2/s9i42jQ4II+rVu12TfIv+TOJ1roLqk3UWI5cS5++njTXdkIm//JQIUmDyTlo+l
 LM9/9Ms3MmrJ5gf5f5FJ6hEZYA6uucrkKWaRYE0kvXJZOrHjpTgv/4NDslhNFNUKiSn1
 MsNQ==
X-Gm-Message-State: AOAM532eVTV6AT4Dwic9MMdeVdSgMRHYNWesynuVbPobZcMsMP5IA26g
 cqJgfp8/BZ1Haq7hDfeWLV0N8m9dOMWk8gs9yPrDfcPGdOQ=
X-Google-Smtp-Source: ABdhPJyNEhvCEfAA4A90h4Wg7MALK6F/6aqE/s/Gi1HLpZF8XyGUXD2bJd1cXsAuUegcGga282lQhS5KN4cFpnloWhk=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr4202745edq.146.1603981847436; 
 Thu, 29 Oct 2020 07:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201027114438.17662-1-peter.maydell@linaro.org>
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 14:30:36 +0000
Message-ID: <CAFEAcA9F+DGPDN72=xBbjL7arUN5zoQUC_5GMpDS=r2V2hZnzA@mail.gmail.com>
Subject: Re: [PULL 00/48] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 11:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Last minute pullreq for arm related patches; quite large because
> there were several series that only just made it through code review
> in time.
>
> thanks
> -- PMM
>
> The following changes since commit 091e3e3dbc499d84c004e1c50bc9870af37f6e99:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-bitmaps-2020-10-26' into staging (2020-10-26 22:36:35 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201027-1
>
> for you to fetch changes up to 32bd322a0134ed89db00f2b9b3894982db3dedcb:
>
>   hw/timer/armv7m_systick: Rewrite to use ptimers (2020-10-27 11:15:31 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * raspi: add model of cprman clock manager
>  * sbsa-ref: add an SBSA generic watchdog device
>  * arm/trace: Fix hex printing
>  * raspi: Add models of Pi 3 model A+, Pi Zero and Pi A+
>  * hw/arm/smmuv3: Set the restoration priority of the vSMMUv3 explicitly
>  * Nuvoton NPCM7xx: Add USB, RNG, GPIO and watchdog support
>  * hw/arm: fix min_cpus for xlnx-versal-virt platform
>  * hw/arm/highbank: Silence warnings about missing fallthrough statements
>  * linux-user: Support Aarch64 BTI
>  * Armv7M systick: fix corner case bugs by rewriting to use ptimer
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

