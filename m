Received: from eggs.gnu.org ([2001:4830:134:3::10]:55633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dafPT-0005K4-1l
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dafPP-0002Ge-Tp
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:48:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dafPP-0002G0-K9
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:48:43 -0400
Date: Thu, 27 Jul 2017 10:48:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170727094836.GB10129@stefanha-x1.localdomain>
References: <1501120851-4314-1-git-send-email-changpeng.liu@intel.com>
	<1501120851-4314-2-git-send-email-changpeng.liu@intel.com>
	<20170726103513.GB18489@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59C79E@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B59C79E@SHSMSX103.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "mst@redhat.com" <mst@redhat.com>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 12:29:45AM +0000, Liu, Changpeng wrote:
> > > +    .fields =3D (VMStateField[]) {
> > > +        VMSTATE_VIRTIO_DEVICE,
> > > +        VMSTATE_END_OF_LIST()
> > > +    },
> > > +};
> > > +
> > > +static Property vhost_user_blk_properties[] =3D {
> > > +    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> > > +    DEFINE_BLOCK_PROPERTIES(VHostUserBlk, blkcfg),
> >=20
> > DEFINE_BLOCK_PROPERTIES cannot be used directly because it includes the
> > 'drive' (blkcfg.blk) parameter.  The command-line should not allow a
> > drive=3D parameter.
> >=20
> > Also, parameters like the discard granularity, optimal I/O size, logical
> > block size, etc can be initialized to sensible defaults by QEMU's block
> > layer when drive=3D is used.  Since you are bypassing QEMU's block layer
> > there is no way for QEMU to set good defaults.
> >=20
> > Are you relying on the managment tools populating these parameters with
> > the correct values from the vhost-user-blk process?  Or did you have
> > some other mechanism in mind?
> Actually for this part and your comments about block resize, I think mayb=
e add several
> additional vhost user messages such like: VHOST_USER_GET_BLK_CFG/VHOST_US=
ER_SET_BLK_CFG
> makes the code more clear, I'm okay to add such messages.

New messages for virtio config space read/write might be useful for
other devices besides virtio-blk.

It's worth checking how virtio config space is live migrated and how to
do that consistently if the vhost-user process is involved.

Stefan

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZebb0AAoJEJykq7OBq3PI+3MH/RdAqf+b7oDfu/UttvR7GVRV
Ao/fi4XZ8dnIx/XQu9dg/rk8mD5knOfjWtMM1x+hUgkD2zel/Jck2nhjCG9kDkuY
6+TZ1vAz+Bcx41b9FpYXADqHj1DtCIaKBqYcDlfWxpOzQ9iGGChDi8pe3oUTbrsR
GyryQzoMoaMPYJZZFE6hCG1mRido3veLZtuX06gklvDm8dbxU9L8CRLMNABRnp+3
FP/IfzTA1Zn1a6QG7PnDUg+uZETx+ol4fqAlE1cUPDKb75wJI/v46zL0ZfuACpME
Qxw663khTZe5Mvsa87ZCc47Jq4I8xn1wHZjIV+I2IuLsPlbmudWPV3mhVn+iYVE=
=NVpC
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
