Received: from eggs.gnu.org ([2001:4830:134:3::10]:39138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO2LW-0005d4-Ma
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO2LV-00009s-P7
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:45:02 -0400
Date: Wed, 30 May 2018 15:44:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530144450.GB5973@stefanha-x1.localdomain>
References: <1514187226.13662.28.camel@intel.com>
	<6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
	<20180508150309.GC4065@localhost.localdomain>
	<20180509101618.GC19645@stefanha-x1.localdomain>
	<d8a06161-d611-4f27-f4c8-f14370f191d4@redhat.com>
	<20180510082659.GC1296@stefanha-x1.localdomain>
	<20180511172531.GB5016@localhost.localdomain>
	<20180514134846.GD5182@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20180514134846.GD5182@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] Some question about savem/qcow2
 incremental snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, He Junyan <junyan.he@intel.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, qemu-devel@nongnu.org, qemu block <qemu-block@nongnu.org>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 02:48:47PM +0100, Stefan Hajnoczi wrote:
> On Fri, May 11, 2018 at 07:25:31PM +0200, Kevin Wolf wrote:
> > Am 10.05.2018 um 10:26 hat Stefan Hajnoczi geschrieben:
> > > On Wed, May 09, 2018 at 07:54:31PM +0200, Max Reitz wrote:
> > > > On 2018-05-09 12:16, Stefan Hajnoczi wrote:
> > > > > On Tue, May 08, 2018 at 05:03:09PM +0200, Kevin Wolf wrote:
> > > > >> Am 08.05.2018 um 16:41 hat Eric Blake geschrieben:
> > > > >>> On 12/25/2017 01:33 AM, He Junyan wrote:
> > > > >> I think it makes sense to invest some effort into such interface=
s, but
> > > > >> be prepared for a long journey.
> > > > >=20
> > > > > I like the suggestion but it needs to be followed up with a concr=
ete
> > > > > design that is feasible and fair for Junyan and others to impleme=
nt.
> > > > > Otherwise the "long journey" is really just a way of rejecting th=
is
> > > > > feature.

The discussion on NVDIMM via the block layer has runs its course.  It
would be a big project and I don't think it's fair to ask Junyan to
implement it.

My understanding is this patch series doesn't modify the qcow2 on-disk
file format.  Rather, it just uses existing qcow2 mechanisms and extends
live migration to identify the NVDIMM state state region to share the
clusters.

Since this feature does not involve qcow2 format changes and is just an
optimization (dirty blocks still need to be allocated), it can be
removed from QEMU in the future if a better alternative becomes
available.

Junyan: Can you rebase the series and send a new revision?

Kevin and Max: Does this sound alright?

Stefan

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDrjiAAoJEJykq7OBq3PIy+sH/2ABa8CuOfmxHv9mH6os9SIU
iBqQp4akv6cb7K8LZIgAp7G7CiBXgx1Kk/KJp0VeSoMDBobidd/V4kZnFDfVQLpA
Ewg9ZOk1DeeHnlWclHFibqTNlxkU2S7eLJE1jK9E78XsobuqdIdc62AzZwfKXmDG
60rycU96daybuc6+Nhk69DPB1seWFZ3UvAYqsWh9xZziEWf/Lt+SVrcRPoguS5zn
523vd7zaO7oCWcPr6Jl9lvZ20ngECBQePpH06Tf6hC27Z/IqT/RspEhGpdakeq2k
hAA5YJDUGzBG7McuY1qrbEXX6gHEr+o9bc8PFyKS05UJ5bp9+5xLg+8jc8evh8w=
=dvOw
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
