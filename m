Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAE8C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A21C214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="C2AccYPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A21C214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53121 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irhpl-00076G-6q
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ilg@livius.net>) id 1irhoU-0006CF-Dw
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ilg@livius.net>) id 1irhoT-0006Ou-AU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:30:22 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ilg@livius.net>) id 1irhoS-0006NR-V1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:30:21 -0500
Received: by mail-wm1-x333.google.com with SMTP id p9so17696481wmc.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 04:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=eYNFa5Bhv7qJOtgJ+6RxiiiCas0UwA2leU9uE/w4vwY=;
 b=C2AccYPIm40rpRFDdroGPZrPtVU4PQexww4orANUnz5q/JQID5fw3+tYMEU3PRgCLd
 z2vXghvvfzivNppbf1ngfFykCTukXgoxnycAlmkMrfhqSsCiCl4Ngi298P7v68rfWK+P
 bTrHG5r8/8WydBMLFFDkpMIFru/tXhPQTNQU/V0yVDMofoKz00AwVqulEonIN0uxWI9X
 wa7dxgVy1BicqKaJ+6iOiGBUG0zsvBDM7N2hHp9q7rVSi+9FnUeTDSTNJcosCDXD/qp+
 9epfWSdgkMh8XXm1RTqEznKst5Ed42kpEAvhhzmJYUxC9wVrNFmW8UdEdSijxQQfVTcZ
 oKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=eYNFa5Bhv7qJOtgJ+6RxiiiCas0UwA2leU9uE/w4vwY=;
 b=WPuulyD5SSNNQSM4VtrbP4xgcgL9Jjs/NT/ZXh9ZnhMSWstfMF/oHnA41dPQe9tJRG
 +5Rbkc2Y+n0xsLK1yk3e86y3vwjwu3JOHEplFlqplMzEzr+WtzfS+qYiBepHBsJvp3JG
 Vu7fsXYLfFPs83NOPLedoax5pOugXSj3AlUC0wxDp3DXA6tVrjv4QQrJaMcMddsIRLa6
 aRcCASL/8zDHBIsdn2mBNeq72HNrN6xUlkvF4SjRJnFWC70cRaGNvr9TfCG1HwsMRWxl
 CPs5AUp4OW2vTGU3rDrVXN+RAYyrPo6cDGz1R0bFTYlXFGaQAiCbQtiZBOrSg2HftMdQ
 OyYQ==
X-Gm-Message-State: APjAAAUki5gc0kRWmIkU4c1p1B4ktolUqCjLnP//LwrjhynYwWyR3xF2
 VfK4yGq/Rgem76/ORQ8Iuycm/Q==
X-Google-Smtp-Source: APXvYqxStILxOScGAQfctRoXwkjDQsxIAAkEZeLzqQQHTXPk56pPD8OsENdEVjQX4DO8x0kkoypHLQ==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr31185594wmj.156.1579091419272; 
 Wed, 15 Jan 2020 04:30:19 -0800 (PST)
Received: from wks.local ([188.26.232.206])
 by smtp.gmail.com with ESMTPSA id i16sm24405210wmb.36.2020.01.15.04.30.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jan 2020 04:30:18 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Semihosting, arm, riscv, ppc and common code
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <87wo9tkjxz.fsf@linaro.org>
Date: Wed, 15 Jan 2020 14:30:17 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <58DE85E5-2A72-4073-AF02-6B944AB05889@livius.net>
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <AE7841A1-B4D6-4D6D-9AFD-01C4604D7BC4@livius.net>
 <cd9a2de94700a2781f176247131dceba690d8f31.camel@kernel.crashing.org>
 <87sgkimkma.fsf@linaro.org>
 <1309ca0ab6405d88cfd949c73130ad0f2af944a6.camel@kernel.crashing.org>
 <87wo9tkjxz.fsf@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: keithp@keithp.com, qemu-arm@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 15 Jan 2020, at 14:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> ... AFAIK the main users of arm linux user
> are compiler test cases for M-profile CPUs.=20

I confirm, generally unit tests.

But not necessarily, I used QEMU as the main development platform for =
the Cortex-M port of =C2=B5OS++, a C/C++ framework/RTOS, and it was very =
convenient.

> ... Is semihosting even
> going to be a thing on real RiscV/Power silicon?

Even for Arm it is a thing of debuggers and development environments, =
not of silicon itself, since it requires no special hardware support, a =
BRK instruction is enough.

=46rom a software point of view it would be beneficial to use the same =
semihosting protocol on other non-Arm architectures too, even if it is =
far from perfect.

I pushed hard for adopting the Arm semihosting for RISC-V, and even =
contributed the semihosting code for OpenOCD RISC-V, but officially the =
only mention of semihosting in the RISC-V specs is in the notes =
sections, where it is mentioned how to use the BRK instruction to invoke =
semihosting calls (RISC-V has a single BREAK instructions, and to make =
it unique it must be surrounded by some hint NOPs).


Regards,

Liviu


