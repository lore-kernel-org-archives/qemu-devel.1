Received: from eggs.gnu.org ([2001:4830:134:3::10]:34815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEWKI-0003k9-WC
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEWKG-00006m-QZ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:44:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fEWKG-00006K-Ll
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:44:24 -0400
Date: Fri, 4 May 2018 09:44:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180504084413.GF18897@stefanha-x1.localdomain>
References: <20180427215314.23168-1-ross.zwisler@linux.intel.com>
	<20180430113858.GH4002@stefanha-x1.localdomain>
	<20180503222013.GA23376@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline
In-Reply-To: <20180503222013.GA23376@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] nvdimm: fix typo in label-size
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, linux-nvdimm <linux-nvdimm@lists.01.org>, Igor Mammedov <imammedo@redhat.com>


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 04:20:13PM -0600, Ross Zwisler wrote:
> On Mon, Apr 30, 2018 at 12:38:58PM +0100, Stefan Hajnoczi wrote:
> > On Fri, Apr 27, 2018 at 03:53:12PM -0600, Ross Zwisler wrote:
> > > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > > Fixes: commit da6789c27c2e ("nvdimm: add a macro for property "label-=
size"")
> > > Cc: Haozhong Zhang <haozhong.zhang@intel.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  hw/mem/nvdimm.c         | 2 +-
> > >  include/hw/mem/nvdimm.h | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Thank you for the review.
>=20
> This is my first QEMU submission - do I need to do anything else to get t=
his
> merged (create a pull request somewhere), or do I just wait for a maintai=
ner
> to pull it in?

Michael Tsirkin and Igor Mammedov are the maintainers who will review
and merge this series.  You don't need to do anything (I have CCed Igor
now).

Please include a cover letter in a multi-patch series in the future.
This doesn't prevent this patch series from being merged.

Stefan

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa7B1dAAoJEJykq7OBq3PI8QsH+wX+193D1RQFnYI5FtvuIEfd
XLmNDK/V5iIc29ZQ4dMlTkTXPcvVgbke45dvJBisul6r5LyN4EEyGUvxr8ZxYfc7
lV3GN+ThPFYeRi2y5VEgUFDSZTgE/KQdCTsqig7smR+9SojXn80NilCu7PMDQ7w4
yIcoXjS7VNS1eUzHueLmjXSqDczdb1gMX19vriO28M0X0bd4oJb0fr0GJZHzvLzk
yBMT9puo40NzT7zCE5b0r/xJtpgIh69TfOAAgjzCxevQdodcSjw/KA7BGnXIgkvq
HEmnbOErkcSvryk7NSvizDJahral2o0ruo9pFrixs5HvM3pfIrPH6KkjZz+crWw=
=0WSH
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--
