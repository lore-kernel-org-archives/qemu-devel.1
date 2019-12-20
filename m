Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567B2C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2176F218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9rl2UMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2176F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiI9Z-0003v9-A9
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiI74-0001rT-UF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:14:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiI72-0004Wq-K3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:14:38 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiI72-0004S7-8D
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:14:36 -0500
Received: by mail-wm1-x344.google.com with SMTP id b19so8884888wmj.4
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=btD5yRalaYI5vvzjuXayo8zlynxPNf5xSt7Elyr7OSo=;
 b=a9rl2UMj+M49MjmVFmJkZ+T8q7CkndSvjoz4zRV1zxNcHHhLvxVSmdGy4xzE9jWPnF
 f+100SwaxTe+BBVMImxaYaz78+9Dxih6+pifQ0CD7ETNywGtmCfa/VtqfR7NpDrPIzyj
 BCDyfZtYvSwp2s+pgZQhFWlscZbVbYqEKympSYs8B7rYwYOijNYD5UdvWI202ETrq3ij
 3EWYma/Z7qlaujEvrZW7Ck/bUYKLkQz1hsoo8M5sgAIrbNSEIwZODHSN3+z0bA5CtTzD
 w4l+9eQNKBSI6b4fRTSCTCz1uhQi/sU2qrk+YBNDzmHacWB4mbICMaqUwBmYKNNb8rs6
 qUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=btD5yRalaYI5vvzjuXayo8zlynxPNf5xSt7Elyr7OSo=;
 b=HG0vpx7zP6GiDW8ZGwbllCKbHwFKMKBlLf5UGUv826Rg8jUOzI7C1QynnEFOLmN5P+
 VO3E7BsxGmKlRrfT1SbKLSumIiHbU9diKtUZyuIzc5uzGEUQiLN125Z9wyKsrJsKKs1K
 Rs1xvIIoelHqacW834/qzUxrCwL3IkSLEAgShMAjmnMMzyDRynM6Y/6CxJGXUzOfqr7p
 Rxt8Ce53gjfu8L2RZI525cSHFe7eb6di7ChomB6OQyZAJxPcmhYHG9X1HqKRJJubnAm0
 C+ifn0pdlqGpOODuDi0Aqvb+Hh7IAsFfzRdelw+4NZZUn9tfYrJZjES4izK28d/Fl1pd
 R6OQ==
X-Gm-Message-State: APjAAAXcqsWATYsyoLQKZgMq4y65hLzicfKQ4BIZCU2tz+RMqB6MecpI
 GMvTFzzt42ErssZZEEahdXr+6g==
X-Google-Smtp-Source: APXvYqwM69OXXL8co3KPMxS3F0XUy0DOf7ybcVvkyikrQz8fpgsqpZmC7I3ybuOfRKeko2N9cS9ebQ==
X-Received: by 2002:a7b:c765:: with SMTP id x5mr2981521wmk.129.1576847674887; 
 Fri, 20 Dec 2019 05:14:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a16sm9666449wrt.37.2019.12.20.05.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 05:14:32 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 915261FF87;
 Fri, 20 Dec 2019 13:14:31 +0000 (GMT)
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-13-alex.bennee@linaro.org>
 <69e10c48-8bdf-cbe0-3372-815b647f8312@linaro.org>
 <87k16sdt4d.fsf@linaro.org>
 <5c6dd0a9-23ba-63ff-5738-8bac11aad810@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Luis Machado <luis.machado@linaro.org>
Subject: Re: [PATCH v3 12/20] target/arm: generate xml description of our
 SVE registers
In-reply-to: <5c6dd0a9-23ba-63ff-5738-8bac11aad810@linaro.org>
Date: Fri, 20 Dec 2019 13:14:31 +0000
Message-ID: <87eewzdtqg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Luis Machado <luis.machado@linaro.org> writes:

> On 12/19/19 4:15 PM, Alex Benn=C3=A9e wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> On 12/11/19 9:05 AM, Alex Benn=C3=A9e wrote:
>>>> +static struct TypeSize vec_lanes[] =3D {
>>>
>>> const.
>>>
>>>> +    case 51:
>>>> +        return gdb_get_reg64(buf, (cpu->env.vfp.zcr_el[1] & 0xf) + 1);
>>>
>>> You need to use sve_zcr_len_for_el to get the effective vq.
>>> Also, I thought vg =3D=3D 2 * vq.
>>>   > +    case 51:
>>>> +    {
>>>> +        uint64_t val =3D *(uint64_t *) buf;
>>>> +        cpu->env.vfp.zcr_el[1] =3D (val - 1) & 0xf;
>>>
>>> You cannot hard-code EL1 without ifdef CONFIG_USER_ONLY.  If the effect=
ive vq
>>> decreases, you must call aarch64_sve_narrow_vq.  You must call arm_rebu=
ild_hflags.
>> I'm just going to drop vg (and therefor the ability to set it) from
>> the
>> regset. It was only meant to be an indicator and gdb doesn't actually
>> look to it to size it's output. The likely dynamic extension will just
>> re-transmit the whole XML when a change occurs.
>>=20
>
> I'd verify with GDB first if vg isn't actually required.

It works with my tests but perhaps we use our own namespaced XML rather
than the gdbstub XML.

> From looking at GDB's code, it does set vg as one of the register
> names, and this is regardless of any XML input. It does reference VG=20
> here and there in the code, even though it may not use it to size its
> output.

But this is all special casing for feature
name=3D"org.gnu.gdb.aarch64.sve" right?

--=20
Alex Benn=C3=A9e

