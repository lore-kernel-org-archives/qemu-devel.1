Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18238C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D448A2068E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CxDvU/Ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D448A2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAWeM-0007CL-2c
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 06:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kAWdd-0006E2-2h; Tue, 25 Aug 2020 06:57:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kAWdZ-0001wT-SS; Tue, 25 Aug 2020 06:57:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BbQt723pWz9sTY; Tue, 25 Aug 2020 20:57:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598353023;
 bh=6ElixnJqTqdSiX66H6c3MXroHiXNVRzgq+ont9xQV90=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CxDvU/IkTedvWIv3OhOwysvGLoIBdMJ0Etu6U7sPbRm4r6NC8TCcSzohJh+MyKey3
 vwbt8FhzAJwpLvoww9va0LrvSFyfnyNCOv1X6qGM6BGOkwAFy6zUIPVw+09NxXB+DM
 /WlahZgxZvwi9v0194kaHrQU4dJl2o6WwcHoAFR4=
Date: Tue, 25 Aug 2020 19:36:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/1] spapr_vscsi: do not allow device hotplug
Message-ID: <20200825093601.GG4734@yekko.fritz.box>
References: <20200820190635.379657-1-danielhb413@gmail.com>
 <7f6ab4e6-42b1-3de4-5893-2ef09fc9dd26@redhat.com>
 <87k0xnjl4f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Content-Disposition: inline
In-Reply-To: <87k0xnjl4f.fsf@dusky.pond.sub.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 08:27:28AM +0200, Markus Armbruster wrote:
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
>=20
> > Cc'ing Markus
> >
> > On 8/20/20 9:06 PM, Daniel Henrique Barboza wrote:
> >> We do not implement hotplug in the vscsi bus, but we forgot to
> >> tell qdev about it. The result is that users are able to hotplug
> >> devices in the vscsi bus, the devices appear in qdev, but they
> >> aren't usable by the guest OS unless the user reboots it first.
> >>=20
> >> Setting qbus hotplug_handler to NULL will tell qdev-monitor, via
> >> qbus_is_hotpluggable(), that we do not support hotplug operations
> >> in spapr_vscsi.
> >>=20
> >> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1862059
> >>=20
> >> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> >> ---
> >>  hw/scsi/spapr_vscsi.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>=20
> >> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> >> index d17dc03c73..57f0a1336f 100644
> >> --- a/hw/scsi/spapr_vscsi.c
> >> +++ b/hw/scsi/spapr_vscsi.c
> >> @@ -1219,6 +1219,9 @@ static void spapr_vscsi_realize(SpaprVioDevice *=
dev, Error **errp)
> >> =20
> >>      scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
> >>                   &vscsi_scsi_info, NULL);
> >> +
> >> +    /* ibmvscsi SCSI bus does not allow hotplug. */
> >> +    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
> >
> > Can't this be a problem later in DeviceClass::unrealize()?
>=20
> Can't say offhand.  Cc'ing QOM maintainers for actual expertise.
>=20
> A quick grep coughs up virtio_serial_device_realize() /
> virtio_serial_device_unrealize(), which set and unset the hotplug
> handler of a bus their device provides.  Not the same as the code above,

Hm, it almost is, actually.  Only difference is that virtio serial is
setting the hotplug handler to something, rather than disabling it.

> just a clue that messing with a bus's hotplug handler in a realize
> method can work.
>=20
> qbus_set_hotplug_handler() is entirely undocumented.  It sets a link.
> Might be intended for use by the device that provides the bus.

Heh.

> > I was expecting something like, overwriting the parent bus type:
> >
> > -- >8 --
> > @@ -1271,6 +1271,7 @@ static void spapr_vscsi_class_init(ObjectClass
> > *klass, void *data)
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >      SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
> >
> > +    k->bus_type =3D NULL; /* ibmvscsi SCSI bus does not allow hotplug.=
 */
> >      k->realize =3D spapr_vscsi_realize;
> >      k->reset =3D spapr_vscsi_reset;
> >      k->devnode =3D spapr_vscsi_devnode;
>=20
> k->bus_type does not exist.  Do you mean dc->bus_type?

Yeah, I'm pretty sure changing the bus type is going to be worse than
setting the hotplug handler.

> TYPE_VIO_SPAPR_VSCSI_DEVICE is a subtype of TYPE_VIO_SPAPR_DEVICE is a
> subtype of TYPE_DEVICE.
>=20
> TYPE_DEVICE is bus-less, i.e. (concrete) instances do not plug into a
> bus.
>=20
> TYPE_VIO_SPAPR_DEVICE has bus_type TYPE_SPAPR_VIO_BUS, i.e. (concrete)
> instances plug into a TYPE_SPAPR_VIO_BUS.  Both hot and cold plug.
>=20
> Zapping TYPE_VIO_SPAPR_VSCSI_DEVICE's bus_type makes it bus-less.  I
> doubt that's okay.  Also, it's not just about hot plug.  What are you
> trying to accomplish?

I'm pretty sure all of the above is not relevant.  It's the
subordinate bus of TYPE_VIO_SPAPR_VSCSI_DEVICE on which we want to
disable hotplugging, not the parent bus.  We can't hotplug spapr-vscsi
controllers, but that's fine.  What we're trying to address here is
that the controller supports a TYPE_SCSI_BUS, onto which disks can
normally be hotplugged, but not in this case.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9E234ACgkQbDjKyiDZ
s5Jk7w/+KsSBdI/yd4HPdRATeIphLPdv5mm/Cm/GFrt8JiMbt/PyIy3WjuWzsW0/
5EYrQgHYZL2y2jIL/krA4EI+nY0UZ2MUxfDBxwMpDhs5yS2zkurHP1lfyrAwaWAL
2ndCu9/mmYt3c3knplYcdCfvMiP//sYXnlUW54xLEira8TCHNDuosdigFAYQkhNN
eGRASisLEMgk3x/MDkERgt6657gRhguDt31/kWNzefXhVEw+3nJ5HRy6NOl6pCwP
/1+O4rUXcLDt+4fKfHjHvb3ZMThLJEeATgpSCflndSL43pfVurmn7r+FFk7xX6vv
7GWE+IaeCyVne6WnfB8lYkN+pFvBSamO93r5y8upcvjdXOI/KpFgm/bgG1Ovm9+H
CtLWqExkNZ5436k4nJskKG4PMkPEoIesaKeB16lXTlNcTZXDL3xnxnOX+Qb6hAfg
TyXYAhGE+wzaU27Cwt+cVyopG56uA0iaO4tXhAW4W0TjWC34Tl+Ek6GrV8OkxlzN
0BxKNH7AXYrSWnfZiSn/dkUIXWEzC4A6FaBx2AQuWxHmH3NXLaGn4ADS94SIoPKV
Hs2kCnaDYgs0uHc1hpj0x/Ah66fVqBsJx0aXITbY92UG9WgM9QxSXnqelpMzcVin
ncGm64ySQvYaQWFiT2gAFlmVs5Vd8h6CGIUzi6Wcuv2SiMSo/Vw=
=XrFU
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--

