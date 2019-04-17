Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF10C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 14:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E2C206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 14:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E2C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53443 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGlC8-00029l-Gx
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 10:05:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hGlB0-0001YV-8N
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hGlAy-0005xs-Oy
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:04:38 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:39900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hGlAy-0005wB-DZ
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:04:36 -0400
Received: from player726.ha.ovh.net (unknown [10.109.143.216])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id E6D3F1226E0
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 16:04:33 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player726.ha.ovh.net (Postfix) with ESMTPSA id DCCD84CC945C;
	Wed, 17 Apr 2019 14:04:28 +0000 (UTC)
Date: Wed, 17 Apr 2019 16:04:26 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190417160426.272d6560@bahia.lan>
In-Reply-To: <20190417124734.GT32705@umbus.fritz.box>
References: <20190416045552.24573-1-npiggin@gmail.com>
	<20190417015934.GH32705@umbus.fritz.box>
	<1555498879.055yucy998.astroid@bobo.none>
	<20190417140129.18980f0e@bahia.lan>
	<20190417124734.GT32705@umbus.fritz.box>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/SP9LVw7H2gCJWuEXsu75tuP";
	protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 3634686374823172582
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrfeefgdejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.59.63
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] spapr: add splpar hcalls
 H_PROD, H_CONFER
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
	Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417140426.R6qcBPplc2f_lhske9LmlAdfZpITZ0v_3EtcqPWOEek@z>

--Sig_/SP9LVw7H2gCJWuEXsu75tuP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Apr 2019 22:47:34 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Apr 17, 2019 at 02:01:29PM +0200, Greg Kurz wrote:
> > On Wed, 17 Apr 2019 21:20:00 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote: =20
> > > [...] =20
> > > >> @@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
> > > >>      /* hcall-splpar */
> > > >>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
> > > >>      spapr_register_hypercall(H_CEDE, h_cede);
> > > >> +    spapr_register_hypercall(H_CONFER, h_confer);
> > > >> +    spapr_register_hypercall(H_PROD, h_prod);
> > > >> +
> > > >>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_res=
et);   =20
> > > >=20
> > > > You're no longer enabling the KVM CONFER and PROD hypercalls.  Are
> > > > they enabled by default, or is that an intentional change?   =20
> > >  =20
> >=20
> > AFAICT they seem to be enabled by default in HV KVM.
> >  =20
> > > Oh, it was not intentional, I must not understand how this works. Why
> > > is this no longer enabling the those hcalls?
> > >  =20
> >=20
> > Since linux commit 699a0ea0823d ("KVM: PPC: Book3S: Controls for in-ker=
nel=20
> > sPAPR hypercall handling"), in-kernel hypercalls are disabled by default
> > and must be explicitely enabled by userspace. QEMU does that for some
> > hypercalls already (search kvmppc_enable_set_mode_hcall() in QEMU for an
> > example).
> >=20
> > Since H_CONFER and H_PROD are listed in default_hcall_list[] in book3s_=
hv.c,
> > no need for QEMU to enable them in KVM. =20
>=20
> Ah, ok.  Oops, that means the guest environment has been visibly
> different for KVM and TCG all this time, which isn't great.
>=20
> > Not sure about David's "no longer" wording though. =20
>=20
>=20
> "no longer" meaning the previous patch version had some
> kvmppc_enable_hcall(), but this version doesn't.
>=20

Neither do the two previous versions of this patch actually, hence
my questioning... No big deal :)


--Sig_/SP9LVw7H2gCJWuEXsu75tuP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAly3MmoACgkQcdTV5YIv
c9bNuxAAmwV+XrFwqjrfFrTBAuDMx0ULjE1e/exhyeT3QXJ+bWYvFagpW36HLx9L
36jpfJUwFq36a675BWwmX42mJ3OV+7hcXLDCRZ/qxh3rC/N+G5G8A4xbq4FGUqKi
wQudmdd5YZoOqbEAIFn/ZErkWfKmMeN/nAD5abPPJasNTo9PduSJkyUlCMLCAIAk
bPZuOR2fffz5+6S8pInNcycfuCo4NOnVIUlTj00siVx87RziOmtnv1ygIkfHb84X
psqABVTTs5BLLiIVK/OUiGbg5cLEy6nLLBMNWwTmnbdr3BKnJILnj0SRPAhbFQts
/hxvLTizYTVMVlGbuQovvKxP/qPfcokoq2QhhxCqUc6G4wXJGksvTj2BqmDTyaOA
JcthaSLWxDXpqRkOcLAOlG/6bI34v5kaJjgZLqX7WNvX1XpbRQlHuzSLeiRXWvdp
loKJnK76zuxUFKGmCMS4dRFIEMnjyBzlk0OsE7kx47w2D8UtGLbteOUtGAtXUnGY
QQdl9ry3s+XZS3s1YLvc2NLivqqgjvtM3ymu5UTEJguycFa17ogyfIt3JALoGDvB
8W47ZHaF+VNO9clPqhvJRaR9IMrKvP/eFfpr7zJwvsW/fz55Z4RcYFn3h55ZB3Yy
dDa6Fik4gC8i8uMyO8BJX5n35fh+iHcebGX7ZLoN0trXRCswNOs=
=E8JS
-----END PGP SIGNATURE-----

--Sig_/SP9LVw7H2gCJWuEXsu75tuP--

