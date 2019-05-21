Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A502C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199622173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vtx/O0G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199622173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56833 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT7xM-0007DL-66
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 12:49:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hT7wF-0006te-E8
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hT7wE-0001b7-DV
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:48:31 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29]:34198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hT7wE-0001ac-7M
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:48:30 -0400
Received: by mail-yb1-xb29.google.com with SMTP id v78so7384318ybv.1
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to;
	bh=tc1a86UAjbdhy3JE6EcH6RFBD6KFgIQGm85kn3VIWk8=;
	b=Vtx/O0G7mU+e7ti1XnsdYbV2DOeLKjTCZAgk+0L6oXdIDFjooebkQkh+xUR5dRzX8C
	l2jSMKUwQHtq3A8HdzMrqMGIrWRQoYYz+UvUmtUG7Y3pGH3tBMrS28ZdBwt3lYCefDdE
	gyFrve8kRFQDVJvSW3BhZG2BklryCNJXSWDkFK58dX1ecdygcJXC0eiCP9/aW9+HfBqZ
	k256AUVIHZ6bG+rnNQOaSb/lZ1dJuplWi4bs9Ac0cgMl1CXs1pVlnGzhLxUt95Fa/BfW
	fiWc6SQHXY54V5wmyjdResU8THERiT3Oj+K7lat6kM5EweK5Z/Nz8JQ/q193glYOF+xX
	JllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to;
	bh=tc1a86UAjbdhy3JE6EcH6RFBD6KFgIQGm85kn3VIWk8=;
	b=LJRx0jluEc/f2E5rlsMu63Cc25M751UUhbDeXfaRFzI3us22wTx0hA7mKehJAYuzVn
	/TColRzXi5hFV/OpIPF9XX+twx5e/jRJLXQeDIKO3wI1xjdB/UkVWGKbZaVjlQ0+3Ez4
	oFJOEAHPAuN6AEAaRFy5cxdQg29oNL4kEDBkzB1Y9TJCbwRziOh7VAHScobkYU9KAFIp
	Wd/oxfnAKPjVh4EaFalo/XMcTqa6AnCVB3eE3AnaNWu7Ed71052zzlJswEETjy3sKn7k
	rL8cnAfmHRTWNfzoVr7yIi4Lw5vtOBgDs86fSORmzU52CezBrrJ5lCPwGSygyE3Vrcab
	hyVA==
X-Gm-Message-State: APjAAAW22yDsVVTp42lWpZIuuFJbq0T3Eu5zOWtxK3JB1PvsNGsh8ZxW
	3bY+TDdGFjsgp4/1oDpm7636qlvV
