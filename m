Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789D4C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DAF20730
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YuK7cFJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DAF20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXbTK-0002XD-Fg
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 20:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXbRR-0000Dj-9g
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXbRQ-0006eF-73
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:39:29 -0500
Received: from ozlabs.org ([203.11.71.1]:55943)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXbRN-0006WB-Lg; Wed, 20 Nov 2019 20:39:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47JMfz2Tpvz9sPV; Thu, 21 Nov 2019 12:39:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574300363;
 bh=iiwaM5TR9jwQXbu5E2BRk8RbhYJ57IKYhIJxcQL/1Y8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YuK7cFJiUrR6/AandKCZIjPwbF6jY/ktUgFICN8mDWVs5HGo4dgzb8Ens/DfzmLLH
 Nb5FfER0CXkjttdueveBHdRJcZTlEU2RUGUAQn2o4k/a9kl2Ed5TIX7S7Wt+Km5cFj
 lygiceo6z8S5/9OerS4rr5Z2qvicUw+gZauv31o4=
Date: Thu, 21 Nov 2019 12:39:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] exynos4210_gic: Suppress gcc9 format-truncation warnings
Message-ID: <20191121013911.GR5582@umbus.fritz.box>
References: <20191004025509.3012-1-david@gibson.dropbear.id.au>
 <CAFEAcA9soWUfyfvV5Onyy0wP842Gq698_sZ+E1xGwkmnrLHnJg@mail.gmail.com>
 <20191120052701.GJ5582@umbus.fritz.box>
 <CAFEAcA-2B=tLfc9y3ri_p9nOWBAaiDkhgRQ9r-hjdmYbpzbBiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n7Lj0ukKFj+YqP4g"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-2B=tLfc9y3ri_p9nOWBAaiDkhgRQ9r-hjdmYbpzbBiA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--n7Lj0ukKFj+YqP4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 10:31:48AM +0000, Peter Maydell wrote:
> On Wed, 20 Nov 2019 at 05:27, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > On Mon, Oct 14, 2019 at 01:51:39PM +0100, Peter Maydell wrote:
> > > If we assert() that num_cpu is always <=3D EXYNOS4210_NCPUS
> > > is that sufficient to clue gcc in that the buffer can't overflow?
> >
> > Interestingly, assert(s->num_cpu <=3D EXYNOS$210_NCPUS) is *not*
> > sufficient, but assert(i <=3D EXYNOS4210_NCPUS) within the loop *is*
> > enough.  I've updated my patch accordingly.
> >
> > This isn't 4.2 material, obviously.  Should I just sit on it until 5.0
> > opens, or does one of you have someplace to stage the patch in the
> > meanwhile?
>=20
> Easy fixes for compiler warnings aren't inherently out of scope
> for 4.2. I'm also collecting stuff for 5.0 anyway so I suggest you
> just send the patch.

Ok, done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n7Lj0ukKFj+YqP4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3V6r8ACgkQbDjKyiDZ
s5I11BAAmIJ3dhSzNf68hiO0dXYXzKUT/1gU5kf7dqZOhdQmNhad0T+iG0WRvXcb
6DIu2ffox80F0l42ogC5JAzcw1O3NQ4GoKe29BPQ5TlqFwoR7GOeAW2D3g4DQPWw
PSmJqtEHynIdiVaoEKq2MUxA0pONpf8Qtnri7BhRUA55GqRxIFqvdcJxPIgB7gTV
fJMdHReNU0AdKGQFKJUIsUPTCkiIHMZvZnx05hDaZTQ/W1/BxBTk934dDo9+6OEe
oFxkYkGFSOBtWMzh5RqmYowcUvJVtcJTMz6EMkRLdD+JolAxwsxIaivD69Fm+YZw
vgK2iWKublMFNTcs/HFOdEabRq5qF/4r9dvtP0twnk/pgFO/nYyQdAq73cdc5L/W
tV5b+Y529ZrwjFTo2yaahoGPr5jb6eSaQdXwOU710RI+t9pErj1y10X9WD/W8OBQ
kCVVGrI4r9QUcCCcmsZN/dmn9FgcayZEAEV4tlwvOj87ZSm40vcPgwglSDEVrUuj
XO9luGLznmW674delKoEhp0S5nolPAV0BJ66eOww9BXHE7Ck2Tqtiembd+AfzP/h
dnGUm6cpS4Z9XTUqsYGlqF/5HuIWk2Yp8oNW+Ubb3gdz+nL1QsexGNMOv5AXbT2c
qbbJb5BBHp49t2xnmfG5gVdm83/YVs4sOckgH6UCkKiFb53hlwc=
=mGi0
-----END PGP SIGNATURE-----

--n7Lj0ukKFj+YqP4g--

