Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77850C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 04:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376D120850
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 04:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iovdFVjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376D120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1kSB-00044K-Er
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 00:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i1kRH-0003WT-Aj
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 00:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i1kRF-00059v-M4
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 00:47:38 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58085)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i1kRE-00057o-33; Sun, 25 Aug 2019 00:47:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46GN0d113vz9s7T; Sun, 25 Aug 2019 14:47:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566708449;
 bh=xxb/9PThA0Cd8x4fYRzuHvKWGhjdqtoVKvv9sOaQ5pc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iovdFVjolLAAD8AEDEsbvz4NJ/TI90WpXCRpXHk2DV0Kg9F2PIUVkj1bFreXixrl1
 517s8v86t6W9sggQBUTmLNis2SGVDqipdIKVNrAXOuu9q46GYuMNpIZtRrLcEDnrVV
 Bsaae3pwmfXchLtXsx5zNHgpsov7xsq28zvcAeos=
Date: Sun, 25 Aug 2019 11:03:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190825010310.GN3027@umbus.fritz.box>
References: <20190719024555.18845-1-aik@ozlabs.ru>
 <ae3e5bd1-c7dd-d893-5c0e-803f4e4f2325@linux.vnet.ibm.com>
 <20190812100849.GF3947@umbus.fritz.box>
 <3722a768-c8bb-ed04-e450-b18cba8e6296@linux.vnet.ibm.com>
 <20190813141755.GN3947@umbus.fritz.box>
 <a2edbfa3-85fe-6998-ce0c-b97898081822@linux.vnet.ibm.com>
 <9639fb3c-1b26-925d-903e-961fc306674c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0aF+6pWUK5w8WdCh"
Content-Disposition: inline
In-Reply-To: <9639fb3c-1b26-925d-903e-961fc306674c@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [GIT PULL for qemu-pseries REPOST]
 pseries: Update SLOF firmware image
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
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0aF+6pWUK5w8WdCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2019 at 02:09:44PM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 14/08/2019 14:33, Aravinda Prasad wrote:
> >=20
> >=20
> > On Tuesday 13 August 2019 07:47 PM, David Gibson wrote:
> > > On Tue, Aug 13, 2019 at 01:00:24PM +0530, Aravinda Prasad wrote:
> > > >=20
> > > >=20
> > > > On Monday 12 August 2019 03:38 PM, David Gibson wrote:
> > > > > On Mon, Aug 05, 2019 at 02:14:39PM +0530, Aravinda Prasad wrote:
> > > > > > Alexey/David,
> > > > > >=20
> > > > > > With the SLOF changes, QEMU cannot resize the RTAS blob. Resizi=
ng is
> > > > > > required for FWNMI support which extends the RTAS blob to inclu=
de an
> > > > > > error log upon a machine check.
> > > > > >=20
> > > > > > The check to valid RTAS buffer fails in the guest because the r=
tas-size
> > > > > > updated in QEMU is not reflecting in the guest.
> > > > > >=20
> > > > > > Any workaround for this?
> > > > >=20
> > > > > Well, we should still be able to do it, it just means fwnmi would=
 need