X-Google-Smtp-Source: APXvYqxDYDuq2B1cJOcvk9dl5lGPJySSwjGHl0vE27KFjlnv8Z/NqaDYxsllISQX8s8wc4/I/8S0fg==
X-Received: by 2002:a25:8587:: with SMTP id x7mr4580369ybk.163.1558457309194; 
	Tue, 21 May 2019 09:48:29 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
	[69.222.133.165]) by smtp.googlemail.com with ESMTPSA id
	j188sm1997434ywj.18.2019.05.21.09.48.27
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 09:48:28 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-8-jan.bobek@gmail.com>
	<87zhnhgw1c.fsf@zen.linaroharston>
	<CAFXwXrkiShudOkAKks7VwB5-tUskeY1pfSeftvS8n=ez8Zgeog@mail.gmail.com>
	<87h89ogoo0.fsf@zen.linaroharston>
	<eb8797f0-c615-e60d-0bb4-990e08901883@linaro.org>
	<87ftp7hljt.fsf@zen.linaroharston>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
	mQINBFbeakcBEACzYOxOXdeT3Ns+5fdSqZFODAb3VXBKQ9DL7ooxLQRhvAx6rKXP/ZkBD7eg
	q8DJuvx6FbH227wpX+JZQawtolRJO+BTOuyU4ANPn3LGQHNtI78VhjafK7/Geb/9J6mTLl+P
	iS1EpLjKFbaLQboOaVVCPOHfLJOMNm5Ks9iHVKPQcUWUnroZdm55MIWjRw+wYGpmLD/R+FK/
	Cm1fS3j+tu9VYFoEFZmwW//PYzmEtYHpwXA6dOWEd12cu2208/JcEHYBl0Z6Oga0xAk2OxU5
	BOELuewGLuSiWik4z594GLVleC2NMnr3gUPl1y8ADrKzQwYmPgytIdsQ0tkV5rK9R1XTk03e
	ZLViYWJt5dgea+jGWcHPKPfLln53V4nCbwklGFLJQDMo8hL82bjJ7x9bsXoAnkPxJgYHgsM0
	LCLewqEIN6khniNv/1vOAKnwoXywlIKsWrx/pFz4xXNLVHoLlkRUl1DeWWzuaha2xEsm0yfe
	QkntqMrHC0CkBFzM1/ZE8fj8JBMjMG8me93RK9mr03TV4aROgQfi4Pjy55VKal/WpVkD4tKo
	nTN0nHkPVsHfx+htN/+A3nnUFyfesE1wWdCxhqhIn8d/Aw9KqraYmbyTzRErXLadA4O0UmZZ
	yPyNWQhTgGfJ9r66S+CifsiHkHlzJ/9i9AcHeh6+rXs9gjk4YwARAQABtB9KYW4gQm9iZWsg
	PGphbi5ib2Jla0BnbWFpbC5jb20+iQJRBBMBAgA7AhsDAh4BAheAAhkBFiEETAzi4j5xV5X9
	nNm0vpyriGq+2b4FAlwy32MFCwkIBwIGFQoJCAsCBBYCAwEACgkQvpyriGq+2b6NPw/9Fi+N
	vmxMd81Oh3hHUZlh8fNqcvXmHqnKHslJJG9M8CXkWcd1cF+sWX+lhi2Pvi4KA2Ng++NEpi6p
	sPrY9ZSPb4gAQYFgq6aXonnsrNSHeBMZI0E2mbK1YW4lYYJuMpqotBKqpgpoP9Fd8QbBR9vA
	Dm18fcDQFJP0vBmLY2TWo2tdqUH1X3z1xpdADpdjMZeQ+LrQ823Vi8ib0aanaR+gJ+20w7tn
	M+iTAGSz9jj+IAjDvrt6dpgwKaN+sFpqQFr0ClItDgtWWChIOEo7AVxK35jEHZnRpAbSvX3q
	WxETfA/1/UiDD67FQ5mwzTm95oYw+bN6jYpQgv9BkWeOhvVi63bcQ212B5w/YJ/WysriD2tp
	j/cTbVBgW2Al29fbeKyqdCr43yqR0ZyZcKuOKpwEtkF4xo3Z4ZR6x4uZewCjNirlwKDSI9sE
	w137DWzREIk7sd2kZrMnFAjVOTVic8fs+jCeohuy6Eq7l+lMCWsyJTcXSY3HHmXAgoQu8HRE
	uwQB0H5rTWn4Hz/2OtWlYHxHcqGwcUP3bdxqch001JwycoYJFnqM27whPussfxRK3i6d0CiX
	8N1lwBb4ukIH8y5ZFmdhMA960aTGVpeew5fnzRveZj2Fn6kPZX7Z5t0eXpdl0sYyKvxPy/rP
	9atlD0qdA7LSBksLIoSQ5EE+rfhAvSO5Ag0EVt5qRwEQAL1zSWDNDk5M7kPTRuonvez0WbBq
	Sl36BBKMSsAVT7L5TTksQH0T/5N7+vTIXlOTefP2KN+8uITUR7Ld2grjdcLIpx86ff4gVmuv
	P7Xc0wKd/dmDPVqEtBKbCPCtnHznZWUWe/zJNru9aE2RwumMjMzAqXX8VEzy+XSqToneX1a2
	+k6+4ZRWvrJ5Kb+5vs+ccw5hQlWyF7vruUNLLVO9LgPD4BbIKyyhosuVp8PtJqdsz27eb3y0
	oh4ThSwx+S7lYucUB30HUtqBWJ9gMiqmXDLEhx+3v5wxCWm0oko9nnwk0PstRkZ39WAawnix
	gpQ+3Gw32yFZaDOEbfbob2+Tyc3/NA7aTnllvK1ihXaHr7dzwbE96XSEsz1RPOl/Cn2cZ0gY
	1/kMzUesBqrlyBIGl9TY/QLu3z2B/INwc/ZlN3oEIJRXhS0KvtUA8tT4NSXVz8yLLO7tQv/g
	tSP0B2jsZRhm3QReCJT/cNmlOJ3O7b835Vpd+QbFoyCbKRcT6dVHl+Ay5UZykihg45HXDwtl
	FRgYUh7xJuxHnF8SDMlPcFqdOocPXq/fgfbxDFhLOFIj/qzEI892wu5lxfDGn9u8KCZ8p55N
	YSlcLOYlvDfCr5/syBWqO928XMOXdmQqhUFsP2aV0L3pL35qh7kfsAdSN4S0KgdQq4DUe8Mf
	+GXaHyIVABEBAAGJAjwEGAECACYCGwwWIQRMDOLiPnFXlf2c2bS+nKuIar7ZvgUCXGyXZwUJ
	By12uwAKCRC+nKuIar7Zvj4mEACW5/tViY+6MMv4Qh7zCXTmyNOepFjaSdbeBXpgL6IHbO3y
	kH5K90vCGl8rgQvIxOnX5cj/o1/y8NnfJ+lv94Hlqg9DkDHt4V2Zu570gIs81dlhxOqjZh/h
	14LLigmx699j6ZfpRksuGKS07/3ZomrBBsMTzK+44+BXX1zLBqSamwD038TAq8n9DwILAVma
	5C814/i1OciQz2HhK6QH8hMFMtX/8E//B6Q5oy9GPjrznYy+Wq52cmrwX7asqTkJ8q+oryaO
	I/popEdiE2boPz2KTa2fti2otyhU7Qc1iTdvIoUxyXZtQP7bI5RspvGHk6IP+5ksOdBjG6D6
	IifJ1gw7cHip1mxz75uFb52jscIjkdSDhveAiSqnwAlMBy/UD2QVwTTL2o34jXwofkK+I20S
	J5kDhUuqYrsD4zMGHX/PWa7w7oeUU3cHejj0KI6MrN6LdvYPckycglZbS2AKUd82m6XES8gA
	2pVPSjTH8BQKQ/Bbdgt7X416igU0nfpuj5aXe3NuLSO1sJbYRGFERTkUgxZm/RpRytGL4SPt
	PQUBJBl8uNYwyN5Y19lwsghGFPeYeTgcPsaEf6YsLVwozZBId4WNDAaVgnxibxH4Xjb6JkwJ
	2W9jjN3tvmY+O0w1rnvRIJ99Btq6Qls7Nj+tdDDEKhufxpRrHTmwBUuLN+zZ9LkCDQRcbJZM
	ARAAvczli16jbnLXksVpMj0Z8JRiIdJvE23xofalA4R+Y5oKrK+mcpTUcb+XIdkArrQNQQtq
	pgPHLI5Dn4urmgs4E9KlBe+4fQBIzP0jyx8wH1MjhGak9QQXpLL5Z6evUdhjuyIoAb5rUgOb
	yl+wu9vmIYsJD4HzYul+nQkx/RxTZ3/OUN5JamL7AoAL5dHKOSpEUqRHq7ZoNqn6OGDxRInX
	dgnSs0SDYVAKVK7B8iFhEmdFXN25jOXLAtwtAh9cVGISfjEQftlvnoLQ6g+UbJ0XMWr6Y8pf
	mfOXPEoP9takIlhoZqxFiJ98lHtbkJ2u0hDTuAYe+HxBZT16bcCsucSITC6h3qQJTMxJgQ0C
	5fA23ZUA9l4RszA7Lb6/wxIzko2jzZDbMaK8tsX5hHn7pJoPA34w3sY9hocMn707PWcxVVYf
	zl9YL3cAqcbD3hMTi3v+ukw7ArQ8sKaSYMBBC9GH54ePmiLpJ3wOsgNxxeIVvnCjVwMms8Br
	fLfnV+kuB0GABOOCsVXLkS73VjpouDzZ9k7SuZ+wVPZbJfgqLIHOT/j2nyVYVQCmzZ733E2c
	1/Qywe2hUfZz5NWg4fFiFywBGqcHCoeMjDuZgJ6VRMxtfAQhC3FWoLrcQYhY3l1MvNToIm6M
	4quvsQcJ6CMnVxpu1ULAhSkpmTvsH0BCjWeYLBEAEQEAAYkEcgQYAQoAJgIbAhYhBEwM4uI+
	cVeV/ZzZtL6cq4hqvtm+BQJcbJqwBQkBn0q2AkDBdCAEGQEKAB0WIQRI9g6q0xHepFmsS61l
	6DaV2uM2zwUCXGyWTAAKCRBl6DaV2uM2z0m3D/9ebunqJVHvk1pIiJ29GfzXqUIVCyG3aXyG
	T0RwXrQ9mKil+6/zLvAWh9NeksSIqKFDCQkC55WTUd1jL/lpDdipLo32BBLG+N0L40Nab1dM
	QldolDWocwmJuD99bWJmd0bkmVGCLDiXVgOyec8BFggixnqVEvrz7Sh0lP9tnsb4BE7v63Q0
	q8uFt+n3swBvMnbjbNs2uGCyRz4f0tasF3Dd3R+08LZydrarJ15C0Smqghjald8UmJNi7uvI
	ZVwcEHSt6imp9gd4uAtcis8ebXkwAkWhW/n5DCpNVlZ8ve3haA767SJCuf4eIcPLIwW9KcgE
	nZ3zQPqclkd9TEmttIxk7C/MoRjxNC+gkyAMQXksxPIDVutythS8JVacMSaDshFtO0RiZ/mH
	e4oGdsBcRhThM923M9iMZAM1XLQpd5Pe+VhDsDN3+QXwkDH88t7tocamj/Ew5UT8qmZy7BJt
	vtDPeybOgxgiVDTlvEARUHK20UiLa7l8HEnJNInlSjakch6MF6axI1Ye81Ahc/snl5PP1gYl
	lmoQkJlRPTYgH/NLtRqcECff5pjOtUEoWWXrxRSKc0QRsTT5DhC4Z2CX3p6k0RDeMvZJnbyV
	geYWFyT5YBPvZBf0meL541JsfvTpOhcfdk//2RvMsyxNaGeemvWQEJKg/C/fTH3So3pEmPkE
	GwkQvpyriGq+2b6xKw//ToIcWJv1S+COsfuCZLTPL0f80pIr7yFYGcOcEfhbkdoZHAcWZP/X
	50NeUuSOYGoT6+pU6a6lvycB7JTuAHuSIHo8HpIPF+sju14FN47Yd1n9akW89HLeSzR5paw3
	g9FD1TbK9uFmK+bxMREAj1Gtd7qcummK6ArpjkEdOjwPXBz9n1iVo/Jgq11Mbhg8TYCP8WRw
	8Lv+znH/cTSTgDxM92S79wDuFoO50zhlWzPa/g2prrUIxJxs74uBEGYy8LulRv25MfdQJVAY
	YE6+HYAJL6S/ko2m6XCr3hLsnD0kXamzvpJtDhbgBcXDd05XDjEFurZTOWv+thwVb+BAedhP
	XrH9DQ7/VUQBHnXz1ts5NYMjBI5NC1d16DYPtkCY0N9Jcv+fyJlAYpS7PHlZsyZmK7uUbm6p
	xRARxxjf+U86NTBAtdnDIO/NYxhX587vXuTm2pA2pnkKYTK74QLc/ys6rO3Cwo2QSFkxx3UZ
	uD1PmEfcmmfqPmuv037Dzpe5hYj5csGsdNLMLSK1WZqaAhBAtCnh3Rme71Je7f+eObRAHHGZ
	sftsaIi3kpdIyUnKybZhViIlXs8Cde5O2HCI0NhHnaDnxKdmHaIZVlH1hX3koaRrWCeGjts1
	WWOVGHwSUSJ3lpUXEBHBicrX3bH/vUVTNTnwzGLSf/23VC9WYAe69II=
