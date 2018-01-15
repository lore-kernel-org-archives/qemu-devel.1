Received: from eggs.gnu.org ([2001:4830:134:3::10]:33430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eb5MC-0001fS-Ol
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eb5M3-00036F-NB
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:03:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eb5M3-00034W-GO
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:03:15 -0500
Date: Mon, 15 Jan 2018 14:02:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180115140257.GH13238@stefanha-x1.localdomain>
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<5A5704B4.5090502@intel.com>
	<CAJSP0QWyaE8qUGMgcpzB460Y=kpX4VDfqFWm-CWmmX4X3nmRMQ@mail.gmail.com>
	<5A585930.1030009@intel.com>
	<20180112103736.GF7356@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F7393CA35E@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhtSGe8h3+lMyY1M"
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7393CA35E@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>


--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2018 at 03:36:19AM +0000, Wang, Wei W wrote:
> On Friday, January 12, 2018 6:38 PM, Stefan Hajnoczi wrote:
> > On Fri, Jan 12, 2018 at 02:44:00PM +0800, Wei Wang wrote:
> > > On 01/11/2018 05:56 PM, Stefan Hajnoczi wrote:
> > > > On Thu, Jan 11, 2018 at 6:31 AM, Wei Wang <wei.w.wang@intel.com>
> > wrote:
> > > > > On 01/11/2018 12:14 AM, Stefan Hajnoczi wrote:
> > I think the virtio-vhost-user end result is worth it though: vhost devi=
ces like
> > examples/vhost/ and examples/vhost/scsi/ will work with both AF_UNIX and
> > virtio-vhost-user.  This makes it simpler for users and vhost device
> > developers - you only have one implementation of net, scsi, blk, etc de=
vices.
>=20
> For the driver part, isn't it that net, scsi, blk will have their own sep=
arate implementation on top of the common libret_vhost?

Yes.

The following DPDK components use librte_vhost:

drivers/net/vhost
examples/tep_termination
examples/vhost
examples/vhost_scsi

They will all be able to use virtio-vhost-user.

Stefan

--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaXLSRAAoJEJykq7OBq3PIfMIH/A1XP5KOXfP/5Lpz+OOaYYo5
KV0iAfhlp7nfk795BLsMst5C5TXsZLAAp9p73221xjMsaSaPJO9b+IQAIHXWxNv6
ef8/XRCpaz4V0kASzFSZ99foBT+Izcj4I2fQAB+FUbZv3uSuS5QXUdwzC65yaToM
3q4wNX06lbvrQhzs2HV+13mTPiNEYPJ4g951DZVsMhsZgFgKGwKXyvOQUCfFtYLM
01jQMQ2Dtl6OtVpzxL5I9Tfkg1j0izuJriejIGiZVA6BvNbmbyaGT0p9oKPgbQLE
wCW2SILwu2esgvfqMfRlQU6q5oVfnhIFqrq40GAt05GhJQykyAr/bGGVtUrRYHU=
=AzyC
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--
