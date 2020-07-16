Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D1DC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 00:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F02206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 00:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mW78IAF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F02206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwDwN-0002ZH-Il
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 20:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwDvR-0001S1-HI; Thu, 16 Jul 2020 20:08:29 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwDvO-0001j1-1F; Thu, 16 Jul 2020 20:08:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B7BKd19nBz9sRW; Fri, 17 Jul 2020 10:08:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594944501;
 bh=5zoWHTNNTWiE+j5tqFpfzFJKXgi4OI4LXEyBKISKfSw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mW78IAF2HDCZabZBCk1I1imOYBJlWSQcdby6UPqV8nKLrgbPi94r59O7+UdssouNX
 uNh5S8SpR5Gf/ReHN+bABiGeRl/81MRAwa896Pu5gtCL22RwsLeAWNDUcTR1qmpXse
 +rPEeNx9hp9kN02+FAAiY0j1o0yywsBebZIF35SA=
Date: Fri, 17 Jul 2020 09:50:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr_pci: Robustify support of PCI bridges
Message-ID: <20200716235023.GC5607@umbus.fritz.box>
References: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
 <20200716044540.GL93134@umbus.fritz.box>
 <87eepbmudt.fsf@dusky.pond.sub.org>
 <20200716164200.2bea2977@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <20200716164200.2bea2977@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 04:42:00PM +0200, Greg Kurz wrote:
> On Thu, 16 Jul 2020 16:01:18 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>=20
> > David Gibson <david@gibson.dropbear.id.au> writes:
> >=20
> > > On Thu, Jul 09, 2020 at 07:12:47PM +0200, Greg Kurz wrote:
> > >> Some recent error handling cleanups unveiled issues with our support=
 of
> > >> PCI bridges:
> > >>=20
> > >> 1) QEMU aborts when using non-standard PCI bridge types,
> > >>    unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error ha=
ndling"
> > >>=20
> > >> $ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
> > >> Unexpected error in object_property_find() at qom/object.c:1240:
> > >> qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' n=
ot found
> > >> Aborted (core dumped)
> > >
> > > Oops, I thought we had a check that we actually had a "pci-bridge"
> > > device before continuing with the hotplug, but I guess not.
> > >
> > >> This happens because we assume all PCI bridge types to have a "chass=
is_nr"
> > >> property. This property only exists with the standard PCI bridge type
> > >> "pci-bridge" actually. We could possibly revert 7ef1553dac but it se=
ems
> > >> much simpler to check the presence of "chassis_nr" earlier.
> > >
> > > Hrm, right, 7ef1553dac was not really correct since add_drcs() really
> > > can fail.
> >=20
> > Right.  I failed to see that we can run into a bridge without a
> > "chassis_nr" here.

And I missed it on review, as well.

> > >> 2) QEMU abort if same "chassis_nr" value is used several times,
> > >>    unveiled by commit d2623129a7de "qom: Drop parameter @errp of
> > >>    object_property_add() & friends"
> > >>=20
> > >> $ qemu-system-ppc64 -M pseries -device pci-bridge,chassis_nr=3D1 \
> > >>                         -device pci-bridge,chassis_nr=3D1
> > >> Unexpected error in object_property_try_add() at qom/object.c:1167:
> > >> qemu-system-ppc64: -device pci-bridge,chassis_nr=3D1: attempt to add=
 duplicate property '40000100' to object (type 'container')
> > >> Aborted (core dumped)
> >=20
> > Before d2623129a7de, the error got *ignored* in
> > spapr_dr_connector_new():
> >=20
> >     SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
> >                                              uint32_t id)
> >     {
> >         SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(object_new(type));
> >         char *prop_name;
> >=20
> >         drc->id =3D id;
> >         drc->owner =3D owner;
> >         prop_name =3D g_strdup_printf("dr-connector[%"PRIu32"]",
> >                                     spapr_drc_index(drc));
> >         object_property_add_child(owner, prop_name, OBJECT(drc), &error=
_abort);
> >         object_unref(OBJECT(drc));
> > --->    object_property_set_bool(OBJECT(drc), true, "realized", NULL);
> >         g_free(prop_name);
> >=20
> >         return drc;
> >     }
> >=20
> > I doubt that's healthy.

