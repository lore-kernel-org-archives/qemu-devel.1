Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F05C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE81C20679
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gcXan2xJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE81C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEt42-0006Vd-T6
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 06:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iEt2Z-0005Q2-Ja
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iEt2Y-0000FF-Jz
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:36:27 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iEt2Y-0000DT-FE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:36:26 -0400
Received: by mail-oi1-x241.google.com with SMTP id 83so10674719oii.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RIpIdKusdl+IE2Li/qyUEzusAPTfzSa89LvtdLMUo0g=;
 b=gcXan2xJP+z7JjARjErViz2CERrDuoztTZzKjyjJK8bI4YGb/FgB6+/L+RuyWE3sBZ
 O60PaQyQbG+vI2gDEk7pMyhzs1xOhQ3pZuZGBgliijP2kJuiAICf2dQlbZBDWofDHTSO
 zyipQVAuTFix0feS0Pho2617ib+M9uC8mCprFcjIoxobBMFWh7f/WFZst203p29W33y3
 Y3egtDXOuynsGn3Lp6C0/3Y3Nkk7JkhcRa1daminunout5uOc/ysZUCWejcp5py8BHw4
 H4XxWTZmZDUpdehFumvqFURMWF2dA23i/TrTrnRUIccstB43BbbXavG/KTYW4P0tmAKB
 GHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RIpIdKusdl+IE2Li/qyUEzusAPTfzSa89LvtdLMUo0g=;
 b=p9IK2g5Pkqmtz3589Hti9YZmwb2qwo5ACJMvgeNAIe8wPq1SXMPK5Fl4wLZTw1N/9C
 2XHs8XzktYhQFSPHywy8hpBzK2Z3SrFXfjLiPzDi6E3P/ku80n4k/dtuKnpNDSWJuLF0
 nJXB+u9Sw0GdsSpZKqG+3k8avouNJvpuvWPURCJqp1TJeL/GkbkIoWztFevFuVp42/46
 2BrQ4QJZs4GjeVhNJJZ3REPtPSmj4W/1nOXEl7yaRKFAgLiJD1Y5kD81zhue+3UuDykY
 AXLwMLZn85HWnN1Zg7w6heg4Rv+QQc5fxD6HAiRz+ceikZ+HACz7qFEI6JIfjzI8K7zv
 XsVA==
X-Gm-Message-State: APjAAAVHwaW1vw5qLgJj16Mn/G5cFIwD1fiBkKcn5//8S/Ak6StCfvDP
 PeHJrsG9bHWdiYJw5mz05dBH1haaVoUcRkrOmsQxfw==
X-Google-Smtp-Source: APXvYqxYhOUnByla57bN4hLMfMV17by52x9MiPYPYIVih0/mKA/kbkkOpU9BEJDpUHnKoOQJrp64OCAfYLeF0MNxSJU=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr17817001oih.170.1569839784454; 
 Mon, 30 Sep 2019 03:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190925233013.6449-1-alex.bennee@linaro.org>
 <CAFEAcA9vb5_Mi_axWpu7269Zg0xMLbiiV80ofLeyDpfws3G4nQ@mail.gmail.com>
 <4512b61a-ed82-e628-88e5-f44ef87c2b50@linaro.org>
 <20190930092519.GB11996@redhat.com> <87impakrky.fsf@linaro.org>
In-Reply-To: <87impakrky.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 11:36:13 +0100
Message-ID: <CAFEAcA9TT9hpRF29CVdZ8h83+b_rwc0bRWeVNjC4PLPJkzdFOA@mail.gmail.com>
Subject: Re: [RFC PATCH] configure: deprecate 32 bit build hosts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Sep 2019 at 11:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> So if lots of people still want 32 bit host support for TCG guests we
> can probably come up with something that keeps existing functionality
> ticking over while leaving the newer architectural features to 64 bit
> hosts only.

I don't think we should do that -- QEMU should offer the same
(emulated) functionality regardless of host.

thanks
-- PMM

