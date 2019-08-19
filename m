Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26B1C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8D020851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MA94Kmqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8D020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzbE9-0000ju-Pl
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 02:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1hzbBP-0007Sg-Os
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hzbBO-0001WQ-BN
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:30:23 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45491)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hzbBN-0001Rs-0z; Mon, 19 Aug 2019 02:30:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46BkYw36xfz9sNf; Mon, 19 Aug 2019 16:30:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566196212;
 bh=pE08KvxbI3PfuFhC3C3i/kZ/fwc+iIOZT6VGDi5pG7Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MA94Kmqjj0ODVCX3vto30cgIzkl+viH6gZSzZZoKN5iutJw60rAgzqwNM8rNFs1m4
 +fi+t+i2imuVTe62tiW7gI3OKjnHm8SUaJ6JmkAzn18DWdapTBHiHPLlN2nJxTlOEU
 ttamtELCPcmkPrX4lg+0r5dcCXi+P5zrhuzQtQwE=
Date: Mon, 19 Aug 2019 16:28:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Message-ID: <20190819062817.GA24503@umbus.fritz.box>
References: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
 <CAL1e-=jy6vggskJ26rTc8dnaqtqCB0SdfpV9p-NvKdjoBk+Vkw@mail.gmail.com>
 <0cfddc22-92ef-3067-9275-8f4f22ca9805@linaro.org>
 <CAL1e-=h=Hzfm8KZ4ebwaBsS6U=KVcReXpOPT2-vy4OeBktjWkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <CAL1e-=h=Hzfm8KZ4ebwaBsS6U=KVcReXpOPT2-vy4OeBktjWkQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] ppc: Three floating point fixes
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, "Paul A. Clarke" <pc@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2019 at 10:59:01PM +0200, Aleksandar Markovic wrote:
> 18.08.2019. 10.10, "Richard Henderson" <richard.henderson@linaro.org> =D1=
=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > On 8/16/19 11:59 PM, Aleksandar Markovic wrote:
> > >> From: "Paul A. Clarke" <pc@us.ibm.com>
> > ...
> > >>   ISA 3.0B has xscvdpspn leaving its result in word 1 of the target
> > > register,
> > >>   and mffprwz expecting its input to come from word 0 of the source
> > > register.
> > >>   This sequence fails with QEMU, as a shift is required between those
> two
> > >>   instructions.  However, the hardware splats the result to both wor=
d 0
> > > and
> > >>   word 1 of its output register, so the shift is not necessary.
> > >>   Expect a future revision of the ISA to specify this behavior.
> > >>
> > >
> > > Hmmm... Isn't this a gcc bug (using undocumented hardware feature),
> given
> > > everything you said here?
> >
> > The key here is "expect a future revision of the ISA to specify this
> behavior".
> >
> > It's clearly within IBM's purview to adjust the specification to docume=
nt
> a
> > previously undocumented hardware feature.
> >
>=20
> By no means, yes, the key is in ISA documentation. But, the impression th=
at
> full original commit message conveys is that the main reason for change is
> gcc behavior. If we accepted in general that gcc behavior determines QEMU
> behavior, I am afraid we would be on a very slippery slope - therefore I
> think the commit message (and possible code comment) should, in my opinio=
n,
> mention ISA docs as the central reason for change. Paul, is there any
> tentative release date of the new ISA specification?

It's not really a question of gcc behaviour, it's a question of actual
cpu behaviour versus ISA document.  Which one qemu should follow is
somewhat debatable, but it sounds here like the ISA will be updated to
match the cpu, which weights it heavily in favour of mimicing the
actual cpu.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1aQX4ACgkQbDjKyiDZ
s5Jg4RAAmchIl8LU+qcrSA8B1VHE6H3f979+v7YYInT9NgUPWUtFKlvcjG22nGSv
t2NPzoMGmHRDcZ6mDYYMUChslAX6ATtIm7cBu4gc6hJJpyIMUTa8Fy8WBgs67pAZ
rcOmxNCej8AvgeQpCW5i2A7qNSINSMp9db3R7F9RcbUmjX3fXLJqfb6mfkMR2BzK
gR7f257DRO0DReny9MgSZxAw4B+XUYkPmqJIBsYN5PEUjg1JRyT0oMZPuTgcXjwu
5UesfmLuL+NNEp+UN9nlTWAkEzZBaJG37GIfG0jdim57ziiF+vHHbb8ekdn2aDme
ZJHuvAnpi+Sx9G4QgougRZ7JGHetsUMPnawRudkjMkf99+GzuAzbFZPHBASPcp63
m7PYYGfl13Lqwa0iblOiPH7SsxqflcaL8WAr84wBFh8ZZYY1s7jHT7hG6mF33FG4
Q5uPAZie1r4zqbXjrQUZnt8SR6QZNW6Pmad4+cUYPsipLXXZBhmLdaiu1/G+upwk
gMs8r8tVwVMMqWuNvdfkKKV6kyAQ8sW2Y+sBUOQ80RxYfsc+8Jo19Zt4s9KRNQEn
XYP2FAPHlf2vVdWJ0t6/pmibUQ/3jcHL9BCTawQDbF381efDLe+oW6/BzhwRlVqL
fQR9JXJ6mFZWZHubmRglEv94hU8X96EGIrNUNc3AaXw6H2rZAAs=
=iRKw
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--