> > > > > a SLOF change.  It's an inconvenience, but not really a big deal.
> > > >=20
> > > > Yes. Alexey and I were discussing about the following changes to SL=
Of:
> > > >=20
> > > > diff --git a/lib/libhvcall/hvcall.S b/lib/libhvcall/hvcall.S
> > > > index b19f6dbeff2c..880d29a29122 100644
> > > > --- a/lib/libhvcall/hvcall.S
> > > > +++ b/lib/libhvcall/hvcall.S
> > > > @@ -134,6 +134,7 @@ ENTRY(hv_rtas)
> > > >          ori     r3,r3,KVMPPC_H_RTAS@l
> > > >          HVCALL
> > > >          blr
> > > > +    .space 2048
> > > >          .globl hv_rtas_size
> > > >   hv_rtas_size:
> > > >          .long . - hv_rtas;
> > > >=20
> > > >=20
> > > > But this will statically reserve space for RTAS even when
> > > > SPAPR_CAP_FWNMI_MCE is OFF.
> > >=20
> > > Sure.  We could flag that in the DT somehow, and have SLOF reserve the
> > > space conditionally.
> > >=20
> > > Or we could just ignore it. 2 kiB is miniscule compared to our minimum
> > > guest size, and our current RTAS is microscopic compared to PowerVM.
> >=20
> > I also think so, 2kiB is miniscule so we can allocate it statically.
> >=20
> > Alexey,
> >=20
> > Can you please include the above one line fix to SLOF?
>=20
>=20
> I am thinking of:
> =3D=3D=3D
> @@ -132,20 +132,22 @@ ENTRY(hv_rtas)
>  	mr	r4,r3
>  	lis	r3,KVMPPC_H_RTAS@h
>  	ori	r3,r3,KVMPPC_H_RTAS@l
>  	HVCALL
>  	blr
> +	.space 2048 - (. - hv_rtas)
>  	.globl hv_rtas_size
>  hv_rtas_size:
>  	.long . - hv_rtas;
>=20
>  ENTRY(hv_rtas_broken_sc1)
>  	mr	r4,r3
>  	lis	r3,KVMPPC_H_RTAS@h
>  	ori	r3,r3,KVMPPC_H_RTAS@l
>  	.long	0x7c000268
>  	blr
> +	.space 2048 - (. - hv_rtas_broken_sc1)
>  	.globl hv_rtas_broken_sc1_size
>  hv_rtas_broken_sc1_size:
>  	.long . - hv_rtas_broken_sc1;
> =3D=3D=3D
>=20
> to align the rtas blob to 2k precisely. But QEMU hardcoded
> RTAS_ERROR_LOG_OFFSET bothers me a bit, I should probably put some sort o=
f a
> magic marker at which RTAS log can start.
>=20
> David, any thoughts? The marker could be as simple as a zero, for example.

Eh, TBH I don't think an agreed upon magic marker has all that much
advantage on an agreed upon offset.  Let's keep it simple and retain
the fixed offset for now.  If that's ever a problem we'll need a
synchronized qemu & SLOF update, but that's ok - that's an
inconvenience, not a disaster.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0aF+6pWUK5w8WdCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1h3k4ACgkQbDjKyiDZ
s5J05g/9Fyu8f1E9YA+q+rsfKjUdUUU0jUGoWOU7Rolrq7P0gq9ayuX0Dvngtjnb
6XvQe1Y1h4jNf+bWtoP3TjvZxR9NZ1gQCtiXZVw6p4aWsgXdtMdPTVxKGusCiA1O
l1SL+ZgdNjZ54toC1EvbRoVrQxC31RMkWN/bgHtmASxxwjDyQdCjWBwg6RMofrcZ
FW6BBTD2Q8dYfyX3MRfm6z8S2okgGRTc6yzQxmuR92CprPJ6eb/rmqykP7hPBWF9
BVNkJP4RRaqVg65k7jNnfJhqcFO4f/fZ0W+RMWC9z8Eat3kixFExONiS9C/mEZER
pEmrwe/PqDuHI4K7TT81Cri2EH4DVLtQ4OJKeoJB3iK+2/px+vifp5+p6Dqbx6Gq
/eMN061ELm2RAi9NBzmHRvNIQHyoogV3x3T2J6vzW6ircmUhHRBC3NBkwDneavZP
rqKGvNESvuSSJNXjBNCoQpHt8pIIzarYjTdE0Mg8G5UhSLgzdXYPVFKJ8TTsYcy8
l9A6SJS71EOupfenLz2ykFzBaFtJaCeCGKEgipJh2Joa5Kt1XPPZU1t9h2bo2Q9A
+vHlLy01wOjVHTVayVmJ1UfPDHvFvBVLCM6+lwuvfSZL2eBKKmXyzD45qNx2uOJS
4dZo8PrR68zgzH3zL/tvwGlh9KwWRId4EMBgXzJ5syECfdGZeD8=
=KgwT
-----END PGP SIGNATURE-----

--0aF+6pWUK5w8WdCh--

