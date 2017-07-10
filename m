Received: from eggs.gnu.org ([2001:4830:134:3::10]:48189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUaJM-0003Ek-SM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUaJL-00029H-W2
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:09:20 -0400
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-4-famz@redhat.com>
	<20170710150707.GK14195@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61a85481-9194-d68e-2544-d80365fca83e@redhat.com>
Date: Mon, 10 Jul 2017 17:08:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170710150707.GK14195@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P185gxeO3U4SbF6OCKdRsvMdc7Mhn2rOo"
Subject: Re: [Qemu-devel] [PATCH v3 3/6] block: Introduce bdrv_dma_map and
 bdrv_dma_unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Karl Rister <krister@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P185gxeO3U4SbF6OCKdRsvMdc7Mhn2rOo
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Karl Rister <krister@redhat.com>
Message-ID: <61a85481-9194-d68e-2544-d80365fca83e@redhat.com>
Subject: Re: [PATCH v3 3/6] block: Introduce bdrv_dma_map and bdrv_dma_unmap
References: <20170705133635.11850-1-famz@redhat.com>
 <20170705133635.11850-4-famz@redhat.com>
 <20170710150707.GK14195@stefanha-x1.localdomain>
In-Reply-To: <20170710150707.GK14195@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/07/2017 17:07, Stefan Hajnoczi wrote:
> On Wed, Jul 05, 2017 at 09:36:32PM +0800, Fam Zheng wrote:
>> Allow block driver to map and unmap a buffer for later I/O, as a perfo=
rmance
>> hint.
> The name blk_dma_map() is confusing since other "dma" APIs like
> dma_addr_t and dma_blk_io() deal with guest physical addresses instead
> of host addresses.  They are about DMA to/from guest RAM.
>=20
> Have you considered hiding this cached mapping in block/nvme.c so that
> it isn't exposed?  block/nvme.c could keep the last buffer mapped and
> callers would get the performance benefit without a new blk_dma_map()
> API.

One buffer is enough for qemu-img bench, but not for more complex cases
(e.g. fio).

Paolo


--P185gxeO3U4SbF6OCKdRsvMdc7Mhn2rOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlljmIgACgkQv/vSX3jH
roO5Ywf6A3vKSiQYtGLTYSXbuLdrZ0PxIxCm/latuE8qINsocSMepj9uOVK/ifOp
Chg0GBbQp+025qAxRJ5hzZTmF+rK3vN5/05MkTlGhZhABIM7vdTZvTW+c5GkeB4l
FNdDaspl5vzW6IJsxh12w5lq8oPA7twn3O+PGc9F/2aKI7cDPeAOzH+4hUon8WtP
xKG2Lg7ueKAoRggfW0Cz+o3Rxeg+0L5t1WBH27+KPrKQRWhtGakIkCm+Ex44zsj0
glWtK5Jbuvw60SqRgITRFX5fNWSFwDMAWCGgcRhVW/TzGnCL0o2h51L75GH1SHrP
LhERYWkXEpHiB3yKAzkYC75oTPHiLg==
=AONR
-----END PGP SIGNATURE-----

--P185gxeO3U4SbF6OCKdRsvMdc7Mhn2rOo--
