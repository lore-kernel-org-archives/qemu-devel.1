Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82464C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 11:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC75D2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 11:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJlwDUpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC75D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45551 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJzK0-0002yR-Sn
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 07:47:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJzIm-0002VQ-IK
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJzIl-0007T6-DM
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:46:00 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hJzIh-0007M7-GF
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:45:57 -0400
Received: by mail-oi1-x241.google.com with SMTP id l12so2628635oie.13
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=m7BZyzZEm1Sa8d1x8Kn6h8VRaLuD2mj6Ndp0Mi/JUHs=;
	b=aJlwDUplnPOieEl6zfs52jk0/IGfCQ7N3PF1Q+lAQ0HOlCErPlxC489nHk+Hf2y74g
	h8yuQHlOpDpg9VeKxxSJM5jBxY+qAjG9mMPbLMpfBI3fQWx8JwXvm5UW8lIgZqh/u0hG
	R1BHpyY/gxAGTK98rzB38DFX9x8XrqNmWWg+ScOTLk0JD0ZDAQSuGu3oU3Sqx+Rmglmk
	0URPZiCAKq/rAbAiJEDVtxmGF/blaYIGvTW5c+T+2kePEwKwuAFWcxw/0/Qj1PCoBSwE
	ibEHsxuqCGyHa4V0rsrkAxDpXf0aztGMIFHLvtXhiE/X1Ztlo13cv2/KxcV7PvNUM37J
	Vlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=m7BZyzZEm1Sa8d1x8Kn6h8VRaLuD2mj6Ndp0Mi/JUHs=;
	b=oEYcgXWG47Fbhf5fxHE7orUN9SXzkL8R4Gfgv0Wue7AiE5Ix2TK3oTRgkRLqhlZBlZ
	kRRDaWiVhOrBReZDdgr39lm5HWpj7atgp4FUY+0wMOV73QjmL6ClRTXCb2whDgABOYNL
	GAjHQuuv8d9KHQWjzA0CUZ3XwyfPsZFBFIiV8O4WXD8ZuI04UM4t7zESVeomDKQachV3
	sMt1hSd/1iBOubbiUwFMYXf3FWA+4JBHCmXqE+twjnPEnU9TNZtdguH+G79xPk4+nSJ7
	owWBvFnXf1wpC459cwHiwuL05EzQDuJ63XxLEkNTaj/j+vuQxQwv4JOECDUjhvoWs+yc
	zgxw==
X-Gm-Message-State: APjAAAUt8ze4pANpK1RQU/KeaAYed8wi7oEu1cHHiLzuYSLZUXWno0wA
	G2jP35yYTr/j0flfdRgTp47xwacmAlHvp3rmRNyVdA==
X-Google-Smtp-Source: APXvYqzdFU7FLe9mstikFRuLQZPxOGasyGi18lBVHM2byTosx7R6I6sPFObEJBlsIDLwdG/e6iB3JckEwatzDqJ8X0A=
X-Received: by 2002:aca:c7d3:: with SMTP id x202mr6143556oif.48.1556279148335; 
	Fri, 26 Apr 2019 04:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
In-Reply-To: <20190426091702.GA2071@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Apr 2019 12:45:37 +0100
Message-ID:
 <CAFEAcA8OVKO087uiNvwDGObiaxHAPYHwoXLEN1t5Y4v9B43r9A@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
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
Cc: Jim Mussared <jim@groklearning.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Steffen Gortz <qemu.ml@steffen-goertz.de>,
	qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
	Thomas Huth <thuth@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426114537.Er2YzjzD21MLD-qoZ4kVgekdrrYw1iPfTYbiG46yNCg@z>

On Fri, 26 Apr 2019 at 10:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Apr 25, 2019 at 08:07:06PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Previous to this commit (v3.1), we have:
> >
> > $ qemu-system-aarch64 -M netduino2
> > qemu-system-aarch64: Guest image must be specified (using -kernel)
> >
> > Now (v4.0) we get:
> >
> > $ qemu-system-aarch64 -M netduino2
> > qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1=
)
>
> A user-friendly error message is needed here.  The check for -kernel was
> too specific and is not desirable for microbit where we use -device
> loader.

It's consistent with how many of our other board models work.
If you try to run them without providing any guest code
in any way, then they just do something not very useful.
(For A-profile this used to often be "die with the 'execution
from something not ROM or RAM' message" and is now "just steam
through executing garbage and/or taking exceptions in a tight loop.")
This is how real hardware also works :-)

(Strictly speaking this message appearing is a defect in
QEMU's emulation -- the 'lockup' state behaviour is architecturally
well-defined and is supposed to cause the CPU to sit there doing
continual instruction fetches from a specific (non-valid) address
until either the system is reset or an NMI handler kicks in which
might be able to rescue it. We don't bother to emulate this detail
because lockup is pretty much always a guest bug and the only thing
I've seen using the lockup behaviour and expecting to recover from it
is test code.)

> Old boards probably want to continue using -kernel.  New boards like
> microbit may use just -device loader.  Perhaps there is even a group
> that wants both options.
>
> A solution is to introduce explicit checks so that we can tell the user
> the appropriate option for the machine type.  I can work on this if you
> like, but probably won't be able to send a patch until Tuesday.

But it's difficult to tell how to identify whether there's really
any guest code there. For instance the user might want to start
QEMU, connect via the gdbstub and load guest code from gdb.
Or they might be using the generic-loader device. Or they might
really be using -kernel but with a broken guest image which doesn't
have a vector table in it, which will result in the same message.
I guess you could have a heuristic for "if an M-profile CPU is in reset
and the value it loads for the starting PC is zero and the gdb
stub is not connected, then print a warning that the guest image
is missing or there's no vector table" but I'm not a big fan of
heuristics...

thanks
-- PMM

