Received: from eggs.gnu.org ([2001:4830:134:3::10]:36481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fM9oz-0003w3-Ae
	for qemu-devel@nongnu.org; Fri, 25 May 2018 06:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fM9ou-00012X-Tr
	for qemu-devel@nongnu.org; Fri, 25 May 2018 06:19:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fM9ou-00011w-O1
	for qemu-devel@nongnu.org; Fri, 25 May 2018 06:19:36 -0400
Date: Fri, 25 May 2018 11:19:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180525101932.GE14757@stefanha-x1.localdomain>
References: <1526682016-17336-1-git-send-email-changpeng.liu@intel.com>
	<20180522131120.GM21655@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B65CBBD@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B65CBBD@SHSMSX103.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-blk: turn on pre-defined RO feature
 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 02:39:28PM +0000, Liu, Changpeng wrote:
>=20
>=20
> > -----Original Message-----
> > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > Sent: Tuesday, May 22, 2018 6:11 AM
> > To: Liu, Changpeng <changpeng.liu@intel.com>
> > Cc: qemu-devel@nongnu.org; mst@redhat.com
> > Subject: Re: [PATCH] vhost-blk: turn on pre-defined RO feature bit
> >=20
> > On Sat, May 19, 2018 at 06:20:16AM +0800, Changpeng Liu wrote:
> > > Read only feature shouldn't be negotiable, because if the
> > > backend device reported Read only feature supported, QEMU
> > > host driver shouldn't change backend's RO attribute.
> >=20
> > I don't understand this patch.
> >=20
> > Does it make *all* virtio-blk devices read-only?
> If the slave target reported RO feature, the disk in OS should be RO, cur=
rently
> users should specify in QEMU command to enable RO.
> >=20
> > Or is the idea that the vhost-user slave has to clear the read-only bit
> > if it is a writable device?
> Exactly.

Thanks for explaining!

Please implement the read-only bit in contrib/vhost-user-blk we it can
be tested.

Thanks,
Stefan

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbB+M0AAoJEJykq7OBq3PIGTQIAMSKw/v3pWi7hLLH4Y+2SYBC
Bah/vcGcrl6caHpvB1/sxOnx71+JLoXlwL5fx25d57HJ39C73PTjA2qNBSjiEaas
xKXmVawo8pugdbT1q9NXV8vH6+zhBpV0Kae3Tq8JIlgwK3kzxZW28tvrApS3hc0P
SHntHPALFY1M55EPDgXYkCd7jFGCysyirIVFh4ABC56PjGmXyzma6pt8zeFCc+zH
wHFvT3Z+atG9lu+1mOWsF+pHFrc2oZA0edWGzo/j1UNRbeptCYOSJywKUSPCBlcv
cPtjMs/bLhS7PFcGYt5lYRhPLaJ2rSoYT9ORPdNm7zr2+9KUQobgygyTTgeVG24=
=cXNh
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
