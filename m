Received: from eggs.gnu.org ([2001:4830:134:3::10]:43900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dACMl-000092-43
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dACMg-0000gn-5y
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:32:35 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dACMf-0000fx-WB
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:32:30 -0400
Received: by mail-wm0-x242.google.com with SMTP id y10so26820318wmh.0
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 02:32:29 -0700 (PDT)
Date: Mon, 15 May 2017 10:12:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515091212.GA2273@stefanha-x1.localdomain>
References: <1494431760-6455-1-git-send-email-pagupta@redhat.com>
	<20170511181703.GC8701@stefanha-x1.localdomain>
	<1494538720.20270.35.camel@redhat.com>
	<20170512134213.GB589@stefanha-x1.localdomain>
	<20170512165344.GD4312@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20170512165344.GD4312@noname.redhat.com>
Subject: Re: [Qemu-devel] KVM "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, Dan Williams <dan.j.williams@intel.com>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 06:53:44PM +0200, Kevin Wolf wrote:
> Am 12.05.2017 um 15:42 hat Stefan Hajnoczi geschrieben:
> > On Thu, May 11, 2017 at 05:38:40PM -0400, Rik van Riel wrote:
> > > On Thu, 2017-05-11 at 14:17 -0400, Stefan Hajnoczi wrote:
> > > > On Wed, May 10, 2017 at 09:26:00PM +0530, Pankaj Gupta wrote:
> > > > > * For live migration use case, if host side backing file is=A0
> > > > > =A0 shared storage, we need to flush the page cache for the disk=
=A0
> > > > > =A0 image at the destination (new fadvise interface,
> > > > > FADV_INVALIDATE_CACHE?)=A0
> > > > > =A0 before starting execution of the guest on the destination hos=
t.
> > > >=20
> > > > Good point.=A0=A0QEMU currently only supports live migration with
> > > > O_DIRECT.
> > > > I think the problem was that userspace cannot guarantee consistency
> > > > in
> > > > the general case.=A0=A0If you find a solution to this problem for f=
ake
> > > > NVDIMM then maybe the QEMU block layer can also begin supporting li=
ve
> > > > migration with buffered I/O.
> > >=20
> > > I'll be happy to work with you on that, independently
> > > of Pankaj's project.
> > >=20
> > > It looks like the fadvise system call could be extended
> > > pretty easily with an FADV_INVALIDATE_CACHE command, the
> > > other side of which can simply hook into the existing
> > > page cache invalidation code in the kernel.
> > >=20
> > > Qemu will need to know whether the invalidation succeeded,
> > > but that is something we can test for pretty easily before
> > > returning to userspace.
> >=20
> > Sounds great.  I will review the long discussions that took place on
> > qemu-devel about cache invalidation for live migration - just want to
> > make sure there were no other reasons why only O_DIRECT is supported
> > :).
>=20
> There are other reasons why we recommend against using non-O_DIRECT
> modes in production (including the error handling), but with respect to
> live migration, this is the only one I'm aware of.
>=20
> As I already said in the private email thread, an FADV_INVALIDATE_CACHE
> should do the trick and I'd be happy to work with you guys on that.

Okay, I didn't know you and Rik had already discussed this in private.
The QEMU change is probably not difficult.

Stefan

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGXDsAAoJEJykq7OBq3PIOMEIAIhb09qeMfl8N03MMvQvRLpD
q3ewCuTPZiT4yxvEd86+qF9mnmXha3SdI7Zw6C91Nds6Gz/AIUdTs3hHonl29eRV
A+oBNqsedJ1bAt5ux6uzCe9czLphZ9NOCeD/fHBqXrj/UJShY7JLGw7LaSNJb+Mh
JaPOMMCCTaXReaMrs03EGl8/Xof86e2Ej0UfcPRYd4EQTyc9452TMASZ4Wn9WDGr
au6+9yh0yx+iHcQjNXS3QPTLhdopgJOjTGKwF2l1R4OANBxbwDVHv070pE5Jx6ru
P1RiltZkfZ+ZsPZJqcgES4TMDU3YX4k/VpZEjsOu6yTXzx08X4U0Ea5LNUxnOck=
=jvlw
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
