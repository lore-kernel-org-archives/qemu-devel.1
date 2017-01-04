Received: from eggs.gnu.org ([2001:4830:134:3::10]:44292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOmuH-0004hc-LH
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOmuE-0002kA-DB
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:51:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOmuE-0002jz-7G
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:51:10 -0500
Date: Wed, 4 Jan 2017 14:44:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170104144458.GC8194@stefanha-x1.localdomain>
References: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
	<e57c4b44-ac0c-a937-e088-1f4e086080d8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <e57c4b44-ac0c-a937-e088-1f4e086080d8@redhat.com>
Subject: Re: [Qemu-devel] [RFC]virtio-blk: add disk-name device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Junkang Fu <fujunkang@gmail.com>, qemu-devel@nongnu.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2017 at 10:53:06AM -0600, Eric Blake wrote:
> On 12/29/2016 08:41 PM, Junkang Fu wrote:
> >>From 74e913fc41ea98d1dde692175f1e3fb6729342aa Mon Sep 17 00:00:00 2001
> > From: "junkang.fjk" <junkang.fjk@alibaba-inc.com>
> > Date: Wed, 24 Aug 2016 19:36:53 +0800
> > Subject: [PATCH] virtio-blk: add disk-name device property
> >=20
> > Current virtio-blk disk name(ex. /dev/vdb) has nothing to do with the
> > target dev
> > name specified in libvirt xml file. For example, we may get disk name
> > /dev/vdb in
> > VM while target dev specified in libvirt xml is vdc.
>=20
> It's not really libvirt's fault.  The libvirt XML names are for
> convenience, but nothing on the host side requires the guest to pick the
> same naming scheme as the host.
>=20
> I guess your proposal is to enhance the virtio spec such that clients
> that are new enough to honor the new addition to the virtio spec will
> change their name-picking algorithm to use the name provided by the
> host, rather than their current approach of picking whatever name they
> feel like, and then enhance libvirt to pass the XML name on down to the
> guest?  It might work, but as others have pointed out, it will require a
> virtio spec change first.

This change is unnecessary.  The -device virtio-blk-pci,serial=3D property
already exists for this purpose.

Stefan

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYbQpqAAoJEJykq7OBq3PIcVUH/2V3UdKKwLZBBvA+UI3Zbetl
uCQlChA7NWjvf7c8+I8fd3h0kvxo/Bk4XYwZ8fmdK2aK56perh7Rv9fablORcW3O
57VaoBdLJRGxWIGkepDxJObryFJvwBOVRsPEfavBYXSaNlIKn7j/41vQRXFPrINl
4+MRp2aDKqSxtTUQ6oP8WVvr8+TmOEJFOSniIAB4cN392C1q7p3Pfjr+kfPK0Lk8
PGfAJ6LuLm3ORwZ412WRXX4vz3LV0lTomv8PN9+vxlEpUFaOb2Rgr30BbUV/CjdK
igmDDG/uoPoHI/opUixb4hJKMOvDl86hFUoZNFehR8xsuHMaRt+/D4YQ6yjenaI=
=7/Hx
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
