Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68519C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 19:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D53420833
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 19:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8c8/VYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D53420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48359 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDwqG-0006am-Gb
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 15:55:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDwpB-000634-KB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDwp8-00046R-Cm
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:54:27 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:33922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDwp4-0003zF-74
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:54:24 -0400
Received: by mail-ot1-x330.google.com with SMTP id k21so16787363otf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=xkQa98a28VKjTQrGjpPepqcM83CyZTPDKD30JbWI/1Y=;
	b=l8c8/VYfMQgQqPIsphW8hwqUPJ99LDAEiJMe9KpNxDIu1EOJLYhbhin1iN3KAA9Kn4
	5qkxbALwgrob+r0z/zPGWDOl0Dqc0vQtG+kZOXbkrpNVfmJJDkJemykkV36E+r3mbb+o
	LXTLx8BAYYxe2XNn7uhOEvkjKBj8I0lW72Top+PWvKf4wvOGJyB/0Pn36Z4BF/k2IFzA
	UvjjdYzxeyXXErO+v+pv2W4sbgvi4GPvlxYYdTPSvn/KJlxIfH2Jo3LbJzlS0/SKaK8s
	cRBbVF9HR9OGPONs90idRoTuMlVVxq8sva6Zt1Ze7dYX6NrUbehj3p1ActveFCwlZCvV
	CoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=xkQa98a28VKjTQrGjpPepqcM83CyZTPDKD30JbWI/1Y=;
	b=E+fJkev76s8GZdPr4NxgYhg9y3jcPdLt+642F8p4Wrvr3IJ4AwtWB6djLhR4Pr9C4r
	RYnDi2s6Q+IzWlGyFh652xk5aZZcitxUTIK9Snlg6iK8CIgIskE0SYnEbIkrZ8UqpFoJ
	iZSfXqurxMFLRicCU4fDXOApAMqAYmdCxZ+XNdm+4L8ZW6yK1+/2mb/+Yyy/RDiPnHdX
	+zK48SxbILjW6QthWV+94Aq5S0PRDIBkxpLziuCXRo63cBhjGdVLCDe1Cl2GKe7VPQWY
	4RTl4EPp7LJ7fSwwduI2cOH7niwLbIqH5E4o9QVsD6BxMzyaA4ILo73E1NGRZpPntTqZ
	vEOA==
X-Gm-Message-State: APjAAAVr9Km5TIG88aaIOOrEC5SR8IPvjf98tzUPiMlcsmpipDXMjLVW
	FSl9+474sOYo6oHW3hot1othICumwSJt9KSZnPxciw==
X-Google-Smtp-Source: APXvYqyAnUELNb144rMpxqrhLcBo5V9T7rSLiGQylmAB5Y5zu0Kb7ipHDS47MC1R6Z11suu5qMS9Axwm7f4QW5m/A6s=
X-Received: by 2002:a05:6830:1497:: with SMTP id
	s23mr21786268otq.236.1554839659594; 
	Tue, 09 Apr 2019 12:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <e61c4a17-910b-0066-92ae-3fabf4a4e3e3@weilnetz.de>
In-Reply-To: <e61c4a17-910b-0066-92ae-3fabf4a4e3e3@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 02:54:11 +0700
Message-ID:
 <CAFEAcA-djqczK-BG-NBF3116fmmbxS5GPH94NGfDXWQU3dxoww@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] Misaligned memory writes on ARM and other runtime
 errors
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developer <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409195411.OQIrpPLUBcArgudHRqAN2HUemKKox-viuLPjXBPU3Vg@z>

On Wed, 10 Apr 2019 at 02:12, Stefan Weil <sw@weilnetz.de> wrote:
>
> When QEMU for ARM is compiled with sanitizers
> (--extra-cflags=-fsanitize=address,undefined), I see runtime errors for
> qemu-arm which indicate misaligned memory writes:
>
> /qemu/linux-user/fd-trans.c:1389:18: runtime error: store to misaligned
> address 0x42ff4b34 for type 'uint64_t', which requires 8 byte alignment
>
> The full sanitizer report is available from
> https://qemu.weilnetz.de/doc/sanitizer.txt. Some of the reported runtime
> errors can easily be fixed, for example by replacing "1 << 31"
> (currently 188 matches) by "1U << 31" (currently only 70 matches).

The shift "errors" are not in fact errors -- we compile with -fwrapv
to request a dialect of C where left shift of signed integers is
well-defined and has 2s complement semantics. Some versions
of the clang sanitizers don't correctly handle that flag as meaning
that those shifts should no longer generate sanitizer warnings.
If you're using a clang without that bug fix you can suppress the
warnings by adding "-fno-sanitize=shift-base" to the --extra-cflags
you pass to QEMU's configure.

The misaligned accesses are definitely bugs. The linux-user code
unfortunately has quite a lot of code in its data-structure conversion
code that is pretty fast and loose about accessing fields in
target-layout data structures.

thanks
-- PMM

