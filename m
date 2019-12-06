Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707ACC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAB0206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RixRN66m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAB0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGFT-00008Y-Pf
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1idEyN-0007o1-Qq
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1idEyM-0004bz-DZ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:52:47 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51443)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1idEyM-0004a1-4v
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:52:46 -0500
Received: by mail-wm1-x342.google.com with SMTP id g206so8123303wme.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=v6DcG/q6LskpbU7+BFpd5NgSOoqBfxqnbb2+YKX0aUU=;
 b=RixRN66mTzjNLzw9/wdPdDaNncVowkyByDe/xaqpM/KmZNGasB7wRnpNmfW/4srtur
 fiqyX5Y7ydd9imOTRThsz9GEvgGWBMOHcV9mBhEe70hAysgwD92CmOXtPqJtUael66LR
 Rq3YHSgAokb+H//hg+22sXSsDCpOfLLlIvKEFeI3GufhOWcIps03v+pmNxaIQ1wY04m6
 Cb5duFEAuDk60tFczQ+NZtiImGKLYa1DdjyxOHQ7MuxV8S98T9q3wN4F0DCUbADLbgiE
 QJ9E4i0O281UfgsFLtS+97xeMq9wS0nkpkoTXgBUwoZxF5N8UF5GP4xZ5U9h0UkO5x9p
 KCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=v6DcG/q6LskpbU7+BFpd5NgSOoqBfxqnbb2+YKX0aUU=;
 b=gE3ENg8Ol8cGtu/B30teSAovOoJDe2wiJpmrljvTWtPaByTkGPtG/2rcwu5o7ifx4U
 3Lud4kRDltEx38PEmUtvfjPrcZwDtD5z0aKAyox9vPF4LTgxBq00TqE/cR6B8Bti0bat
 ZD/ZMIDJi4VqUWBIWd7zxmlKxO+Vq+0UtgctmQZBzZJIFsP5XOPAtuDKYfVzYA4CVOec
 j6U8v0nfd1i8J65VZtv19Zs0lJ8i2Vg3Da3BMa7cqASbd1kfUlZujbmgAyRuap31C1jJ
 Bod2aI9afIVcaSauF8+UWMW9iH4OOCLuhmLb7XyNrDkmxwe8Ed0omN4EOrDc1PBoUEw+
 7YyA==
X-Gm-Message-State: APjAAAXyIgla7wg6omx1GYT9ywgvOgLUJ0vZfhY+VSX9OBZ9rxTZ9w0b
 GUalxwlO6Rj4D48Gj3B5W1iP4Q==
X-Google-Smtp-Source: APXvYqxg7JhQmObIGzYli6D55JfJngNCGYSXmxKga1NucZL6ha6xidbWhOpKpPcEQG3uFzTnfVZUWw==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr10546332wmc.129.1575643964831; 
 Fri, 06 Dec 2019 06:52:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n16sm16506771wro.88.2019.12.06.06.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2019 06:52:43 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DF7701FF87;
 Fri,  6 Dec 2019 14:52:42 +0000 (GMT)
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-12-alex.bennee@linaro.org>
 <9362663d-6452-39aa-2a8d-1cfd853d7faa@linaro.org>
 <87o8wm7k6v.fsf@linaro.org>
 <cc54dbf6-01ed-f92d-5088-efe7e917b870@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 11/14] target/arm: default SVE length to 64 bytes for
 linux-user
In-reply-to: <cc54dbf6-01ed-f92d-5088-efe7e917b870@linaro.org>
Date: Fri, 06 Dec 2019 14:52:42 +0000
Message-ID: <87fthx7bgl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, qemu-devel@nongnu.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/5/19 9:31 AM, Alex Benn=C3=A9e wrote:
>>=20
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> On 11/30/19 8:45 AM, Alex Benn=C3=A9e wrote:
>>>> The Linux kernel chooses the default of 64 bytes for SVE registers on
>>>> the basis that it is the largest size that won't grow the signal
>>>> frame. When debugging larger sizes are also unwieldy in gdb as each
>>>> zreg will take over a page of terminal to display.
>>>>
>>>> The user can of course always specify a larger size with the
>>>> sve-max-vq property on the command line:
>>>>
>>>>   -cpu max,sve-max-vq=3D16
>>>>
>>>> This should not make any difference to SVE enabled software as the SVE
>>>> is of course vector length agnostic.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>  target/arm/cpu64.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>
>>> 6 is the largest size that doesn't grow the signal frame.
>>> I imagine 4 was chosen because that's the only real hw atm.
>>>
>>>> +        /* Default sve-max-vq to a reasonable numer */
>>>> +        cpu->sve_max_vq =3D 4;
>>>
>>> I also agree that we should match the kernel, but this is not the right=
 way.
>>> Changing max vq is not the same as changing the default vq.
>>>
>>> You should change the value of env->vfp.zcr_el[1] in arm_cpu_reset(), a=
nd the
>>> user can increase the length with prctl(2) as they would be able to on =
real
>>> hardware that would have support for longer vector lengths.
>>=20
>> No the intention is to default to a lower max VQ because...
>>=20
>>> Also, I don't think you should mix this up with gdb stuff.
>>=20
>> it is what we use for sizing the registers for the gdbstub. The other
>> option would be to use the effective zcr_el1 value at the time of the
>> gdbstub connecting but then things will go horribly wrong if the user
>> execute a prctl and widens their size.
>
> Why would you care about the size of the registers as passed by default? =
 You
> shouldn't need or want to change that default to make gdbstub work.
>
> The gdbstub should be passing along the vq value (via the "vg" pseudo-reg=
ister,
> iirc), and gdb should be working out what to display based on that.
>
> If that isn't happening, and you are only changing the default so that gdb
> quits displaying massive registers when they aren't in use, then you're d=
oing
> something wrong with gdb and gdbstub.

Currently the upstream gdbserver sends the XML based on the VL at start-up.=
 It
doesn't handle changes in the vector size.

--=20
Alex Benn=C3=A9e

