Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774D8C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5E120896
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCfhutfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5E120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8PB-0000wL-EM
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:29:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP8Lg-00067f-PY
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP8Le-0001kS-V7
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:26:16 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP8Le-0001a8-CL
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:26:14 -0400
Received: by mail-ot1-x343.google.com with SMTP id g24so1560247otq.2
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=sPfzql6A26Y7SGTwPH39Gt8yMgNkTb9ZzSWCy7itmZk=;
	b=GCfhutfp51798vAFOvO7Zy3D1XU5IoY9JwH5ezuclDJcECt6Ld+bufQt/u1I0OUcwd
	FvwCVy/TCqJhd7YsCTIszh2DPgSAiwdS2LtysJlZTTDikG8BaKkxb5Sm1QAw19oUl5yc
	WTpPSqqOYauAnRRob8KUBRVNhM89vcOMTft0ML0GfEe9NHZCHcbwNyMqvRKGt35r9lV+
	AMFigQbiy3kwI9rbhpKMt5ulnGnWpdNVuBOJBCbhZgAOgYTHj/qdaR8q074T2WeSIAsN
	p2yW5ckleUW1wkGThIXbE3bFVFgtZOkCpwCVI00lGuKNECVbxGONNiOJ+GTmUQZz+v74
	/u/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=sPfzql6A26Y7SGTwPH39Gt8yMgNkTb9ZzSWCy7itmZk=;
	b=OpwllUs5s0Hkj40qHpqD3eonnfHnK1hvT1YQs+1cQuKSvTT5KbvRFq9kyz38bLx34h
	eFwb1IaDQaxKZdwtvQLxeridbkY0CGgGKllfu+ENrGDQOJxoH/hNj7ix9byWxE7lz0gF
	sXHbCCcEtmsDIqx7UCG9oJxNv2uuVRajCscxEpQ2qfmAu6omT3wmkmrBeE0KwA7nif0Z
	7gfdQJ/C3Zll531HFL9N3nSBck1wnuFMO7xJ/YdS3DP+iClxnVDmfb97b58B9IZT8Qbz
	In+MXLwSZMTgCS4padISYJQURN+2nQrDB5Vm5DaKQCXjKxSNcyGm2n4weN3Zyd1DZmDU
	VjRA==
X-Gm-Message-State: APjAAAXOhb3llaCW4nnHoxgCZOhgePmlLvZ+taOScNER7KWA+tn20AO5
	AGRRaeVhPJmDLkX8Q5R0ERnPTeqDn/AGHtIAwz0TZg==
X-Google-Smtp-Source: APXvYqyG1UinZ5zsgWCI4aoeysMgy9qNIN/HkXdKKDs0hQeA/iHpnsrFosQl+0jArC32IOqdT79ICfb1DxRvFYGYj/k=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr7368004otk.316.1557505568390; 
	Fri, 10 May 2019 09:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190502185835.15185-1-laurent@vivier.eu>
	<CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>
	<87sgtv4wjo.fsf@zen.linaroharston> <87imulaude.fsf@dusky.pond.sub.org>
	<87tve53sy7.fsf@zen.linaroharston> <87zhnw58pa.fsf@dusky.pond.sub.org>
	<CAFEAcA-s0UYr0VW3ccG07r=BiGCVtDHkRb6yW0X_ev-zAkOxvw@mail.gmail.com>
	<87o94amjud.fsf@dusky.pond.sub.org>
In-Reply-To: <87o94amjud.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 17:25:57 +0100
Message-ID: <CAFEAcA8h8ry3XiT1dUOZknTYK78_W=_b3R4CzfFNnS_Z1G9Bww@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial branch patches
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	QEMU Trivial <qemu-trivial@nongnu.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 16:05, Markus Armbruster <armbru@redhat.com> wrote:
> I tried to reproduce on a ppc64 box in the gcc compile farm, no dice.  I
> double-checked config-host.h has #define HOST_WORDS_BIGENDIAN 1.

On s390:
 git clone git://git.qemu.org/qemu.git qemu-tmp
 cd qemu-tmp
 mkdir build
 cd build
 ../configure
 make -j3
 make -j3 check V=1  # passes
 wget https://patchew.org/QEMU/20190313162812.8885-1-armbru@redhat.com/mbox
 git am mbox
 make -j3
 make -j3 check V=1 # fails

thanks
-- PMM

