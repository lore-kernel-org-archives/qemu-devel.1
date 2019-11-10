Return-Path: <SRS0=zNqU=ZC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5999C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 21:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE7B206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 21:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="g2d7WLEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE7B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTuWw-0002UI-Mj
	for qemu-devel@archiver.kernel.org; Sun, 10 Nov 2019 16:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iTuU9-0007FJ-EB
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 16:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iTuU7-0004kr-Mg
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 16:11:00 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35913 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iTuU6-0004U7-JB; Sun, 10 Nov 2019 16:10:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47B69g4d0Vz9sNx; Mon, 11 Nov 2019 08:10:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1573420247;
 bh=v5qDauUW5khZHryv3daXxIa4v7785PoQZ+Oopx4R+9M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g2d7WLEbUvvJd0WQk2hmTLsivIPdN1ibC41UUb+qVE89JCS8n4VSNOeQ9bFxTP8S8
 NuxOF3aITwuQmOX1VmPoosq/RQAz1dP/KBL9dNMcx+bhZcjZD629Kkl8CB3R+liOVQ
 7iloJzmcRSxWPXkHsXuQK21ZylP94TyCxK2q2fOw=
Date: Sun, 10 Nov 2019 19:47:23 +0000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 2/3] ARM/virt: Use fdt_setprop_strings()
Message-ID: <20191110194723.GS2461@umbus.Home>
References: <20191108194758.17813-1-palmer@dabbelt.com>
 <20191108194758.17813-3-palmer@dabbelt.com>
 <CAFEAcA_Lj2SmxMTEN06+FxwQrkuR80Vw5=Dkh1achFUySSFAxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A3RWl4qWgABmkY4K"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Lj2SmxMTEN06+FxwQrkuR80Vw5=Dkh1achFUySSFAxA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--A3RWl4qWgABmkY4K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2019 at 03:56:21PM +0000, Peter Maydell wrote:
> On Fri, 8 Nov 2019 at 19:48, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > This new helper function encodes the idiom used by the ARM virt board to
> > set a string array.  I don't currently have a working ARM userspace, so=
 I haven't tested
> > this, but I made the helper function because I wanted to use it for the
> > RISC-V virt board where I have tested it.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> >  hw/arm/virt.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index d4bedc2607..4dc00f54d5 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -304,9 +304,8 @@ static void fdt_add_timer_nodes(const VirtMachineSt=
ate *vms)
> >
> >      armcpu =3D ARM_CPU(qemu_get_cpu(0));
> >      if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
> > -        const char compat[] =3D "arm,armv8-timer\0arm,armv7-timer";
> > -        qemu_fdt_setprop(vms->fdt, "/timer", "compatible",
> > -                         compat, sizeof(compat));
> > +        qemu_fdt_setprop_strings(vms->fdt, "/timer", "compatible",
> > +                                 "arm,armv8-timer\0arm,armv7-timer\0");
> >      } else {
>=20
>=20
> This seems to be changing the property we put in -- in
> the old code it is 'foo\0bar\0', but in the new code
> there will end up being two \0 at the end: 'foo\0bar\0\0'.

In fact it's not because the setprop_strings() helper just uses the
\0\0 to detect the end, but truncates what it actually puts into the
dtb at the first \0.  But I agree this is confusing enough not to
really be an improvement over the original version.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A3RWl4qWgABmkY4K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3IaUsACgkQbDjKyiDZ
s5JNiQ//dQzJ3b9Z0jnIoeHqf7B+FFJvza+sCqMD0cN8MgVEA8az8w7jnDOpV8he
Ui10nBm4fQAFWGPMVnz2pXDi8FZjzR7+ZRgWS1hgdEbKz3nck6724bZ01NLUm1lJ
kVzSg+xKykkzFj2ez/D46FE2tmjhGic1UyaE4ScjdbsbJNZ5MQ+CWxdHeVVQ4pYb
HgYR6JOxaRyqaZaTOt2xToUjTlwrbDWdwDpvrKbwRMEAAOXOosWLKBgHjkorEVEP
MeX6GgUVXqt1AWhATKdw//G36sqOcGA0zXAK1cfacaDYN0kEOjyFYxpAhzBjLT1N
lRMwfa3sOKggMuK35/XPiiN8/l/tK5haDYvVddgGdIyU1pYbjkwa0ocGqsKgJVtO
RmN53IsaE4hEQywIGRu27PFy1QXw6KFmdlLo56GhpRkxCnFH3BeKZpo/oFHnXmPi
81c0c4NQCQzpRMq4itJBF6ewyA8jw3BVA6cUuFFVrGb131MUwHt29Wke4lRj0MjO
9imh1z84dvgs/g0aQsnKv+cv3znOcr7TSEq8o6UnhoYbv5rkXk69ftAnsAggHEN7
M9DrbESEjY8Ju6tShcyKFaFcx/XvM2z3b74MhNuXVLmaxb5rLGIWNCwACMVksXzb
25Db/m7JV+gv7Q6Mx/afvbEpFWzlGu0diWi0iru1FreMHMIUVvs=
=E/uG
-----END PGP SIGNATURE-----

--A3RWl4qWgABmkY4K--

