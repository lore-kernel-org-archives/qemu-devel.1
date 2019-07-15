Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452AAC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A3C2083D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iEUGUMir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A3C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1om-00027T-25
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1oa-0001iw-R3
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1oZ-0007kS-L3
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:18:52 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1oZ-0007k9-Fq
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:18:51 -0400
Received: by mail-oi1-x242.google.com with SMTP id e189so12696979oib.11
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=6QIiGkrlS8tMn+V1ryNWa/v833NKC2Mdbu7RCkbcCrw=;
 b=iEUGUMirdQD+ON6qvFwCox7llMu9/u4G0VBFXuLDRZu+zTTiHGijnjKnmk1RxvAlU5
 Ye+mmCFcn9hacrpdi8tN6KlKTNUHubDKRrIKKW03nfS+5q8x9ItDMJ352OqrGgkXgFlK
 fALqMyd/8qJgA8hp9RinDRVmOO8WiUo28ILU7Z5k/3IZGDI9gUE7gAMbkQDPx+kkgRwg
 OESEgIvxHn+CPD8LE+IXQm5gM2wkkjLY+85o+pX69mBkUROWDmPFo+VgnpoLgABCTmXu
 8ikEn2Yjw0gXZLpaqCRjuVnSBIEjt/SynwdgAYEm3AtUzOOw6m+RqsWAIlb4GEy6zwCh
 bTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=6QIiGkrlS8tMn+V1ryNWa/v833NKC2Mdbu7RCkbcCrw=;
 b=Yb+OSLjO5BN+lfjk4mbTcRhBI0Dx/F/apznZOqFUZ2B01SjBw6+7xj3D/6PTS438+G
 zaZScWWpRrGwAVPTWoptSPlatCwYkNNOKbusqbrELl1yjlcxJXUkUyjZOmV+xVrruLmz
 1SLOHpmRi+rjKksTqqKT6p1kuKazWeAptPzvCwuCMVu6KxhyQuF0yhYwJVVWMOKzl2QR
 49f22vH9UA3oMJ12ixFjfnMPhwkL9w7oZbPNolmL1hERjhgXcJuSNuJUZyMNOaYTpwCL
 TUi/bzAPAlcr7NQalhUH4JUxpl9Ji0IA5cSifX589MpN3wl6kJa1YVHb6yDLvdiw8Pab
 22Kw==
X-Gm-Message-State: APjAAAVWiS/Dw8jwavnFuD/KBTKudmUBayXwlPUfKhs8JfN12COZgwyk
 ni8+ONt6Tpkcna057OaqE/I3jn1Phm6xoTlYD8F3giDvxoU=
X-Google-Smtp-Source: APXvYqxlZdDwmZhq1f2896CsJpNOdRctWVh/bhYMUu7p0p8xAmBx+QyZrOLARNl3+sVISa9H19wf0Oh+m+xEz7kGPk8=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr12826953oie.48.1563200330404; 
 Mon, 15 Jul 2019 07:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190715134211.23063-1-peter.maydell@linaro.org>
In-Reply-To: <20190715134211.23063-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 15:18:39 +0100
Message-ID: <CAFEAcA-SxDpS6ovhtgQiXFcqSAFoO-HiMOCmD9DfVgLEgD5yrQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 00/10] target-arm queue
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

On Mon, 15 Jul 2019 at 14:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> target-arm queue for rc1 -- these are all bug fixes.
>
> thanks
> -- PMM
>
> The following changes since commit b9404bf592e7ba74180e1a54ed7a266ec6ee67f2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20190715' into staging (2019-07-15 12:22:07 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190715
>
> for you to fetch changes up to 51c9122e92b776a3f16af0b9282f1dc5012e2a19:
>
>   target/arm: NS BusFault on vector table fetch escalates to NS HardFault (2019-07-15 14:17:04 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * report ARMv8-A FP support for AArch32 -cpu max
>  * hw/ssi/xilinx_spips: Avoid AXI writes to the LQSPI linear memory
>  * hw/ssi/xilinx_spips: Avoid out-of-bound access to lqspi_buf[]
>  * hw/ssi/mss-spi: Avoid crash when reading empty RX FIFO
>  * hw/display/xlnx_dp: Avoid crash when reading empty RX FIFO
>  * hw/arm/virt: Fix non-secure flash mode
>  * pl031: Correctly migrate state when using -rtc clock=host
>  * fix regression that meant arm926 and arm1026 lost VFP
>    double-precision support
>  * v8M: NS BusFault on vector table fetch escalates to NS HardFault
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

