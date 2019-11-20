Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7FFC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 05:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4062240A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 05:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MQzQ9yVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4062240A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXIXb-0007sS-Ul
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 00:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXIWM-0007Km-1Q
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 00:27:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXIWK-0007pH-Nj
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 00:27:17 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40883 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXIWF-0007fu-9u; Wed, 20 Nov 2019 00:27:12 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HrmB4mwpz9sPW; Wed, 20 Nov 2019 16:27:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574227626;
 bh=pKpuafZcDqiFdJFkncIRk5Np4sv1bwXlnHVfgKCTcvM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MQzQ9yVMvevv8eayeamRF87pavqd59ueZc9PZScnOdOl1fquhKFXLSRhpgyU6BAgG
 EIkjugAhyYMmqqmrbMt8TaA+qC+4In2xAAcfkw3UfMpIEB1BgZuZWOjYNfNhencuKB
 cqOTxub3ysbmKSgGXX5uYOWz29tsytjjom7t6MTc=
Date: Wed, 20 Nov 2019 16:27:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] exynos4210_gic: Suppress gcc9 format-truncation warnings
Message-ID: <20191120052701.GJ5582@umbus.fritz.box>
References: <20191004025509.3012-1-david@gibson.dropbear.id.au>
 <CAFEAcA9soWUfyfvV5Onyy0wP842Gq698_sZ+E1xGwkmnrLHnJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UEbtx6mvDyyRl/If"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9soWUfyfvV5Onyy0wP842Gq698_sZ+E1xGwkmnrLHnJg@mail.gmail.com>
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UEbtx6mvDyyRl/If
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 01:51:39PM +0100, Peter Maydell wrote:
> On Fri, 4 Oct 2019 at 04:10, David Gibson <david@gibson.dropbear.id.au> w=
rote:
> >
> > exynos4210_gic_realize() prints the number of cpus into some temporary
> > buffers, but it only allows 3 bytes space for it.  That's plenty - I'm
> > pretty sure that existing machines will only ever set this value to 2
> > (EXYNOS4210_NCPUS).  But the compiler can't really be expected to figure
> > that out.
> >
> > Some[*] gcc9 versions therefore emit -Wformat-truncation warnings.  Fix
> > that by allowing more space in the temporary buffers - these are on sta=
ck
> > very briefly before being essentially strdup()ed inside the memory regi=
on
> > code, so there's not much cost to doing so.
> >
> > [*] The bizarre thing here, is that I've long gotten these warnings
> > compiling in a 32-bit x86 container as host - Fedora 30 with
> > gcc-9.2.1-1.fc30.i686 - but it compiles just fine on my normal x86_64 h=
ost
> > - Fedora 30 with and gcc-9.2.1-1.fc30.x86_64.
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/intc/exynos4210_gic.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
> > index a1b699b6ba..2e5e47f9ec 100644
> > --- a/hw/intc/exynos4210_gic.c
> > +++ b/hw/intc/exynos4210_gic.c
> > @@ -290,8 +290,8 @@ static void exynos4210_gic_realize(DeviceState *dev=
, Error **errp)
> >      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> >      const char cpu_prefix[] =3D "exynos4210-gic-alias_cpu";
> >      const char dist_prefix[] =3D "exynos4210-gic-alias_dist";
> > -    char cpu_alias_name[sizeof(cpu_prefix) + 3];
> > -    char dist_alias_name[sizeof(cpu_prefix) + 3];
> > +    char cpu_alias_name[sizeof(cpu_prefix) + 10];
> > +    char dist_alias_name[sizeof(cpu_prefix) + 10];
> >      SysBusDevice *gicbusdev;
> >      uint32_t i;
>=20
> If we assert() that num_cpu is always <=3D EXYNOS4210_NCPUS
> is that sufficient to clue gcc in that the buffer can't overflow?

Interestingly, assert(s->num_cpu <=3D EXYNOS$210_NCPUS) is *not*
sufficient, but assert(i <=3D EXYNOS4210_NCPUS) within the loop *is*
enough.  I've updated my patch accordingly.

This isn't 4.2 material, obviously.  Should I just sit on it until 5.0
opens, or does one of you have someplace to stage the patch in the
meanwhile?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UEbtx6mvDyyRl/If
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UzqQACgkQbDjKyiDZ
s5ICvxAA0Q4kBa2vsJ00sIsTT4gXu3ddnLjtIJ3t+ZvYqJ77jkTa4E8LwT/+JMeZ
HAtuexE1eECRj9V1cnhW+/xfGEV83YDgekjFSZzcm1LYCWKGlcFHPefnWCYpFH4L
vVsZ8SfU5rN8zdFe5PogFaps7ZuRf3yP8ukc+i3VkRnpTPdterR3xUCQvYoZg7pP
99NCIjD4BFxgcPEmlIGe9LRP0TR72yOO841x1HVRqPFBFr/Ac0440WT2AWSy/Umb
utvhUhND9NUyB2g0cACmoT504bbyH0fZOFFB+EdCxTYsgLrjAgEbaV8b7bzefPR5
/2UOber7FCQqowgPyx11uf5djMRc5UKIaZfOkADY1tb1TuCEw7jZq7qsiYNgATXX
/5JCRgyC2zMMOwvz4KZaIiR+FooJDCUsZvqEVO5pRtzISY5E/F0tlLDugfHTC8jr
q90FrJXr+SvbWCfQXxOGWRMwVN7p2ZI+9dYtwUigPLTdqliSWghg0VhsOf4ZH6xy
CGO97V1P4l5OOO3qq4vkilsSaHyEtm04MLZphH0TrVAvZVlt6XbErsSUPQTzpwuU
V/I5Lh3ttOtuU9HX4rv6oygJ8pdBn4fs7xRxzSnHau5ZER6/wvk76FD6WKeZP+XP
PB8YOavsTZ0OsIhzV/92mxMEsKe/zD9YWgTe22F18n3cpllcyJA=
=+Pqu
-----END PGP SIGNATURE-----

--UEbtx6mvDyyRl/If--

