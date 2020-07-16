Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2A1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6962065D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6962065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw1Cv-0001sK-VH
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jw1CK-0001Mm-HN
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:33:05 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:60805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jw1CE-0001Rl-9v
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:33:04 -0400
Received: from player692.ha.ovh.net (unknown [10.108.57.50])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 72C651E2077
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 12:32:54 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 9FEFB1444D4F7;
 Thu, 16 Jul 2020 10:32:47 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G0030cb72e20-fcf3-441f-a57a-89128e3704e4,82226C5D462F885DC4F8BFF1B5769E1A03475668)
 smtp.auth=groug@kaod.org
Date: Thu, 16 Jul 2020 12:32:44 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr_pci: Robustify support of PCI bridges
Message-ID: <20200716123244.1f854c63@bahia.lan>
In-Reply-To: <20200716044540.GL93134@umbus.fritz.box>
References: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
 <20200716044540.GL93134@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fIl3hGtTQkN0dToXIlmavs_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 3230769786597579238
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfeeggddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgefgkeduvddutdfgkeekjeelgeejffehudeuhfeltdetfedthffftdfggeeihfdvnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.52.147; envelope-from=groug@kaod.org;
 helo=8.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 06:32:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/fIl3hGtTQkN0dToXIlmavs_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2020 14:45:40 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jul 09, 2020 at 07:12:47PM +0200, Greg Kurz wrote:
> > Some recent error handling cleanups unveiled issues with our support of
> > PCI bridges:
> >=20
> > 1) QEMU aborts when using non-standard PCI bridge types,
> >    unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error handl=
ing"
> >=20
> > $ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
> > Unexpected error in object_property_find() at qom/object.c:1240:
> > qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not =
found
> > Aborted (core dumped)
>=20
> Oops, I thought we had a check that we actually had a "pci-bridge"
> device before continuing with the hotplug, but I guess not.
>=20

Ah... are you suggesting we should explicitly check the actual type
of the bridge rather than looking for the "chassis_nr" property ?

> > This happens because we assume all PCI bridge types to have a "chassis_=
nr"
> > property. This property only exists with the standard PCI bridge type
> > "pci-bridge" actually. We could possibly revert 7ef1553dac but it seems
> > much simpler to check the presence of "chassis_nr" earlier.
>=20
> Hrm, right, 7ef1553dac was not really correct since add_drcs() really
> can fail.
>=20

Yes.

> > 2) QEMU abort if same "chassis_nr" value is used several times,
> >    unveiled by commit d2623129a7de "qom: Drop parameter @errp of
> >    object_property_add() & friends"
> >=20
> > $ qemu-system-ppc64 -M pseries -device pci-bridge,chassis_nr=3D1 \
> >                         -device pci-bridge,chassis_nr=3D1
> > Unexpected error in object_property_try_add() at qom/object.c:1167:
> > qemu-system-ppc64: -device pci-bridge,chassis_nr=3D1: attempt to add du=
plicate property '40000100' to object (type 'container')
> > Aborted (core dumped)
> >=20
> > This happens because we assume that "chassis_nr" values are unique, but
> > nobody enforces that and we end up generating duplicate DRC ids. The PCI
> > code doesn't really care for duplicate "chassis_nr" properties since it
> > is only used to initialize the "Chassis Number Register" of the bridge,
> > with no functional impact on QEMU. So, even if passing the same value
> > several times might look weird, it never broke anything before, so
> > I guess we don't necessarily want to enforce strict checking in the PCI
> > code now.
>=20
> Yeah, I guess.  I'm pretty sure that the chassis number of bridges is
> supposed to be system-unique (well, unique within the PCI domain at
> least, I guess) as part of the hardware spec.  So specifying multiple
> chassis ids the same is a user error, but we need a better failure
> mode.
>=20

According to section 3.2.6.4 of "PCI-to-PCI Bridge Architecture
Specification", the chassis number is exposed to the OS as a=20
non-volatile r/w register. It seems to be expected that chassis
numbers might collide, in which case the system software can
overwrite the register with a new number. So I'm not sure that
specifying the same number multiple times is an actual user error.

> > Workaround both issues in the PAPR code: check that the bridge has a
> > unique and non null "chassis_nr" when plugging it into its parent bus.
> >
> > Fixes: 05929a6c5dfe ("spapr: Don't use bus number for building DRC ids")
>=20
> Arguably, it's really fixing 7ef1553dac.
>=20

True for issue 1 but not for issue 2, which is the result of
05929a6c5dfe (switch to "chassis_nr" introduces a condition
to end up with duplicate DRC ids) and d2623129a7de (assert
when trying to add a duplicated DRC).

I'm starting to think I should maybe split this in
two patches. One for each issue.

> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> I had a few misgivings about the details of this, but I think I've
> convinced myself they're fine.  There's a couple of things I'd like to
> polish, but I'll do that as a follow up.
>=20

