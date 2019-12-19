Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F19CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B743222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9l4Gt7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B743222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii1I3-0007sI-9K
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 14:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ii1Gy-0007L3-4D
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 14:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ii1Gr-0002Es-8R
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 14:15:40 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ii1Go-0002Cl-2g
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 14:15:34 -0500
Received: by mail-wr1-x442.google.com with SMTP id c14so7108707wrn.7
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 11:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WdFoefIyBmEmGr0Uzh61Q3jXTyhvbdrVyQ7nh5f6AmE=;
 b=C9l4Gt7B4s4ujVu/sTR17tZJvFCbVod5yGQZXUDFST5By834c+cvnLPyTMSi4wciWU
 24F3RS+iGOupASA61Dt15SWuUmwmI8QcklBAcKIytGQ+FInly4TIU9dWj1oUj265K1Tt
 HJlxULyTY98IBvmcMAvNMkN/GnNGz4525Xy6KDVJ70Kh6WExvnuM+i9GfizMTxKyFvwk
 QKTh6fDyJrno6FwPK57kBd4rFMF7DivHjqDLiHidU6gLUTti8svTMLLIFtZlTS5fi2RY
 o5fmd4TLGU2o0AqwEhBl6reFkuwRajyouNmL0p4C1Fi0zqLqkIEcOHxjgCIgUuC1bu7/
 gocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WdFoefIyBmEmGr0Uzh61Q3jXTyhvbdrVyQ7nh5f6AmE=;
 b=nyHj+P2n/xAOGTYS5SLUGnSpc0f1sjF0ISCOLTxlND9E7VArfap9nVsEjf/wwx/Qv8
 eAnx15K3nrlyhyH9Il9Mq4c+cs7yGp5DizibyejE+p/K61ViOlL8URHvaZetvywnIHqe
 h+0zw55KkKm3snRfn949Bwl9i3f7mbnolm+aAeW0cbxoTachQohrhJ10omivhAiSukq3
 t1fa3wKlGZiaeAF5vODslPO/hQid8Vp/8Fls7++chS+RVLBf5hjoA4BMaroo8pSxYDxg
 TGFmUB5aTLa6iq2JnecBDeQu+GAOCyzHIX/3v5RErlNwNQiXSxdZ8Ig21JkD5yUKMsow
 FV9A==
X-Gm-Message-State: APjAAAWnb7RSFdASPi5VguF8WZlbshAdYAAPEbBhw7skOt2Z67Z3B8jU
 9R3jm4b5eB3kNm/muISFY5H4Xg==
X-Google-Smtp-Source: APXvYqyEJhgNDMsqninN1OqJnsXLx2jpKOkQEorDzivi5zZj0b5CNTZSN9BFcNTv60HjWjBpSI/QWw==
X-Received: by 2002:adf:a308:: with SMTP id c8mr10908033wrb.240.1576782932498; 
 Thu, 19 Dec 2019 11:15:32 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x17sm7156560wrt.74.2019.12.19.11.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 11:15:31 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7919E1FF87;
 Thu, 19 Dec 2019 19:15:30 +0000 (GMT)
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-13-alex.bennee@linaro.org>
 <69e10c48-8bdf-cbe0-3372-815b647f8312@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 12/20] target/arm: generate xml description of our
 SVE registers
In-reply-to: <69e10c48-8bdf-cbe0-3372-815b647f8312@linaro.org>
Date: Thu, 19 Dec 2019 19:15:30 +0000
Message-ID: <87k16sdt4d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
> decreases, you must call aarch64_sve_narrow_vq.  You must call arm_rebuil=
d_hflags.

I'm just going to drop vg (and therefor the ability to set it) from the
regset. It was only meant to be an indicator and gdb doesn't actually
look to it to size it's output. The likely dynamic extension will just
re-transmit the whole XML when a change occurs.

--=20
Alex Benn=C3=A9e