Message-ID: <a6b08718-4c64-eb8f-3663-ee4dfdaaa9fd@gmail.com>
Date: Tue, 21 May 2019 12:48:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ftp7hljt.fsf@zen.linaroharston>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="2UGIQpxHSB0EmKdPDWG48dmEDZBw3CoBP"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b29
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RISU v2 07/11] test_i386: change syntax from nasm
 to gas
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2UGIQpxHSB0EmKdPDWG48dmEDZBw3CoBP
From: Jan Bobek <jan.bobek@gmail.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Message-ID: <a6b08718-4c64-eb8f-3663-ee4dfdaaa9fd@gmail.com>
Subject: Re: [RISU v2 07/11] test_i386: change syntax from nasm to gas
References: <20190517224450.15566-1-jan.bobek@gmail.com>
 <20190517224450.15566-8-jan.bobek@gmail.com>
 <87zhnhgw1c.fsf@zen.linaroharston>
 <CAFXwXrkiShudOkAKks7VwB5-tUskeY1pfSeftvS8n=ez8Zgeog@mail.gmail.com>
 <87h89ogoo0.fsf@zen.linaroharston>
 <eb8797f0-c615-e60d-0bb4-990e08901883@linaro.org>
 <87ftp7hljt.fsf@zen.linaroharston>
