Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D504C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 06:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D72D21D56
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 06:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D72D21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIoEU-0006gS-H4
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 02:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iIoBU-0005C0-1e
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iIoBS-0005Hc-5W
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:13:51 -0400
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:39888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iIoBR-0005GH-RX
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:13:50 -0400
Received: from player158.ha.ovh.net (unknown [10.109.159.136])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 1753A22AF89
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:13:46 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 4BA4AABC9DEC;
 Fri, 11 Oct 2019 06:13:36 +0000 (UTC)
Date: Fri, 11 Oct 2019 08:13:33 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 17/19] spapr: Remove last pieces of SpaprIrq
Message-ID: <20191011081333.7e483b95@bahia.lan>
In-Reply-To: <20191011050758.GD4080@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-18-david@gibson.dropbear.id.au>
 <20191009190215.7e05c017@bahia.lan>
 <20191010020209.GC28552@umbus.fritz.box>
 <20191010082958.12e17561@bahia.lan>
 <20191010223304.0cf7ccd3@bahia.lan>
 <20191011050758.GD4080@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ghqjTh.5k_SClLD=UllshU9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 2133017377574787558
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrieeggddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.57.200
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/ghqjTh.5k_SClLD=UllshU9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2019 16:07:58 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Oct 10, 2019 at 10:33:04PM +0200, Greg Kurz wrote:
> > On Thu, 10 Oct 2019 08:29:58 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >=20
> > > On Thu, 10 Oct 2019 13:02:09 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > On Wed, Oct 09, 2019 at 07:02:15PM +0200, Greg Kurz wrote:
> > > > > On Wed,  9 Oct 2019 17:08:16 +1100
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >=20
> > > > > > The only thing remaining in this structure are the flags to all=
ow either
> > > > > > XICS or XIVE to be present.  These actually make more sense as =
spapr
> > > > > > capabilities - that way they can take advantage of the existing
> > > > > > infrastructure to sanity check capability states across migrati=
on and so
> > > > > > forth.
> > > > > >=20
> > > > >=20
> > > > > The user can now choose the interrupt controller mode either thro=
ugh
> > > > > ic-mode or through cap-xics/cap-xive. I guess it doesn't break an=
ything
> > > > > to expose another API to do the same thing but it raises some que=
stions.
> > > > >=20
> > > > > We should at least document somewhere that ic-mode is an alias to=
 these
> > > > > caps, and maybe state which is the preferred method (I personally=
 vote
> > > > > for the caps).
> > > > >=20
> > > > > Also, we must keep ic-mode for the moment to stay compatible with=
 the
> > > > > existing pseries-4.0 and pseries-4.1 machine types, but will we
> > > > > keep ic-mode forever ? If no, maybe start by not allowing it for
> > > > > pseries-4.2 ?
> > > >=20
> > > > I'm actually inclined to keep it for now, maybe even leave it as the
> > > > suggested way to configure this.  The caps are nice from an internal
> > > > organization point of view, but ic-mode is arguably a more user
> > > > friendly way of configuring it.  The conversion of one to the other=
 is
> > > > straightforward, isolated ans small, so I'm not especially bothered=
 by
> > > > keeping it around.
> > > >=20
> > >=20
> > > Fair enough.
> > >=20
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > >=20
> >=20
> > But unfortunately this still requires care :-\
> >=20
> > qemu-system-ppc64: cap-xive higher level (1) in incoming stream than on=
 destination (0)
> > qemu-system-ppc64: error while loading state for instance 0x0 of device=
 'spapr'
> > qemu-system-ppc64: load of migration failed: Invalid argument
> >=20
> > or
> >=20
> > qemu-system-ppc64: cap-xics higher level (1) in incoming stream than on=
 destination (0)
> > qemu-system-ppc64: error while loading state for instance 0x0 of device=
 'spapr'
> > qemu-system-ppc64: load of migration failed: Invalid argument
> >=20
> > when migrating from QEMU 4.1 with ic-mode=3Dxics and ic-mode=3Dxive res=
pectively.
> >=20
> > This happens because the existing pseries-4.1 machine type doesn't send=
 the
