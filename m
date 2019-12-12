Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A423FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D9B214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/xr6rCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D9B214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifJmO-0008Vz-HT
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 03:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ifJlg-0007ys-E3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ifJlf-0005IK-7D
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:24:16 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ifJle-0005F2-Tz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:24:15 -0500
Received: by mail-wr1-x441.google.com with SMTP id b6so1737489wrq.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 00:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rxDuF8q057BBMFCFSCcmamg2/fH9WqJQOlSrvULGGrU=;
 b=F/xr6rCHX3dJUOncFVqtOR6c3PDPXjUbkjsSAwBorTyp5TgliBdxXQaG7+Cx7JfPxh
 lB0Pq3rFAwSmLkI5fQ88KyVB52Xn3ptfvcsKX86Mi7q+m64YWGhH9CFx8GatnTDpfpPz
 b7sy+O3oHLqwQM3P77oteerGGaE5/m4FAHNCHyiAST90e46iCAtovQFloRF85ourENU6
 HD2mejOaEfE21zihYCEB+6SSAqwOmKZDZNwc1Zl85ukO2vQE6CUzZISNebzkv8KqTPA9
 +gasHL14KsZODTlIKqFp6zp7APBv9OEAioHUliCWunlhJWdnzhv/rYXW88ZeRXDpUQNx
 T4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rxDuF8q057BBMFCFSCcmamg2/fH9WqJQOlSrvULGGrU=;
 b=B3H0j61UAxWF+dTGsXfof6EsQF7isuIR8MvDL9CO0un7J0JVYjz44zy3kMEqHAXg84
 XQ+YfwJHu8nUyZ4PGtoQ5MRZJr9zmvNyvZPxjf6OQkiUgUmCXmdjLJrZgwwAaSQjh/CN
 ejZ2e4tRWnR4gsNewNSj6KyHJVISJfdlZjorxapVqFTtkrYrozzBrJPwbMZQgOKB1TPf
 E8646vZ126KOGt+l6De4A++tlB6MRjtXWLuJxwJUrrE2towJa0Xw3/+kSqzXM6OvNAfz
 IToRAMBkK70GnqTbW0euslF0ljo4XXPrtp35f/+KFoRjJUus+IzSf/bncKLE0wW4/zaQ
 TcIg==
X-Gm-Message-State: APjAAAULqzv28OA6YVNQr8m9Z3MKX30AwwHADXDBX1hCzeFztVhBtGY2
 K0uZTSKfTUBmeWDPRf2vJzFHWw==
X-Google-Smtp-Source: APXvYqxf4wgI/yR8T8tYoBTudiWwU4pMkwZubN8Q0F69OSJLSvPj3yHVxk14tSgSjWOCZhA1NujBBA==
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr4722484wrx.147.1576139053386; 
 Thu, 12 Dec 2019 00:24:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 2sm5239886wrq.31.2019.12.12.00.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 00:24:12 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B3C51FF87;
 Thu, 12 Dec 2019 08:24:11 +0000 (GMT)
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-13-alex.bennee@linaro.org>
 <69e10c48-8bdf-cbe0-3372-815b647f8312@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 12/20] target/arm: generate xml description of our
 SVE registers
In-reply-to: <69e10c48-8bdf-cbe0-3372-815b647f8312@linaro.org>
Date: Thu, 12 Dec 2019 08:24:11 +0000
Message-ID: <87y2vi0x5g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

> On 12/11/19 9:05 AM, Alex Benn=C3=A9e wrote:
>> +static struct TypeSize vec_lanes[] =3D {
>
> const.
>
>> +    case 51:
>> +        return gdb_get_reg64(buf, (cpu->env.vfp.zcr_el[1] & 0xf) + 1);
>
> You need to use sve_zcr_len_for_el to get the effective vq.
> Also, I thought vg =3D=3D 2 * vq.
>  > +    case 51:
>> +    {
>> +        uint64_t val =3D *(uint64_t *) buf;
>> +        cpu->env.vfp.zcr_el[1] =3D (val - 1) & 0xf;
>
> You cannot hard-code EL1 without ifdef CONFIG_USER_ONLY.  If the effectiv=
e vq
> decreases, you must call aarch64_sve_narrow_vq.  You must call
> arm_rebuild_hflags.

Hmm thinking about it this is overriding the kernels competencies - it
should be read only as it is a "virtual" register. Given gdbserver
doesn't use the value and will most likely use dynamic XML we could just
drop it altogether.=20

>
>
> r~


--=20
Alex Benn=C3=A9e

