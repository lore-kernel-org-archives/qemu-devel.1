Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01886C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE03C2070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uawn0eRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE03C2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8t2-00030O-1Z
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:00:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP8sA-0002ev-DO
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP8s9-0003ZE-EI
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:59:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hP8s9-0003Y4-70
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:59:49 -0400
Received: by mail-wm1-x342.google.com with SMTP id o189so8344349wmb.1
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=k6TxiI/rYAa2sdWfRcGuvApguTy8/i+roGMq4e+FTS4=;
	b=uawn0eRWUX53z8dKMoEWGQE0b9Tu1d55oX23ttgeS/1mlRpcrwLObDlqpWXSJW842g
	nwJYYKE9/mP6coughF6lWo+JoAK2BKuU6DBNFohKsnUPHNqCoU60Cta+JgLxtzvdHmVE
	Ha6mwp3sYkGqWQ0i2RhMUEfUViE+OWPxSEhvNpOFeEXu2HJ8LL23zKPJnDtAGUpN3JA2
	hmangFml3w6V511V5tvlplLBJI/+pZtBNGDsfsxPIOeDysE+z3M32k5wqFyOV7gNSizu
	QBOUslwQvoQ77Z+CSjcqbIfGw6bVUhvXKl4mreq17Vu+ROEOyWe1YWFaba1XGHRyX1fj
	uVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=k6TxiI/rYAa2sdWfRcGuvApguTy8/i+roGMq4e+FTS4=;
	b=rChb8pMrCqd2mGU0XQzR4ghD3nEuyVcrq5A1h0+XMbfOPIwJNfJLclG/g4zIRGZ4Lc
	hQFKXyHHnvna74BEJKUfTcfOuD7x3/1Gb3sX9lyUScDrm/inXGRN+m/8neFBE4f1i/nA
	GWt91cGW66wEhBh8qDgkUapWOW7WG5mzae+Nvl1atiM2Tkpm3jcWbb+1nxUzHFmYHNqP
	bnDy3YcB5PJNoAT+FP19GkYlzS9oN0/JIXLd6xffMPUhMufC5KXb3n2s7CICI32veXEy
	E4zSTb3f0GgDGuonqlnjPmbhFOssEBvBqoY2Ncd63Yqgg51KoVoAbqgLr7z+DJRiNnD7
	vnwA==
X-Gm-Message-State: APjAAAW+T0Mcf5h4gdFazQCyW34rEJ0GQI8xitkoTMSJPEPpKncxSuKJ
	WvaZ2H/Lk9FOA+wKNKycpwcw3g==
X-Google-Smtp-Source: APXvYqyc7VZuaDWnKGW6f74XjzlRQtV0r65l21I0Voq3wzTopDbFuNKaavLbX4vek90ZmZlqdAYLog==
X-Received: by 2002:a1c:ab09:: with SMTP id u9mr7334865wme.29.1557507587153;
	Fri, 10 May 2019 09:59:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	j190sm8376252wmb.19.2019.05.10.09.59.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 09:59:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A64391FF87;
	Fri, 10 May 2019 17:59:45 +0100 (BST)
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-6-alex.bennee@linaro.org>
	<CAFEAcA8Dsdp2rnORnzqemWspfFxfhVwkAz=2EXdupo8iDj_=Hw@mail.gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA8Dsdp2rnORnzqemWspfFxfhVwkAz=2EXdupo8iDj_=Hw@mail.gmail.com>
Date: Fri, 10 May 2019 17:59:45 +0100
Message-ID: <87tve2b5z2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v1 05/23] semihosting: enable chardev
 backed output
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 9 May 2019 at 17:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> For running system tests we want to be able to re-direct output to a
>> file like we do with serial output. This does the wiring to allow us
>> to treat semihosting like just another character output device.
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 51802cbb266..6aa3a08c2fb 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -3975,12 +3975,12 @@ STEXI
>>  Enable semihosting mode (ARM, M68K, Xtensa, MIPS, Nios II only).
>>  ETEXI
>>  DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
>> -    "-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,=
arg=3Dstr[,...]]\n" \
>> +    "-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,=
chardev=3Did][,arg=3Dstr[,...]]\n" \
>>      "                semihosting configuration\n",
>>  QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32 |
>>  QEMU_ARCH_MIPS | QEMU_ARCH_NIOS2)
>
> As you can see in the docs here, semihosting is supported on
> five guest architectures, so we should implement this new
> feature for all of them, not just arm.

As I've introduced this for testing I see no reason not to add support
for other architectures. However I was hoping this is something that
could be done organically as other system tests get enabled.

--
Alex Benn=C3=A9e