Some fixes for d2623129a7de just got merged. Let me have a look
again.

> > ---
> >  hw/ppc/spapr_pci.c |   57 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 57 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 329002ac040e..09d52ef7954d 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1480,6 +1480,57 @@ static void spapr_pci_bridge_plug(SpaprPhbState =
*phb,
> >      add_drcs(phb, bus);
> >  }
> > =20
> > +/* Returns non-zero if the value of "chassis_nr" is already in use */
> > +static int check_chassis_nr(Object *obj, void *opaque)
> > +{
> > +    int new_chassis_nr =3D
> > +        object_property_get_uint(opaque, "chassis_nr", &error_abort);
> > +    int chassis_nr =3D
> > +        object_property_get_uint(obj, "chassis_nr", NULL);
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_PCI_BRIDGE)) {
> > +        return 0;
> > +    }
> > +
> > +    /* Skip unsupported bridge types */
> > +    if (!chassis_nr) {
> > +        return 0;
> > +    }
> > +
> > +    /* Skip self */
> > +    if (obj =3D=3D opaque) {
> > +        return 0;
> > +    }
> > +
> > +    return chassis_nr =3D=3D new_chassis_nr;
> > +}
> > +
> > +static bool bridge_has_valid_chassis_nr(Object *bridge, Error **errp)
> > +{
> > +    int chassis_nr =3D
> > +        object_property_get_uint(bridge, "chassis_nr", NULL);
> > +
> > +    /*
> > +     * slotid_cap_init() already ensures that "chassis_nr" isn't null =
for
> > +     * standard PCI bridges, so this really tells if "chassis_nr" is p=
resent
> > +     * or not.
> > +     */
> > +    if (!chassis_nr) {
> > +        error_setg(errp, "PCI Bridge lacks a \"chassis_nr\" property");
> > +        error_append_hint(errp, "Try -device pci-bridge instead.\n");
> > +        return false;
> > +    }
> > +
> > +    /* We want unique values for "chassis_nr" */
> > +    if (object_child_foreach_recursive(object_get_root(), check_chassi=
s_nr,
> > +                                       bridge)) {
> > +        error_setg(errp, "Bridge chassis %d already in use", chassis_n=
r);
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> >  static void spapr_pci_plug(HotplugHandler *plug_handler,
> >                             DeviceState *plugged_dev, Error **errp)
> >  {
> > @@ -1491,6 +1542,12 @@ static void spapr_pci_plug(HotplugHandler *plug_=
handler,
> >      PCIBus *bus =3D PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
> >      uint32_t slotnr =3D PCI_SLOT(pdev->devfn);
> > =20
> > +    if (pc->is_bridge) {
> > +        if (!bridge_has_valid_chassis_nr(OBJECT(plugged_dev), errp)) {
> > +            return;
> > +        }
> > +    }
> > +
> >      /* if DR is disabled we don't need to do anything in the case of
> >       * hotplug or coldplug callbacks
> >       */
> >=20
> >=20
>=20


--Sig_/fIl3hGtTQkN0dToXIlmavs_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl8QLMwACgkQcdTV5YIv
c9ZMVg//dzKJMb7794mS2aw2YhdWDS8tQLAugP50hKw23/6bbfmDfBOjU+19aWPp
e69wRM6oe13SJMpCiZBo1o8hSLOreCUTs60SAPg99GdgFxHO7QoRO8wVfn+7uKGU
ZPRttAXOSQU+cyw2+zECuL/G2uHBpzOtikJ/nHHBOOhoh4+s6UnCvcfukK6qW4wA
HfEs5hufBQC4c3IVoOUIc1p+qcywk1895bgbEXSSWf8NLBcBya1Iok8EzAcbSGSD
0gcnmAxKw3FD5ru6nUb+32yOiD6KGkaUlGzydLHFemk5UWpJqRr4tDDZfRinbVPm
qeCcvrylHcr7e+J5+7EJl/8nnsDAG9usVqKLTaMj9AdoUEanQjDWhGopq+x2+v9D
evhAcX/QtDbSRnt2ZBMPhbflPKyIdZ6rwh7LmrYOWtQ1z9nF7ypnzn3XQP+sB4xb
9sEC64JOA3YAfX/2MHalFXv9yBunQIPdd8SMdLEq9014HCosstOfmPBSECoY66kn
XP6HUmWCjVHSvJ8tB0UhQAwUBZ6awC3hkSsEf4yDIm0PP6Lrx8Z5vuxsqqu44ehE
moG7p5ccWL1zOO+2wUvvo+H7htHKZjlmCswL6sksAo1SupymK/oEIG1alRM4+oP6
FiNrfqG347LiEI33AyRWfZUHhcJavDu55RknbsGg7CcVCD+ClXk=
=oMGG
-----END PGP SIGNATURE-----

--Sig_/fIl3hGtTQkN0dToXIlmavs_--

