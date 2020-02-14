Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A5EC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096C8217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096C8217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ZTx-0004OA-5N
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 06:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j2ZT0-0003UJ-HS
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j2ZSz-0003qp-8t
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:49:06 -0500
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:39267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j2ZSz-0003gC-3l
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:49:05 -0500
Received: from player687.ha.ovh.net (unknown [10.110.115.67])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5FA2A84054
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 12:48:55 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 8ED19F54B9F3;
 Fri, 14 Feb 2020 11:48:50 +0000 (UTC)
Date: Fri, 14 Feb 2020 12:48:47 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/3] spapr: Migrate SpaprDrc::unplug_requested
Message-ID: <20200214124847.25ecfb9e@bahia.lan>
In-Reply-To: <20200214022900.GK124369@umbus.fritz.box>
References: <158076936422.2118610.5626450767672103134.stgit@bahia.lan>
 <158076938222.2118610.14456984179352959929.stgit@bahia.lan>
 <20200214022900.GK124369@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VKIH+Zxl8u0Ts.wpDtmdrZB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 9882867911085431270
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrjedtgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.105
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/VKIH+Zxl8u0Ts.wpDtmdrZB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2020 13:29:00 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Feb 03, 2020 at 11:36:22PM +0100, Greg Kurz wrote:
> > Hot unplugging a device is an asynchronous operation. If the guest is
> > migrated after the event was sent but before it could release the
> > device with RTAS, the destination QEMU doesn't know about the pending
> > unplug operation and doesn't actually remove the device when the guest
> > finally releases it. The device
> >=20
> > Migrate SpaprDrc::unplug_requested to fix the inconsistency. This is
> > done with a subsection that is only sent if an unplug request is
> > pending. This allows to preserve migration with older guests in the
> > case of a pending hotplug request. This will cause migration to fail
> > if the destination can't handle the subsection, but this is better
> > than ending with an inconsistency.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_drc.c |   27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index d512ac6e1e7f..6f5cab70fc6b 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -455,6 +455,22 @@ void spapr_drc_reset(SpaprDrc *drc)
> >      }
> >  }
> > =20
> > +static bool spapr_drc_unplug_requested_needed(void *opaque)
> > +{
> > +    return spapr_drc_unplug_requested(opaque);
> > +}
> > +
> > +static const VMStateDescription vmstate_spapr_drc_unplug_requested =3D=
 {
> > +    .name =3D "spapr_drc/unplug_requested",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D spapr_drc_unplug_requested_needed,
> > +    .fields  =3D (VMStateField []) {
> > +        VMSTATE_BOOL(unplug_requested, SpaprDrc),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static bool spapr_drc_needed(void *opaque)
> >  {
> >      SpaprDrc *drc =3D (SpaprDrc *)opaque;
> > @@ -467,8 +483,11 @@ static bool spapr_drc_needed(void *opaque)
> >      /*
> >       * We need to migrate the state if it's not equal to the expected
> >       * long-term state, which is the same as the coldplugged initial
> > -     * state */
> > -    return !spapr_drc_device_ready(drc);
> > +     * state, or if an unplug request is pending.
> > +     */
> > +    return
> > +        spapr_drc_unplug_requested_needed(drc) ||
> > +        !spapr_drc_device_ready(drc);
>=20
> Hrm.  You start the series by splitting spapr_drc_device_ready() from
> spapr_drc_needed().  But at this point, I'm pretty sure you've now got
> all the callers of spapr_drc_device_ready() doing equivalent logic
> about them, so they might as well be one function again.  That seems
> pretty roundabout.
>=20

Yeah... I did the split because an earlier draft of this series had
a separate path at some point for the plug and unplug cases... but
I agree these should be reunited.

> I don't think the rationale for not using the drc_ready function from
> the CAS path really makes sense.  It's not just an accident that those
> use the same logic - in both cases what we're testing is "Is the DRC
> in a state other than that of a default cold-plugged device?".
>

"Is the DRC in a state other than that of a default cold-plugged device
or is an unplug request pending ?" since the DRC of the device to be
unplugged only transitions away from the "ready state" when the guest
asks to isolate the device with the "set-indicator" RTAS call.

> Changing the name might be sensible, but I still think we want a
> common function for the two cases.
>=20

I'll go for that. Maybe reverse the semantics, like if "the DRC has
no attached device or it has an attached device without pending unplug
request" then it is in a steady state that doesn't require anything
special at CAS or migration time, eg. spapr_drc_steady() ?

> >  }
> > =20
> >  static const VMStateDescription vmstate_spapr_drc =3D {
> > @@ -479,6 +498,10 @@ static const VMStateDescription vmstate_spapr_drc =
=3D {
> >      .fields  =3D (VMStateField []) {
> >          VMSTATE_UINT32(state, SpaprDrc),
> >          VMSTATE_END_OF_LIST()
> > +    },
> > +    .subsections =3D (const VMStateDescription * []) {
> > +        &vmstate_spapr_drc_unplug_requested,
> > +        NULL
> >      }
> >  };
> > =20
> >=20
>=20


--Sig_/VKIH+Zxl8u0Ts.wpDtmdrZB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl5GiSAACgkQcdTV5YIv
c9YCdRAAhUFXVyRclZj/k7LeN3c8QJMx8hT5El92bE4x2S1rbjGrJ/1VjvvZj0Vb
TD6L99kD2uy1BYx/aEmhsOnrbLrvcl5/RrURlRtBuR4t8VDEIC9xo4yVeDfsdFwg
etNGFI2jWalcffTPEdGyIBS7rEF1eN5nwOHfW/y9zZs4x86LcHxW6G2MCGtVGLte
GtlzFzVeLr79fMhnhBzzCItbCIo9WT/p1fGS+qmZVTZ6tgK9Uu8iEtPpAX8xSQ47
iQ5Og5S7tkizg57OHWgLG07fK282kmjtGq8Uz6vi6J8CgeeIF44UtlQKiPoW8INB
UkjAhXZBdn5yIk5p6x3Gd5ZUheBGX1pOa6CwLUyTzA9EO91OfHSeIGwyStJEEYQe
Cqc93eDAjRmu0jkdKYWNN2fsYegPuxxOWImyohUJK/MtT4l74mwSl0B3ApaqtluV
3Tx7L4HibUDfi0mknlwqdHk8cot087qOz7l0hSA49E/A7OG/p5tUrp/h5Msa1IfY
F8FvPciVEQXv22sby3v6MhNK8vjkBQBRhoTWS60hS5CXnmdeW+n1OaT2cK4EChK8
u9nYaEAbVI7NDvstuWFGWunS/+bY+n8gg7rXR/AbBgwFtdBsP5WxP+QOSKGZ0sU2
CU6ieIFdBgz0VbiAbDBgtAN5LBLyGAbK4MrBqTOGmwUvDijPA14=
=xj3w
-----END PGP SIGNATURE-----

--Sig_/VKIH+Zxl8u0Ts.wpDtmdrZB--

