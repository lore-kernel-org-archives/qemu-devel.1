Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08728C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94EF21873
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbbx/K7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94EF21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hquaY-00075W-V7
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 03:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58393)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hquaN-0006fY-Os
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hquaI-0005vY-2e
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:24:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hquaH-0005k3-OR
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:24:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id s15so25410120wmj.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=r5UtIMnXMaC0iUiAV2qYBafMcUC917/tq7OSxSWoF3g=;
 b=tbbx/K7nIl91ZgnCaCZ73EkI1JHNwYDnRi2tjCUaVjFL+PMkzRqoQ+p0bD2sUVbWxZ
 U/8ZG95Gr806i56ASPAymk32M2BjOWdGpztt+9r+VPWcfE8oIrtKsXCi+oAKblPCCt8T
 YyY0ncS5yzdY3P2DQhVwUhT7bZxZx4TLdJh5HHSmKMW+7CIz8DDmJxdSUN4D2zQXbpvg
 1REenjoxmPv2mEEYMY6IPFowH7L3oq5j5rapQxSMDrpZWDfXNRWWTGYtTlLdl6xa4ue3
 lvn3E+IYoeAw9pfvsKQW2alBY7SbV1z30jfyIwA+L4MJm0VDf52Mbi6AGjo+UgBWCCB+
 8Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=r5UtIMnXMaC0iUiAV2qYBafMcUC917/tq7OSxSWoF3g=;
 b=ucearoU5CtiuiBj8PidWLE9HsKToa9/uP7LEqWb7Y7qKsDWtMcZHMUBiZ9T3bWWGCG
 POou+RrL1fkCeLxYa7rpDHQeCx3UCmAJl82PRnpAa5mkg35M283nORXsDyFCoLD3NMcO
 tG5uNiNEJnxvokfOTNmj40nS7IPlZPOvG5NwbvMxniC0cCbJNzxF150qgVxColevXAQZ
 CgsnfeowAx/BDNN54P4KURdwWBCEPIWC/Kz/Mdmf8yBMUAF7H0UExKjyh+0217o8ia1e
 qfxD8HkwB3E2Weaa0/X7F+JAM5OHY41/wHrjJnGin9pUn55pq7o5rAzbt117auTARX6y
 uO8Q==
X-Gm-Message-State: APjAAAWutZvj7/j1ypyMDydEoJrMqn885TnThALBhwnql3W8dbkz8o9/
 sm3khzJSQm+jmJ1s5WAS1a3OPf1q2k8=
X-Google-Smtp-Source: APXvYqzzaDLzuoLX/L9AOlzNEqavLyX21zh5cZ8UGwMv37qBaLUXp8GJfR+NUl6R4/szdbmcWx/M6g==
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr77026551wmd.87.1564125846037; 
 Fri, 26 Jul 2019 00:24:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r12sm61078698wrt.95.2019.07.26.00.24.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 00:24:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C6ECD1FF87;
 Fri, 26 Jul 2019 08:24:04 +0100 (BST)
References: <20190723113301.16867-1-alex.bennee@linaro.org>
 <CAFEAcA9CP0cUkDR4qOKVgM1b2U1KNot=A-5OPEAOKu3=KpMyuw@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA9CP0cUkDR4qOKVgM1b2U1KNot=A-5OPEAOKu3=KpMyuw@mail.gmail.com>
Date: Fri, 26 Jul 2019 08:24:04 +0100
Message-ID: <8736iti7hn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH for 4.2] target/arm: generate a custom MIDR
 for -cpu max
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 23 Jul 2019 at 12:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> While most features are now detected by probing the ID_* registers
>> kernels can (and do) use MIDR_EL1 for working out of they have to
>> apply errata. This can trip up warnings in the kernel as it tries to
>> work out if it should apply workarounds to features that don't
>> actually exist in the reported CPU type.
>>
>> Avoid this problem by synthesising our own MIDR value using the
>> reserved value of 0 for the implementer and telling kernels the ID
>> registers should tell them everything they need to know.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> v2
>>   - don't leak QEMU version into ID reg
>> ---
>>  target/arm/cpu.h   | 6 ++++++
>>  target/arm/cpu64.c | 6 ++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 7efbb488d9d..61eaef924e4 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1605,6 +1605,12 @@ FIELD(V7M_FPCCR, ASPEN, 31, 1)
>>  /*
>>   * System register ID fields.
>>   */
>> +FIELD(MIDR_EL1, REVISION, 0, 4)
>> +FIELD(MIDR_EL1, PARTNUM, 4, 12)
>> +FIELD(MIDR_EL1, ARCHITECTURE, 16, 4)
>> +FIELD(MIDR_EL1, VARIENT, 20, 4)
>
> "VARIANT".
>
>> +FIELD(MIDR_EL1, IMPLEMENTER, 24, 8)
>> +
>>  FIELD(ID_ISAR0, SWAP, 0, 4)
>>  FIELD(ID_ISAR0, BITCOUNT, 4, 4)
>>  FIELD(ID_ISAR0, BITFIELD, 8, 4)
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index b1bb394c6dd..e88aadfd2fd 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -296,6 +296,12 @@ static void aarch64_max_initfn(Object *obj)
>>          uint32_t u;
>>          aarch64_a57_initfn(obj);
>>
>> +        /* reset MIDR so our franken-max-cpu type isn't mistaken for a =
real one */
>> +        t =3D FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0); /* Reserved for =
SW */
>> +        t =3D FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf); /* See ID_* f=
or details */
>> +        /* the rest is enigmatically empty lest kernels assume it means=
 something */
>> +        cpu->midr =3D t;
>
> I think this would be easier to read if you used one big block
> comment rather than being extremely terse so as to fit the
> comments on the end of the lines:
>
>  /*
>   * Reset MIDR so the guest doesn't mistake our 'max' CPU type for a real
>   * one and try to apply errata workarounds or use impdef features we
>   * don't provide.
>   * An IMPLEMENTER field of 0 means "reserved for software use";
>   * ARCHITECTURE must be 0xf indicating "v7 or later, check ID registers
>   * to see which features are present";
>   * the VARIANT, PARTNUM and REVISION fields are all implementation
>   * defined and we choose to leave them all at zero.
>   */
>
> It's also a bit inconsistent to do an explicit deposit of 0
> for the IMPLEMENTER field but not for the VARIANT/PARTNUM/REVISION.
>
> I wonder if we should put 0x51 (ascii 'Q') in the PARTNUM field;
> then if somebody really needs to distinguish QEMU from random
> other software-models they have a way to do it.

Q is reserved for Qualcomm - It would be nice if ARM could assign QEMU a
code but I suspect that's not part of the business model.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

