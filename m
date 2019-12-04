Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9B4C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B012320674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQaBBscU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B012320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVTX-00041M-Kw
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icVRH-0003Ko-F8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icVRG-0001Vv-57
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:15:35 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icVRF-0001VZ-Tv
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:15:34 -0500
Received: by mail-wr1-x442.google.com with SMTP id g17so8832238wro.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 06:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8IYW7MezRHI9ulO07zjZUORVo19/F+46lSOVdCk3OlQ=;
 b=OQaBBscUUwQqXcUJi0X4UQYY1hgx6OVNZBVjYxdfyLLABEid5WOUySb2r38usNA8IT
 +AbweZO9DJOI2uuanNzAdSjBVqtzLJiInAnUeaws1dqML0zqdyBeKbHNMthlTyPyDrC6
 jNSnbsjZAM1LBZI/lACONjzq+4dV29jhNu8OIwJ1wnm0dgbFjpLQsM+9Q6bgBAI5n1cp
 Q27cMRMjnjLTjFQwqBA46fT6wgQ/ToD5G1vTAQYeOEphky/xFsBk3hdIrT9Mhnw9SQC8
 3nFEg9kQveYghC9nNPsl16zthPqvOu7Ay/t6XS/Yi9qfsAT1Gxpmz6xcTK1COEndKhnH
 h4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8IYW7MezRHI9ulO07zjZUORVo19/F+46lSOVdCk3OlQ=;
 b=Aup4v5vHcCNlTtSRZOHaBaXF5N/089BcWqpT3pvk5fP4e7bChnS4zzj7Tr17/SDJft
 Xi5kzDZct2BiwkQnb17pEaPaIjr0YBl+QVFJywF41f4Y/SBmxr0tmbsHwzEq2/OCD3FA
 G6/eDIampq9nTOVs0uDKMFXNhEoR1b3jY5X3FFTyX6pJi6JFVQH9Oi3WUfmphqqa0pa7
 e+AlU4PYupmr/PuIpfoMMlOz7Yfaa7Iqw+lTt6V/A7MQ7gA5se39h22Y7oye3kf/FYpp
 885WYrwAYT6xEpygFv9OtxURWnGV834S4RHJzmfWHPzVq1VSSAbDVNI5h9s2HDf3bKHl
 p+JA==
X-Gm-Message-State: APjAAAXiWIQRQWrBZOydSPFfZu2iAheI7wxV3HGMl6FLWZTBH+v/6Z/F
 ZPLXC3mXTunRMu5vgE3PB4ouEKHEVJc=
X-Google-Smtp-Source: APXvYqzJFdWDdlLhHDX/VMEyL9O8rHQwdcxmAh5x9JYtuINV6cSBzP2S53nd31U13oWBUO/u42KtsQ==
X-Received: by 2002:a5d:49cc:: with SMTP id t12mr4107249wrs.363.1575468931791; 
 Wed, 04 Dec 2019 06:15:31 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 2sm8695183wrq.31.2019.12.04.06.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 06:15:30 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DEBCC1FF87;
 Wed,  4 Dec 2019 14:15:29 +0000 (GMT)
References: <87lfrtbtj6.fsf@linaro.org>
 <20191204083133.6198-1-thuth@redhat.com> <87muc88amd.fsf@linaro.org>
 <ce570051-eb8f-4184-8f1e-bb9ba3652f62@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3] travis.yml: Run tcg tests with tci
In-reply-to: <ce570051-eb8f-4184-8f1e-bb9ba3652f62@redhat.com>
Date: Wed, 04 Dec 2019 14:15:29 +0000
Message-ID: <87eexk89dq.fsf@linaro.org>
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
Cc: Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 04/12/2019 14.48, Alex Benn=C3=A9e wrote:
>>=20
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> So far we only have compile coverage for tci. But since commit
>>> 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
>>> for INDEX_op_ld16u_i64") has been included now, we can also run the
>>> "tcg" and "qtest" tests with tci, so let's enable them in Travis now.
>>> Since we don't gain much additional test coverage by compiling all
>>> targets, and TCI is broken e.g. with the Sparc targets, we also limit
>>> the target list to a reasonable subset now (which should still get us
>>> test coverage by tests/boot-serial-test for example).
>>=20
>> Queued to testing/next, thanks.
>
> Thanks! But could you maybe s/--enable-debug/--enable-debug-tcg/ as
> Richard just suggested in his mail? Or want me to send a v4?

I fixed it in my tree, no need to send v4

>
>  Thomas


--=20
Alex Benn=C3=A9e

