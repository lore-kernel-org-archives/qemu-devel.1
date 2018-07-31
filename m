Received: from eggs.gnu.org ([2001:4830:134:3::10]:40071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fkWtn-0002L8-5r
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fkWtj-0003uy-9D
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:49:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fkWtj-0003qJ-2g
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:49:19 -0400
Date: Tue, 31 Jul 2018 16:49:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180731154906.GG17816@stefanha-x1.localdomain>
References: <1531900083-18167-1-git-send-email-junyan.he@gmx.com>
	<20180727124917.GC28555@stefanha-x1.localdomain>
	<20180727160529-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Content-Disposition: inline
In-Reply-To: <20180727160529-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 0/7 V11] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, junyan.he@gmx.com, ehabkost@redhat.com, quintela@redhat.com, rth@twiddle.net, crosthwaite.peter@gmail.com, qemu-devel@nongnu.org, dgilbert@redhat.com, Junyan He <junyan.he@intel.com>, imammedo@redhat.com, pbonzini@redhat.com, yi.z.zhang@intel.com, xiaoguangrong.eric@gmail.com


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 04:06:23PM +0300, Michael S. Tsirkin wrote:
> On Fri, Jul 27, 2018 at 01:49:17PM +0100, Stefan Hajnoczi wrote:
> > On Wed, Jul 18, 2018 at 03:47:56PM +0800, junyan.he@gmx.com wrote:
> > > From: Junyan He <junyan.he@intel.com>
> > >=20
> > > QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and li=
ve migration.
> > > If the backend is on the persistent memory, QEMU needs to take proper=
 operations to
> > > ensure its writes persistent on the persistent memory. Otherwise, a h=
ost power failure
> > > may result in the loss the guest data on the persistent memory.
> >=20
> > Ping Michael.  Can this go through your tree?
>=20
> OK but do you really think it's appropriate in this release cycle?
> If not pls repost after the release including the acks.

I agree, it's too late for QEMU 3.0.

Have you considered keeping a -next tree?  It's more
contributor-friendly if you merge patches into a -next tree so they
don't need to worry about it anymore.

Stefan

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbYITyAAoJEJykq7OBq3PIuhUIAI8wTEPDACZrCwHtvM2hU0Cp
YMfZ0JGPZp7Dl2hUoS9NqGGy+EGHBMrqXJPZGfivAloNC1t1Z2yaVqhFPkPUJS1h
01EBMBG3uRlDl0jP3uwvOjtgDIEBT38zuyjmFYtVD+DLEte2WLv9SLqDR8Za+EiC
doLhVDuZ35Zsbd9/zccAchpcepTZ/rznBnozIZqY2PHCIATokWORRBVQsmsRO3uv
2vT6kYCnCOSoTspDIjuE2E3EPJV3zMv1YdCx3yTdt07LF73iO4La9g8BkPEvOj9o
waWlX2Wqywrd09JSvETdJ/SZnqTu9IiShIb2BbmI8/fbsnifKChnpFwYCP+xsMI=
=ftfJ
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
