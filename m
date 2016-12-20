Received: from eggs.gnu.org ([2001:4830:134:3::10]:53761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cJGtg-0005cn-4P
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cJGtb-00055o-4K
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:39:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cJGta-00054n-Rn
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:39:43 -0500
Date: Tue, 20 Dec 2016 09:39:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161220093938.GB5602@stefanha-x1.localdomain>
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20161219150230.GA20757@stefanha-x1.localdomain>
	<20161219163214.GA9801@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20161219163214.GA9801@lemon>
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/4] block/qapi: refactor and
 optimize the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2016 at 12:32:40AM +0800, Fam Zheng wrote:
> On Mon, 12/19 15:02, Stefan Hajnoczi wrote:
> > On Mon, Dec 19, 2016 at 04:51:22PM +0800, Dou Liyang wrote:
> > > These patches aim to refactor the qmp_query_blockstats() and
> > > improve the performance by reducing the running time of it.
> > >=20
> > > qmp_query_blockstats() is used to monitor the blockstats, it
> > > querys all the graph_bdrv_states or monitor_block_backends.
> > >=20
> > > There are the two jobs:
> > >=20
> > > 1 For the performance:
> > >=20
> > > 1.1 the time it takes(ns) in each time:
> > > the disk numbers     | 10    | 500
> > > -------------------------------------
> > > before these patches | 19429 | 667722=20
> > > after these patches  | 17516 | 557044
> > >=20
> > > 1.2 the I/O performance is degraded(%) during the monitor:
> > >=20
> > > the disk numbers     | 10    | 500
> > > -------------------------------------
> > > before these patches | 1.3   | 14.2
> > > after these patches  | 0.8   | 9.1
> >=20
> > Do you know what is consuming the remaining 9.1%?
> >=20
> > I'm surprised to see such a high performance impact caused by a QMP
> > command.
>=20
> If it's "performance is 9.1% worse only during the 557044 ns when the QMP
> command is being processed", it's probably becaues the main loop is stall=
ed a
> bit, and it's not a big problem. I'd be very surprised if the degradation=
 is
> more longer than that.

It would be interesting to compare against virtio-blk dataplane.  That
way the QMP command can execute without interfering with disk I/O activity.

qemu-system-x86_64 ... \
    -object iothread,id=3Diothread0 \
    -drive if=3Dnone,id=3Ddrive0,file=3Dvm.img,format=3Draw,aio=3Dnative,ca=
che=3Dnone \
    -device virtio-blk-pci,drive=3Ddrive0,iothread=3Diothread0

Stefan

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYWPxaAAoJEJykq7OBq3PIk+UH/RjnA1bsnGg2ddiTY4NgX0I2
M+hABJ8asQxqWR8n82lm1qExb6g7vDZvForMtilAGKMabvm/YXUArjo4AAV1Q/QC
EPRS2T9eHRJp9A+ndJMHQvIknMGq3iXX/ZN/sw/aWSJE7HVsFW9SCFGUmw8rxaC2
oHSZjSgohbXwowf4vDsjzgnbYlqCQRVcUwTp48YIxHP6Z9WKONv4YRxfWph3Fhbe
wD29fcQbfncjrHeoZZuSHJ7sZySxFpr5J7WIdXwVLNalmz9e+WMPTp2fbGFln7lS
rd0zfTdBkJMlroTRzsA5jrNy/U32tSO0G5nfsgUGDv76ld0L6nOSa1bprGayT9M=
=nII0
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