Indeed.

> This isn't. The object_property_set_bool() was later converted to
> qdev_realize() (thanks again for the cleanups!) but the problem
> remains. Realize can fail and I see now reason we don't do proper
> error handling when it comes to the DRCs.
>=20
> I'll look into fixing that.
>=20
> > >> This happens because we assume that "chassis_nr" values are unique, =
but
> > >> nobody enforces that and we end up generating duplicate DRC ids. The=
 PCI
> > >> code doesn't really care for duplicate "chassis_nr" properties since=
 it
> > >> is only used to initialize the "Chassis Number Register" of the brid=
ge,
> > >> with no functional impact on QEMU. So, even if passing the same value
> > >> several times might look weird, it never broke anything before, so
> > >> I guess we don't necessarily want to enforce strict checking in the =
PCI
> > >> code now.
> > >
> > > Yeah, I guess.  I'm pretty sure that the chassis number of bridges is
> > > supposed to be system-unique (well, unique within the PCI domain at
> > > least, I guess) as part of the hardware spec.  So specifying multiple
> > > chassis ids the same is a user error, but we need a better failure
> > > mode.
> > >
> > >> Workaround both issues in the PAPR code: check that the bridge has a
> > >> unique and non null "chassis_nr" when plugging it into its parent bu=
s.
> > >>
> > >> Fixes: 05929a6c5dfe ("spapr: Don't use bus number for building DRC i=
ds")
> > >
> > > Arguably, it's really fixing 7ef1553dac.
> >=20
> > I agree 7ef1553dac broke the "use a bridge that doesn't have property
> > 'chassis_nr' case.
> >=20
> > I suspect the "duplicate chassis_nr" case has always been broken, and
> > d2623129a7de merely uncovered it.
>=20
> Yes.

I agree.

> > If we can trigger the abort with hot-plug, then d2623129a7de made things
> > materially worse (new way to accidentally kill your guest and maybe lose
> > data), and I'd add a Fixes: blaming it.
> >=20
>=20
> Yes it does.
>=20
> David,
>=20
> Maybe consider folding a third Fixes: tag into this patch ?

Done.

> > >> Reported-by: Thomas Huth <thuth@redhat.com>
> > >> Signed-off-by: Greg Kurz <groug@kaod.org>
> > >
> > > I had a few misgivings about the details of this, but I think I've
> > > convinced myself they're fine.  There's a couple of things I'd like to
> > > polish, but I'll do that as a follow up.
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Q57wACgkQbDjKyiDZ
s5IB9xAAvip31cVdUWZGzy1DcIXXezmsKZvK5bE7t7j+Q8qHsTHcSFLFPczwtIo7
1lW6eyDtDBuok1fMJm/jtTKA/vqDbuY3m2lfoBeNbX8BUv7MacRvxf0sS3z7upAn
lAWmRwhMB/NqQ2NANDJluhG85J5Ol2bn69cnKstYZKRjiqmJw/tMdr2p7aQvnlyB
ha2ZhcNS5MwBnL7h1HpAHOzklb+oRmf3B/r+GpfiUSA3F8Y8nCSm5kiKKXGrKGW7
OMxorybVNXnz63SjowatCq69qoSfTMLLd3CXRcjLAdqA+ZxTtZWmoM5R+P1n1C7X
Elw3DUDr+4N/QIDI49X8ZQuIMHmKdbyQWK6yidJ/gRLofbBTyyadsPnWp+8twIcR
wT6RndCc6QBbwql7EiKfRxtFoin8ilIPsFAN952NCnJHu7wPglz7Kyv/V2eQwIeQ
qwIIL4qo6mHAMfSdunKH81vE2gShe8V5QsfQcHEcFsHljyVhN0jf31VCmIeHW+wm
hkq/VDoa/qqMup06qstibthXAveNAb4kFzpM1U0iHzE3WeyfyiN5AbKb8dNf5gDg
zzZHvk9cEbB99ptJ4K4AjXgxbzl30lkUAA2pprwj1b4Ck2izVcwL3NAqaJduestP
8xHE1QK4O9kqAiKpyet1hV+gJ3TfWrHQYF6oYLofhukKBApdTnk=
=j3A9
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--

