Received: from eggs.gnu.org ([2001:4830:134:3::10]:60909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZvvI-0001cb-Ru
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZvvH-0001db-WD
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:46:52 -0500
Date: Fri, 12 Jan 2018 09:46:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180112094619.GC7356@stefanha-x1.localdomain>
References: <20180112085555.14447-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <20180112085555.14447-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/9] block: Add VFIO based driver for
 NVMe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, alex.williamson@redhat.com, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 12, 2018 at 04:55:46PM +0800, Fam Zheng wrote:
> v5: Add Stefan's rev-bys.
>     Add Paolo's sob line.
>     Address Stefan's, Alex's and Eric's comments, including:
>     - Add PCI Bar MMIO offset/size parameter to VFIO utility API. [Alex]
>     - Fix various lock and memory leakings. [Stefan]
>     - Improve documentation. [Stefan]
>     - Add one missing "Since 2.12" in QAPI schema. [Eric]
>     - Fix locking of BDRVNVMeState->inflight. [Stefan]
>     - Add one missing endianness conversion for cmd.nsid. [Stefan]
>     - Use bdrv_get_aio_context() instead of qemu_get_current_aio_context().
>     - When init, issue "Set Features" command to enable/disable volatile write
>       cache according to "flags & BDRV_O_NOCACHE".

I left comments on the main patch.  The rest looks good.

Stefan

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaWIPrAAoJEJykq7OBq3PIcLMIAKi0LwScx12wIlab/1em720o
GO/PjS97g1pxMhtMnNCvjQdZ85ePfl9F9h1Q4gL3O8oLRky0x2sM/7pqlwrkAnYT
qWQRuB/yNZ3wet1NDAIDCAZbyJIX63aiuVhwY8th0q+au/0vTrkrx2SOF85vY7+b
kGvNbuMmfp1gr1huVNokGlDCT/mSk6SuEjS5u8NP6VhR2JGFuK8M7B5GWUDYpjGU
WYFSeGRotStfpRV9zoLOfrp/zifLfXsK05PddTrVeQkdWDY5XIFUnqKplkDjVfU8
nTaJdu8+JmMgXl1a+jG1946Pa2MTsY0Db4ag9pi7zcaHUFYkBy/joW3FrA/ODLc=
=HdB5
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
