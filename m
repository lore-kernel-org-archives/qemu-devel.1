Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AD9C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CCA2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StNvJkp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CCA2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34359 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQqXQ-0002JI-0D
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 05:49:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQqWY-0001wc-1t
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQqWX-0005aI-5X
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:48:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hQqWW-0005ZQ-Va; Wed, 15 May 2019 05:48:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id b18so1876253wrq.12;
	Wed, 15 May 2019 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=snP6xlV/bJghWE2y+NGuK/7WjpM0BgAYBEt+nfTQqsE=;
	b=StNvJkp/Kzboty4LFccK9kf0fs0HMYwEEq117L8heTYYU2jilCJnsQCXIgnhSlx1+P
	Pj9g434MmjuBnxbPJFCrnHKgWBed9K8GDzOd7jT4HS2kZeRsCivYmVBXG8nDjxZrKyIZ
	MBULIsNpOuS1fLhALzrofKtJl+PV/e6gQEWb52EB/hkJm99UtV4EgZQqcoPA0DpdzZRI
	3ih1z8b6psfQ4O8j/1Y/3CyJZ8HjQofcE3b9Ou1P+HZcYoEfRerqohn0NrV6g4PwwAlY
	RSEUky/kn8I1EXhNT9ybsmYUbKx5oEotx7s5oQl4Es6x/Eo/3LAktK65Zl+ISUVkBuLi
	cRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=snP6xlV/bJghWE2y+NGuK/7WjpM0BgAYBEt+nfTQqsE=;
	b=Gt3tbtGlJ7I6G1xNoiTzxJo47jqUBpOX25SNt+FOkWibHZuPTkJerBzejdvJThYky8
	lwAlS06LQfwGf6HmR1XMDVbGch7JuDaMFJQBfZH/e4dmazwniZ+GdnluD9kWUyh6M5El
	SeJ/luxiLWzqkEuxZMF8fVAH66pYNwjJvWlVJki+XZtrse9WaTDJB/kjDlfCqtPnZwTl
	FcABnKbzu140HCdDNYVoTPCQg9nna9AnxQhPya8Z7f8Yvb8+Ye7Dze+OoKOTsJKxQx7u
	wWO925/SErCJgvQKcf7BoptegYcMXnLrK5OdeglU2TP+5IiQ4pVI+BZ3G/lr6UrTlBIZ
	y8tA==
X-Gm-Message-State: APjAAAXFmSYtYoBHDCR25P+z51alVpZE8avkCKCessM3JVbqa3rY52Va
	0kSfHcMpvNxl9vacX8r7Nac=
X-Google-Smtp-Source: APXvYqzEPhESnYQpXivbOjrMJ6/dQgqgp7FLirn64UGcWyeY0/VqWOXVjRf7fTIKyP0/4ncf+N3Ahw==
X-Received: by 2002:adf:f788:: with SMTP id q8mr25343959wrp.181.1557913711937; 
	Wed, 15 May 2019 02:48:31 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	c20sm1814189wre.28.2019.05.15.02.48.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 02:48:31 -0700 (PDT)
Date: Wed, 15 May 2019 10:48:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190515094830.GB29507@stefanha-x1.localdomain>
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<877eb4c3jm.fsf@zen.linaroharston>
	<CAFEAcA_+baJCxf1vQMJJP2cwzZ3snyHNJTWWgUqo26vUPKfszQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_+baJCxf1vQMJJP2cwzZ3snyHNJTWWgUqo26vUPKfszQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/9] Assembly coroutine
 backend and x86 CET support
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 02:44:39PM +0100, Peter Maydell wrote:
> On Sun, 5 May 2019 at 16:41, Alex Benn=E9e <alex.bennee@linaro.org> wrote:
> >
> >
> > Paolo Bonzini <pbonzini@redhat.com> writes:
> >
> > > *** BLURB HERE ***
> >
> > I assume there was going to be a bit more background here?
>=20
> Mmm, could we have the rationale, please ?

Paolo can add more if necessary, but my understanding is:

1. It's required for Intel Control-flow Enforcement Technology (CET).
   The existing ucontext backend doesn't work with CET.
2. It's faster than the existing ucontext implementation.

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzb4G4ACgkQnKSrs4Gr
c8iWCwgAglScsmj9kwkDUgck25CUcYoO2dtWBR03qR5j4Y4taEAtXfVo5vVglBEI
axL33VAOdUuZwJJTAn4Ob2kGkusQDhcYg1vwd+HRjYGbECaa66Hp6ZI5+Ge8/MGu
CvAYkJSN0nIALmv5YYgArQf8PR7MOWH/5v6rKSreU++cl6x+C7Rb5P3zlOihG09n
l40h16yIguKkViUxhv6fOMo3ijlLdPIHiQaWZ/QJLrQjl6A4BwpOya1pOcuBg0XA
k1Yl3M+KSGinuukQG46KFrhmSVCr2PFF8/cdG78Hy2NepGBOgsS4v5hRgM3TcraT
+Fp8VoWQ/V34KxohznRb02ewUHIIPg==
=8bDw
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--