In-Reply-To: <87ftp7hljt.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/21/19 11:30 AM, Alex Benn=C3=A9e wrote:
>=20
> Richard Henderson <richard.henderson@linaro.org> writes:
>=20
>> On 5/21/19 5:08 AM, Alex Benn=C3=A9e wrote:
>>>>> We probably need to zero or reset the xmm regs both in the test and=
 when
>>>>> risugen dumps it's preamble.
>>>>>
>>>>
>>>> That gets fixed later in the series.
>>>
>>> So it does, but I'm still seeing the test fail when played back :-/
>>
>> Um, no, I mean this test is extended in patch 9, exactly how you sugge=
st.  Are
>> you trying to run the test as seen in patch 7 against the final
>> series?
>=20
> Running against:
>=20
>   commit 555748b35849ad4d354a9a3cd7f8549994b2bea4 (HEAD -> review/i386-=
support-v2)
>   Author: Jan Bobek <jan.bobek@gmail.com>
>   Date:   Fri May 17 18:44:50 2019 -0400
>=20
>       risu_reginfo_i386: accept named feature sets for --xfeature
>=20
> fails for me.

I get the same behavior, but it only occurs on 32bit builds of
RISU. Specifically, in risu_reginfo_i386.c, lines 172--178:

    for (i =3D 0; i < nvecregs; ++i) {
#ifdef __x86_64__
        memcpy(&ri->vregs[i], &fp->xmm_space[i], 16);
#else
        memcpy(&ri->vregs[i], &fp->_xmm[i * 4], 16);
#endif
    }