> > new caps and the logic in spapr_caps_post_migration() wrongly assumes t=
hat
> > the source has both caps set:
> >=20
> >     srccaps =3D default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_type);
> >     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> >         /* If not default value then assume came in with the migration =
*/
> >         if (spapr->mig.caps[i] !=3D spapr->def.caps[i]) {
> >=20
> > spapr->mig.caps[SPAPR_CAP_XICS] =3D 0
> > spapr->mig.caps[SPAPR_CAP_XIVE] =3D 0
> >=20
> >             srccaps.caps[i] =3D spapr->mig.caps[i];
> >=20
> > srcaps.caps[SPAPR_CAP_XICS] =3D 1
> > srcaps.caps[SPAPR_CAP_XIVE] =3D 1
> >=20
> >         }
> >     }
> >=20
> > and breaks
> >=20
> >     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> >         SpaprCapabilityInfo *info =3D &capability_table[i];
> >=20
> >         if (srccaps.caps[i] > dstcaps.caps[i]) {
> >=20
> > srcaps.caps[SPAPR_CAP_XICS] =3D 0 when ic-mode=3Dxive
> > srcaps.caps[SPAPR_CAP_XIVE] =3D 0 when ic-mode=3Dxics
> >=20
> >             error_report("cap-%s higher level (%d) in incoming stream t=
han on destination (%d)",
> >                          info->name, srccaps.caps[i], dstcaps.caps[i]);
> >             ok =3D false;
> >         }
>=20
> Ah.. right.  I thought there would be problems with backwards
> migration, but I didn't think of this problem even with forward
> migration.
>=20
> > Maybe we shouldn't check capabilities that we know the source
> > isn't supposed to send, eg. by having a smc->max_cap ?
>=20
> Uh.. I'm not really sure what exactly you're suggesting here.
>=20

I'm suggesting to have a per-machine version smc->max_cap that
contains the highest supported cap index, to be used instead of
SPAPR_CAP_NUM in this functions, ie.

for (i =3D 0; i <=3D smc->max_cap; i++) {
    ...
}

where we would have

smc->max_cap =3D SPAPR_CAP_CCF_ASSIST for pseries-4.1

and

smc->max_cap =3D SPAPR_CAP_XIVE for psereis-4.2

> I think what we need here is a custom migrate_needed function, like we
> already have for cap_hpt_maxpagesize, to exclude it from the migration
> stream for machine versions before 4.2.
>=20

No, VMState needed() hooks are for outgoing migration only.

bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
{
    if (vmsd->needed && !vmsd->needed(opaque)) {
        /* optional section not needed */
        return false;
    }
    return true;
}

--Sig_/ghqjTh.5k_SClLD=UllshU9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2gHY0ACgkQcdTV5YIv
c9ZoVxAAlXJRk6ZLeugfdaYf03TOIbF2+ApR9N4MwUXzOpAVp4oBwA79gZ7azknf
wZI0thMinS38HkPZA/wRhCUvUaOwPhVNvdWKpFYU6ypyE47RMDI0QsYH2HPg8in9
JAlzlGJlk49biXXK1K2/XTLCqYUSb282KhTvDoZV7ZXpLBlUD68FzoJgfRpd/px2
xzCUaG4euW5o51OVwCJyXecoNazl291bz9IhYQYjn5sTUtZqHG/uhKGbTXOSdqG+
dm6Vtdq3ZyMb6jiVeBzChKpZ3Lu1CXgqaVnatwy0bHM4v6oIm5zKp3ZXNcgco06o
bYnQvXvpAnvv44wje4jbs5SbuCeYmayG8/RSfevd1IUeJyUpIoyJTTHqVrpYUOD9
1Xr715qrPlkX/js/pcxAlWu5/SSpkoYs5rpQbcpQcnWi3LLlIvRm0zOvPasRBF4m
ST0c3/PJ0K2hRgULQScxGF4F+DxD5sU0Z5Jzc5sOwGQkEvNQECJdpeewiitrMiSS
at1NmWVHwdl1syspGRwOFNnGt4sU17rtq3A/+wzvYuJNnw+UYSDuh4BD2VGJlEVs
IBlN8ov/pvVwYRla+YVa8dedGg2pGn8QmJtiJvKHKNimRmftq444F2B8llXMiUvq
kIHqmU6SF+lNi0w4FIlV7VYulavE2n7W1jaco4nJcxpZmj81thg=
=QDFp
-----END PGP SIGNATURE-----

--Sig_/ghqjTh.5k_SClLD=UllshU9--

