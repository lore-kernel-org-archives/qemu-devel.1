Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3A0C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC33205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="i/R2hlIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC33205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg5J3-0004Dd-Df
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 06:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53374)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hg5HN-0003Ea-Og
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hg5HM-000813-2h
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:35:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52265 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hg5HL-0007Mp-3P
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:35:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45YfZ14DZmz9sCJ; Wed, 26 Jun 2019 20:35:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561545337;
 bh=cgixGdsEoMsPh+X6XPzQj4lSztU6BqgNMZgkSBCrYsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i/R2hlItkMp5lrJHzv2f2rNkH9BUKliy6qj42p7QHoBi3oANGOHVhpNrdKaLFVjLj
 xC1ZILQwYJTYtaXdmc8wPHsS7u46t+FQMbJoKJKAKzXbRJ8LSZMx6esfoNnlUkV0e0
 uJuVkc4Tc0W+eEUcRnp204lemUg22eEloy8dzLqU=
Date: Wed, 26 Jun 2019 18:33:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190626083344.GC2410@umbus.BigPond>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
 <0b9f4772-37f6-1453-e4ea-5ad9d0f52a5b@ilande.co.uk>
 <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
 <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
 <ffae3651-5daf-e008-6562-2de09d82ace9@linaro.org>
 <b8aab3f4-e3eb-a137-62b4-ba5ac1a2ad8f@ilande.co.uk>
 <68facefc-b801-4902-11c0-4542662bfc4e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <68facefc-b801-4902-11c0-4542662bfc4e@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

g


On Tue, Jun 25, 2019 at 05:56:42PM +0200, Richard Henderson wrote:
> On 6/25/19 5:37 PM, Mark Cave-Ayland wrote:
> > The problem is that in tcg/tcg-op.h we define "DEF(dup2_vec, 1, 2, 0, I=
MPLVEC |
> > IMPL(TCG_TARGET_REG_BITS =3D=3D 32))" and in the last patchset dup2_vec=
 isn't introduced
> > until towards the end. Unfortunately it's not a simple as bringing the =
patch forward
> > within the series to maintain bisectability because the current impleme=
ntation
> > depends on VMRG which only appears in the patch just before it...
>=20
> Ah, that would explain it.  I admit I haven't looked at v5 that closely.
>=20
> > Next to try and figure out what exactly is causing the fault. Just a qu=
ick question
> > out of curiosity: is your Power9 system BE or LE?
>=20
> The Power9 is LE.

It's the kernel determines endianness, not the system.

>=20
> I do have access to a Power7 BE system, and that worked last time I check=
ed.
> I'll try that again tomorrow to be sure.
>=20
>=20
> r~
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0TLeUACgkQbDjKyiDZ
s5KPyQ/9EvvQUAbEYGWHXbuG2RUFGcgpv1W8AJnwxF+qfUorYbcBXAiSy10/cwOl
5zguVAzP1KN6JH6i3rT/IpoRa9nIr/Zzfawx8hGGY2zVgSSRi8ZY+L4FcyREZVjc
kyITmoN6CL141I6qObHP1ljH1rE66+1roW3ONyGwbenABd3qnfgOM6OrvBF7frhd
dESIksy0Z6l+P9QkGe9nzSLAtV+FaW44xe5Mk3imD9FpawcTL39YRIxaA8ebqVxd
bvc7WX1K7WCcLdd87b93CADwBYRde7ZlJvQ9OvEnhrtYImjUT82tptyq4eHb76l/
U8lPJ2o7WWZZh6RrZpz6Q49jvueA2Lk168u2ydhpYfHBbK978eSTKB/weuE1utUO
zpu2uPlDQZfLDfvQJAI3yncek2GXbfi9ynfOsVWeg9iw/sHCkPhc+7OrAs8A39rS
N5Y2gHRXdWoN5/Pl0FKQnNm5xthRLlaceVMCUtPcKYVxjbAj9KGbqZ8ks+o36x3y
RggG7+C7JeZAPNL4+TcYZjN9Z5DfrL87xUBOkUSBjBd9XqB0Bbr9DL8N3ULoXZw4
DJHQcH8cP+jFqp96Qpm8toebzlCz4wyHol5Rrz+Lkherj6Jedsqzj3ral62KRruM
21xNsybY7kNQPzRp7MjGiagZeoVkxH/1dI8KR4KjVfX2ZNm8mZk=
=Pc5w
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--