In the #else branch, fp->_xmm has type _libc_xmmreg[16], and
_libc_xmmreg itself is a struct with a 4-element array of uint32s. On
my box, this gets fixed by dropping the multiplication from the index,
i.e.

        memcpy(&ri->vregs[i], &fp->_xmm[i], 16);

I wonder why Richard wrote it like this in the first place; did
fp->_xmm use to be an array of uint32s in previous versions of this
API?

-Jan


--2UGIQpxHSB0EmKdPDWG48dmEDZBw3CoBP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAlzkK9YACgkQZeg2ldrj
Ns/m1w/+LBKbvqQ1XEpmSujZYQQ/17i3OwdysBx3YR1DuG29CuN94Pkc1tTQsPOj
Z73mcmo35tUwKjfpZKquoma8NAAX4RvbO4ENCLjvKLADmQwfrUVCwdAv/M12rBgz
Tl8edEAFwk5Q6qHBp3+knUGnIajwYZMHxJrtGrvfOtsKJmWn2A3QNIoegXwBLD8b
wRWU+panU+oODIHpDSL/l+h0kJHdXUDij5RlZpMbl5scULrxfBGlT3K3TV+nJaki
TW9/Ogj2tFuoyj6VBePUzIlF7UZbdooO9Z8h5UYW+26bkhmS/PFTFpJdl6Y1iZLA
yIQeYEhMA0ploLD+ciVZHERlGNI7xHyVr5dzc14YBNFaCbAvWUGN47NP/V/zowo3
c/BWc0gg0IW8qMSVWUP1Hq10zN6msV8bh5R9vmTdOZZ5BcWb052i+M2VL8+m0NLX
9h7rVlE8ZRbE89j0O1B/2m1X0Y5bCRdGhmPtCPcI+ZvJqCJfCTjLhMqM34qMXCes
XxXCzhYkPY8P9ScdMPikbZK8IXUTHFJvmZOguMJd/Eyi4DwNl0dK2cniVJJWZ+YF
Og2U9DpX+1DE1vB7PlcvfGwPuK1CpVqJ6mG+dwIon7A0mtkrgCY6ctEwUP8FkP9/
vy7uYcTO+qZLxFx8vPdobNsIdGCVpz2AFWfMUYfnhnffbPuyqx8=
=IvBn
-----END PGP SIGNATURE-----

--2UGIQpxHSB0EmKdPDWG48dmEDZBw3CoBP--

