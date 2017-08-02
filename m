Received: from eggs.gnu.org ([2001:4830:134:3::10]:57709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcrBZ-0000O0-38
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcrBW-00029I-15
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:47:29 -0400
Date: Wed, 2 Aug 2017 11:47:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170802104712.GG5531@stefanha-x1.localdomain>
References: <20170726141924.qaqclberxsup5cdm@postretch>
	<20170726151221.GA3600@stefanha-x1.localdomain>
	<20170726182320.cnqx3y64c7nmhvp3@postretch>
	<11af0732-e024-6651-5b65-07eb98d8bb17@redhat.com>
	<20170728115538.GC3983@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline
In-Reply-To: <20170728115538.GC3983@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC] block-insert-node and block-job-delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, Jeff Cody <jcody@redhat.com>, armbru@redhat.com


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 01:55:38PM +0200, Kevin Wolf wrote:
> Am 28.07.2017 um 00:09 hat John Snow geschrieben:
> > On 07/26/2017 02:23 PM, Manos Pitsidianakis wrote:
> > > On Wed, Jul 26, 2017 at 04:12:21PM +0100, Stefan Hajnoczi wrote:
> > > > On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wrote:
> > I think I agree with Stefan's concerns that this is more of a
> > temporary workaround for the benefit of jobs, but that there may well
> > be other reasons (especially in the future) where graph manipulations
> > may occur invisibly to the user.
>=20
> We should do our best to avoid this. Implicit graph changes only make
> libvirt's life hard. I agree that we'll have many more graph changes in
> the future, but let's keep them as explicit as possible.

Speaking of implicit graph changes: the COLO replication driver
(block/replication.c) uses the backup job internally and that requires
before write notifiers.  That means there is an implicit graph change
when COLO decides to complete the backup job.

Stefan

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZga2wAAoJEJykq7OBq3PIa4sH/3KwFsoEvWm/RsPDC7ZzkbMf
Nf91sYx7j/YO0x5lhkFwNVff44+4FjScdiRB4aNpcfGZ7W0R2W7cEA/s/AgBAeHR
brX71DqhQJ4lC+1nQ75Lqi6Q3f4TILv6pXraKS+j95tnn7ZOni7h312eDQ88HjZu
x1dfKoBtIq/Mcej2DiwYbyOb6fDH5CVOMeyCJkv6r6hIi7EcoalCMtxFauohHW2B
HbXePuBS2AbsHddcF+VWvmOZ3/Q9Ir1IkYd+C/o9YasujM6ToScL5KkhuS7p9bhB
GjEZowKf3ECC3fdwKY2UkoSX3YvWO1wMa/DSJnfeoQ78eB6VB6GCgcUARd2uB4o=
=bW63
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--
