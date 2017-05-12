Received: from eggs.gnu.org ([2001:4830:134:3::10]:43864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d9DpE-0007iM-Ii
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d9Dp9-0007M7-Of
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:53:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1d9Dp9-0007Kd-Fx
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:53:51 -0400
Date: Fri, 12 May 2017 18:53:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170512165344.GD4312@noname.redhat.com>
References: <1494431760-6455-1-git-send-email-pagupta@redhat.com>
	<20170511181703.GC8701@stefanha-x1.localdomain>
	<1494538720.20270.35.camel@redhat.com>
	<20170512134213.GB589@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <20170512134213.GB589@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] KVM "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, pbonzini@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>, Dan Williams <dan.j.williams@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.05.2017 um 15:42 hat Stefan Hajnoczi geschrieben:
> On Thu, May 11, 2017 at 05:38:40PM -0400, Rik van Riel wrote:
> > On Thu, 2017-05-11 at 14:17 -0400, Stefan Hajnoczi wrote:
> > > On Wed, May 10, 2017 at 09:26:00PM +0530, Pankaj Gupta wrote:
> > > > * For live migration use case, if host side backing file is=A0
> > > > =A0 shared storage, we need to flush the page cache for the disk=A0
> > > > =A0 image at the destination (new fadvise interface,
> > > > FADV_INVALIDATE_CACHE?)=A0
> > > > =A0 before starting execution of the guest on the destination host.
> > >=20
> > > Good point.=A0=A0QEMU currently only supports live migration with
> > > O_DIRECT.
> > > I think the problem was that userspace cannot guarantee consistency
> > > in
> > > the general case.=A0=A0If you find a solution to this problem for fake
> > > NVDIMM then maybe the QEMU block layer can also begin supporting live
> > > migration with buffered I/O.
> >=20
> > I'll be happy to work with you on that, independently
> > of Pankaj's project.
> >=20
> > It looks like the fadvise system call could be extended
> > pretty easily with an FADV_INVALIDATE_CACHE command, the
> > other side of which can simply hook into the existing
> > page cache invalidation code in the kernel.
> >=20
> > Qemu will need to know whether the invalidation succeeded,
> > but that is something we can test for pretty easily before
> > returning to userspace.
>=20
> Sounds great.  I will review the long discussions that took place on
> qemu-devel about cache invalidation for live migration - just want to
> make sure there were no other reasons why only O_DIRECT is supported
> :).

There are other reasons why we recommend against using non-O_DIRECT
modes in production (including the error handling), but with respect to
live migration, this is the only one I'm aware of.

As I already said in the private email thread, an FADV_INVALIDATE_CACHE
should do the trick and I'd be happy to work with you guys on that.

Kevin

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZFeiYAAoJEH8JsnLIjy/WUBcP/01scmIsKxnx/FU2vexVdckt
YgFHuReip0EitHTJwVofawwXEyj8TT9AOpJ5v/d6tXIqpu+g82ujiOhEYtyf3n/B
eR5nL0GdcA0BMzr5GygfCdlrBVKT6rBRVt1v2KFim3wAD5p/9nCpWrThCHHUZ4UB
x2F7SuHcGNZTmzv410t29pNgUPI3s3qaoZh4HreRDB4Igu3mwJ+recVbDie8q5pG
QW1UsddPkz8PHqA72oMl/RuhnLb4tYOHxHExVdmZq3gTbbsk97C0jVHUOgf4b97x
dr6CacIIaN/3JLDNd/SJvqjPdJ7jysIlX/yZs1aDJSAgpZZEe2hWAcbp4SRdvxzO
b379JtiWGMMFls6JttPia/Y8swtDiyPrx4DcLT6MlXm/G5Kr0yHfZF3CckK1smJ0
f/atnZREK9moTsNdo93BGmWVn14SnywQqzTMD8MC+bH3KwQj9i7grxnmB4/Z1Fl8
nvn30zHqtGP7YZ9JDrIbbWBX5zmvLf2C9GryNObkO2X3ytbOxBkWJ/XHZMJwAO2e
DoYROF9oPBQGs+ULN/XV6Lff+BkmEGyCeSfnK9gWqQqAecX6GbqbsqvwRLV3YtQF
1k8mlxkc0+RagKMEAd1Vx6+vUEYFt9j6pKrbYEbQZYnIRq84uhe9hqyvUXEVsSVF
IqL+SXo+UF2hMM6nFHoK
=ds5u
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
