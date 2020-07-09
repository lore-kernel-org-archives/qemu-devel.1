Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515FDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174F12077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkeB+Hh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174F12077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYpd-0007y7-Ca
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYo5-00068P-SH
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:49:54 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:40739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYo2-000695-Sp
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:49:53 -0400
Received: by mail-oi1-x235.google.com with SMTP id t198so2244242oie.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+athLHJlypBKXOM0/lGRh5FSAV/t5EUtwkWl4szL8BU=;
 b=jkeB+Hh9z9j155+ml4Tj204jF4UBx+cTD3gyxWLu9KVnQbA1F2TCPhxOszhVrCSFzg
 DCieYg6mMPUKm8trhd7sZABy+yI0kHAIwaTVVrtFOQIWok+65uM4AxLgnqfSr7yl1qlJ
 t59Ffoq4et+/2YFEd5/xoNw6R1yV7ypkoDEv4E5dO5x6kiuO+ARcJaXMAkdyBEuECVB6
 Q1Ba8evWWz0ApRzEVdnUjgiJXCKZBIJVezt3ilhDFgT4sH5H7nhuBwESl9m0crWXndXx
 rlcXmaOyckbQS49EXm91SdMtQUdLY0aqIV7bIgCoASmb69uVxHup5VZvHrCScgiUjsgA
 zi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+athLHJlypBKXOM0/lGRh5FSAV/t5EUtwkWl4szL8BU=;
 b=RZ3FKl7lhWyxX8zDC5oPOriXj+qQ85cSAS8bAcYsbDVOT+LMncV16adcXQPFHoi3an
 aGT+h2vu26qhSx7HINmcMXMLauf52OxPO8t7JIPZZNTIqHRWI+EkCwqGxd4fVdLtETA4
 KM8ajr5kgInhIDzU6qUnafoyne7FE0JPhgGF4bullpDdAw8Ju+1ikJ22zRh3W2GcDzzT
 4uln0Dcq7p1MR38TXTlQsgEG5jMmEJQE96HwblanhMSRQ80mF7QIr8oQ9fJwq1Yv7AGk
 QIPOZBgZcSCdbStHQLE/RESl/qeMh9VEOPxOMQaQ79yzZ33SfpOBnD7/fJQB/XWr+5q/
 38Yg==
X-Gm-Message-State: AOAM533odw7AAu30QMPpmnPRcCbGRViQtg13r2RZ2jyUpVl2bDzu2vRr
 fsQSpsT0zuZGf9Z0Lcekpgd15GWq/g5x8QQi9lulKA==
X-Google-Smtp-Source: ABdhPJxQM39T0e1yKgxZwm/nPf2fTICgyGxKkLs7lOEAS1KssEIp1NMNs9c0edyrWyEjzWXX8iWAobX8uwlkjRLpMxc=
X-Received: by 2002:aca:1706:: with SMTP id j6mr593058oii.146.1594309789694;
 Thu, 09 Jul 2020 08:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200707105255.362318-1-laurent@vivier.eu>
In-Reply-To: <20200707105255.362318-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 16:49:38 +0100
Message-ID: <CAFEAcA-vONFb05kPMMR_3f+M_xJ5ag-HgbHaxPU0oC_eiX-eJg@mail.gmail.com>
Subject: Re: [PULL 0/7] Trivial branch for 5.1 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x235.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 11:54, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit eb6490f544388dd24c0d054a96dd304bc7284450:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2020070=
> 3' into staging (2020-07-04 16:08:41 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.1-pull-request
>
> for you to fetch changes up to 89615cfef57e04da0e5a1bd212a62f8696468e79:
>
>   net/tap-solaris.c: Include qemu-common.h for TFR macro (2020-07-07 12:38:50=
>  +0200)
>
> ----------------------------------------------------------------
> trivial branch patches 20200707
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

