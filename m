Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7C8C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0F220663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPjWgPc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0F220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6ta-00034Y-4G
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51081)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hg6r7-0001cT-Vt
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hg6r6-0003cY-OA
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:16:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hg6r6-0003ZG-Dg
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:16:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id n4so2436872wrw.13
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HYE0wJ2rSvsKHKxBmrzmiKhOTPWzCI5w+tM2tkyF6lU=;
 b=JPjWgPc/n1gZQQYfso8iaFfEW4U7qD4Q/zwyTb5GfLuH/Rp2iWftPzdF55BfhJ/6JN
 BjvSpfUSSZflZUpvytllP/IYnV2L6Suvs509zT4mxAkrUqfApFuwTv+3EmEoZGnds0qY
 3ECwkIRc5RriNxQU1Kew61ABxRPw6/f9FZjonMeDEB6fub7BuDMtVL/0PFFiCNX+uePG
 WjrhJqxZQoQEi7Jg6Hpc5eauVIck76Ea4uepLUPyI4VAmMHFV/YESXnYk1Rs2SE8M+tL
 CQqaALEUMC+EsshlLeXKIQe3WL0+1V9oKO0F4pdyQGZlTHjq1ZtCtiunOCKeGVBhLwuU
 HpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HYE0wJ2rSvsKHKxBmrzmiKhOTPWzCI5w+tM2tkyF6lU=;
 b=o2vw7tCFBVBlYhGScVxwex41hIDo+046O8duEHEesVNdaAQYI5Ls1b8OqvkGqmi6Cr
 uVL0B6NVrrAXKKIBkrnqCCmqRmUp7w+zqhXjxxJLj/ntNZ2Z1DQ8G/aq7bBqOJDzOAbW
 5UX+BL8VAUx0NKbEA3tw98ooIaepxeAuEmdBDrV0aRg2wl7KFNhFTUEgskISTCcSGpPd
 Oghj8449ztAub13IJvaHqFUeyL16VIpyc1Fj9ENAWH/gR0RzJxoP9idnnJRrhod6KW0d
 IK5OPjVesbdZc9HqQFHbFo0cCtaGGQB71g68Tve9IvCfKKDsQdJN5TgOsQa7tRB3PIve
 dB1A==
X-Gm-Message-State: APjAAAVr0MV6jW9DI34c/hhrernt6efkRNc50JU9k4OWKHiBv1YOAhJI
 H/vsRpgKkKWlVrAbLv/OqHVaqQ==
X-Google-Smtp-Source: APXvYqyqWb04wNgFRlbcdv5QWnDlwup3AHmECVTZdMRrFWb6UpwJCGVVaTavqeqinzjVRTXWfyqMtg==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr3354754wrm.68.1561551410900;
 Wed, 26 Jun 2019 05:16:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f7sm12136155wrv.38.2019.06.26.05.16.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 05:16:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E01FE1FF87;
 Wed, 26 Jun 2019 13:16:49 +0100 (BST)
References: <f8f439b4-3835-686c-2c1e-20fe78d6bbf1@redhat.com>
 <d75c0641-01a3-ac5c-2f4d-b41505747815@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <d75c0641-01a3-ac5c-2f4d-b41505747815@redhat.com>
Date: Wed, 26 Jun 2019 13:16:49 +0100
Message-ID: <878sto1qz2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: Re: [Qemu-devel] trace: floating-point values blacklisted
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
Cc: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> [I forgot to Cc the list, resending]
>
> Hi Stefan, Llu=C3=ADs,
>
> When trying to add a trace event to report a float value, I get:
>
> trace-events:11: Argument type 'float' is not in whitelist. Only
> standard C types and fixed size integer types should be used. struct,
> union, and other complex pointer types should be declared as 'void *'
> Traceback (most recent call last):
>   File "./scripts/tracetool.py", line 152, in <module>
>     main(sys.argv)
>   File "./scripts/tracetool.py", line 143, in main
>     events.extend(tracetool.read_events(fh, arg))
>   File "./scripts/tracetool/__init__.py", line 365, in read_events
>     event =3D Event.build(line)
>   File "./scripts/tracetool/__init__.py", line 283, in build
>     args =3D Arguments.build(groups["args"])
>   File "./scripts/tracetool/__init__.py", line 133, in build
>     validate_type(arg_type)
>   File "./scripts/tracetool/__init__.py", line 86, in validate_type
>     "declared as 'void *'" % name)
>
> Floating-point types are specified in the optional Annex F of the
> standard ("IEC 60559 floating-point arithmetic").
>
> Is there a specific reason to not trace them, or simply nobody ever had
> to trace them?

I suspect that latter. I can't see any reason not to have floats (and
doubles) in the allowed list although I wonder what happens with x86's
weird-ass 80bit values. Do floats in x86 accommodate that?

>
> Thanks,
>
> Phil.


--
Alex Benn=C3=A9e

