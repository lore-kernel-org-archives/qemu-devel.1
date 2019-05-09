Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95401C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623F821479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/2G7eDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623F821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50813 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeik-0004wf-M6
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:48:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOeha-0004YV-6I
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOehZ-0000nl-7G
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:46:54 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOehY-0000ms-VP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:46:53 -0400
Received: by mail-ot1-x342.google.com with SMTP id 66so1596396otq.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JHYBFKd1AZr+xd/gkTPrhACdzrTh+rusGyVuFp13Mps=;
	b=e/2G7eDoz56jKeA35wWCMFmD1rbNObRMffjkpkDmFXtVW7Z3VYhVgq4I+Jm/MXbUCY
	7Q6OVRBz2a8cRMCEqto6LFBmhnP+N5Fkj4wEPfl+VofHnLzSha+PJ986q3dsXeRLhzlG
	E/596zkn8v+q+Ysb/You5YOZGZdWywfBrAsshn4BV8G2djEyaSdswLWkLN6zaUXBL9e8
	rQtPW3x3725lFGi/ipuK975FZjQTdN5ADSXbL3Akkb1pbMtcXQ8a7UAdu2nMoNO38/Nf
	qoL79T337Ja93rT3oCTGoOCZCV60YfkYizduS/i2n4Jd6lMKDyAGomjIRQ/96smJY0n5
	US/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JHYBFKd1AZr+xd/gkTPrhACdzrTh+rusGyVuFp13Mps=;
	b=osLP3MLySUeeIre+bp36WImb4yEhE7uPGmj8k46ZDX1yVOq3j2fgN0Q294eEnTWc1x
	PYqHIDX8WyDeopV+oRocolnpU6/xJo8xiiakms0aQR7nZsQHXNwlyqyAAZKucgaiRD1v
	iCvIxbZ05lO34OY+lDRVr+7R08RUVyZpVjh6P2ruwGE7FPklVT9zUQbefoxcV8vpOBvr
	SPucLGTPCPj8UWg5dUPj48z7RwuBl/OzL/by+c/zkQk/HCaDdu9ae8oyBsln+Z0bIVVt
	mNTdLN45otlU4E6SjZwmL1RTM9omOvKSMiaU/uhuaUqR8PawLHI7XP71hWjdx52kQmyC
	NWEQ==
X-Gm-Message-State: APjAAAX0lDqkf9SOS9vs8pboZMyQjaiiCELTULo0F3XrzppP8cqLLXyY
	XpgdcED/Tc8z54qc5akeSSoHv+u2jjPaiGRPBijaJQ==
X-Google-Smtp-Source: APXvYqzaB7gh6bUenRBp9lP+ok8lFEvoynJtHWtvcSk651aSy5+M1/YjWfs9mCUmcd/CbX+QzXZDKdOGWmOVC6CrCoI=
X-Received: by 2002:a05:6830:1258:: with SMTP id
	s24mr1632534otp.238.1557391611191; 
	Thu, 09 May 2019 01:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
	<1555560291-3415-3-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-poCxPqPtfhx4mUJ5pcOjn1Hz-WNxEt29f=JgpFMi4Kg@mail.gmail.com>
	<CAHmQWvB4AZGM+MV0LP-vtfoW0kG4RFkf0R6NoRWm8WrFuum+Og@mail.gmail.com>
	<CAEK-wKkiyNYjKKsJzukC_LLi163ngWV4P18-47Z6xxF0azB2uw@mail.gmail.com>
In-Reply-To: <CAEK-wKkiyNYjKKsJzukC_LLi163ngWV4P18-47Z6xxF0azB2uw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 09:46:39 +0100
Message-ID: <CAFEAcA_2fkXSBaLaFX-FPA8AxEhqMF+mzNpZwwy1Ns2Y6Q=0yA@mail.gmail.com>
To: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v7 2/2] hw/arm: Add arm SBSA reference
 machine, devices part
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Leif Lindholm <leif.lindholm@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 May 2019 at 18:48, Radoslaw Biernacki
<radoslaw.biernacki@linaro.org> wrote:
>
>
>
> On Wed, 8 May 2019 at 13:30, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>>
>> On Tue, 30 Apr 2019 at 22:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>> > I don't think we should automatically create the usb keyboard
>> > and mouse devices. The user can do it on the command line if they
>> > want them.
>> >
>> OK.
>
>
> Actually I need to rise an objection to this one.
> As we trying to make SBSA machine as close as possible to real machine, we should have keyboard and mouse.
> Those have the same requirement as for VGA. It's just an expected piece of HW when you for e.g. installing a server.
> We also do a lot of FW work so it is expected to have keyboard (and even mouse) in UEFI.

Real hardware doesn't have the keyboard and mouse built in --
when you unpack the machine from the box you have to plug in
the keyboard and mouse yourself (and often you have to
buy the keyboard and mouse and monitor and maybe the
PCI video card separately).

But more seriously, the philosophy of the QEMU command line
is not "do what the user probably wants automatically". It
is "provide the user with full manual control of everything,
using a complicated but orthogonal set of options". We expect
that if users want a more "friendly" interface to setting
up VMs then they will use a "management layer" on top of
QEMU (such as libvirt).

thanks
-- PMM

