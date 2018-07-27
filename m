Received: from eggs.gnu.org ([2001:4830:134:3::10]:38963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2BP-0000MM-VG
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2BM-0004Hd-QE
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:49:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fj2BM-0004H6-DK
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:49:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id g6-v6so4961507wrp.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 05:49:20 -0700 (PDT)
Date: Fri, 27 Jul 2018 13:49:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180727124917.GC28555@stefanha-x1.localdomain>
References: <1531900083-18167-1-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <1531900083-18167-1-git-send-email-junyan.he@gmx.com>
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
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, yi.z.zhang@intel.com, rth@twiddle.net, junyan.he@gmx.com


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 03:47:56PM +0800, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
>=20
> QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and live m=
igration.
> If the backend is on the persistent memory, QEMU needs to take proper ope=
rations to
> ensure its writes persistent on the persistent memory. Otherwise, a host =
power failure
> may result in the loss the guest data on the persistent memory.

Ping Michael.  Can this go through your tree?

>=20
> This patch series is based on Marcel's patch "mem: add share parameter to=
 memory-backend-ram" [1]
> because of the changes in patch 1.
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.html
>=20
> Previous versions of this patch series can be found at:=20
> v10: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03433.html
> v9: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg02361.html
> v8: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg02279.html
> v7: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02997.html
> v6: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg00061.html
> v5: https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02258.html
> V4: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06993.html
> v3: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04365.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01579.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.html
>=20
> Changes in v11:
> * (Patch 2) Modify the ram_flags parameter to 32bits, the same size as it=
 in RAMBlock
> * (Patch 5 and Patch 7) Delete pmem_xxx stub functions in stubs/pmem.c. U=
se inline
> functions with assert to replace them, because we never come there when p=
mem is enabled
> but lack of libpmem support.
>=20
> Changes in v10:
> * (Patch 4) Fix a nit in nvdimm docs about pmem option usage in command l=
ine=20
> The v10 patch set is all reviewed by Igor Mammedov <imammedo@redhat.com>
>=20
> Changes in v9:
> * (Patch 3 and Patch 4) Reorder these two patches to make logic right.
> Firstly add libpmem support, and then we can use libpmem's configure
> check result. Also fix some typo and grammar issues in these two patches.
>=20
> Changs in v8:=20
> * (Patch 3) Report a error when user set 'pmem' to file-backend, while
> the qemu is lack of libpmem support. In this case, we can not ensure
> the persistence of the file-backend, so we choose to fail the build
> rather than contine and make the thing more confused.
>=20
> Changes in v7:=20
> The v6 patch set has already reviewed by Stefan Hajnoczi <stefanha@redhat=
=2Ecom>
> No logic change in this v7 version, just:
> * Spelling check and some document words refined.
> * Rebase to "ram is migratable" patch set.
>=20
> Changes in v6:=20
> * (Patch 1) Expose all ram block flags rather than redefine the flags.
> * (Patch 4) Use pkg-config rather the hard check when configure.=20
> * (Patch 7) Sync and flush all the pmem data when migration completes,
> rather than sync pages one by one in previous version.
>=20
> Changes in v5:=20
> * (Patch 9) Add post copy check and output some messages for nvdimm.
>=20
> Changes in v4:=20
> * (Patch 2) Fix compilation errors found by patchew.
>=20
> Changes in v3:
> * (Patch 5) Add a is_pmem flag to ram_handle_compressed() and handle
> PMEM writes in it, so we don't need the _common function.
> * (Patch 6) Expose qemu_get_buffer_common so we can remove the
> unnecessary qemu_get_buffer_to_pmem wrapper.
> * (Patch 8) Add a is_pmem flag to xbzrle_decode_buffer() and handle
> PMEM writes in it, so we can remove the unnecessary
> xbzrle_decode_buffer_{common, to_pmem}.
> * Move libpmem stubs to stubs/pmem.c and fix the compilation failures
> of test-{xbzrle,vmstate}.c.
>=20
> Changes in v2:
> * (Patch 1) Use a flags parameter in file ram allocation functions.
> * (Patch 2) Add a new option 'pmem' to hostmem-file.
> * (Patch 3) Use libpmem to operate on the persistent memory, rather
> than re-implementing those operations in QEMU.
> * (Patch 5-8) Consider the write persistence in the migration path.
>=20
>=20
> Junyan:
> [1/7] memory, exec: Expose all memory block related flags.
> [6/7] migration/ram: Add check and info message to nvdimm post copy.
> [7/7] migration/ram: ensure write persistence on loading all date to PMEM.
>=20
> Haozhong:
> [5/7] mem/nvdimm: ensure write persistence to PMEM in label emulation
>=20
> Haozhong & Junyan:
> [2/7] memory, exec: switch file ram allocation functions to 'flags' param=
eters
> [3/7] configure: add libpmem support [4/7] hostmem-file: add the 'pmem' o=
ption
> [4/7] hostmem-file: add the 'pmem' option
>=20
> --
> backends/hostmem-file.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
> configure               | 29 +++++++++++++++++++++++++++++
> docs/nvdimm.txt         | 22 ++++++++++++++++++++++
> exec.c                  | 38 +++++++++++++-------------------------
> hw/mem/nvdimm.c         |  9 ++++++++-
> include/exec/memory.h   | 31 +++++++++++++++++++++++++++++--
> include/exec/ram_addr.h | 28 ++++++++++++++++++++++++++--
> include/qemu/pmem.h     | 36 ++++++++++++++++++++++++++++++++++++
> memory.c                |  8 +++++---
> migration/ram.c         | 17 +++++++++++++++++
> numa.c                  |  2 +-
> qemu-options.hx         |  7 +++++++
> 12 files changed, 235 insertions(+), 36 deletions(-)
> create mode 100644 include/qemu/pmem.h
>=20
> --=20
> 2.7.4
>=20
>=20

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWxTNAAoJEJykq7OBq3PIgv8H+gLlkr6RJ2z4mmYIFXdmCbm7
AD7T/p1+uZ2RC77+69erIZw95fmALNc7+hNRI2v/PcUzNxOrcKpH9nAAldrGtM2i
/cO/ZhHAsLjoqbTHU30gRpNzAfW0ptENbadU3yrpoY5+4CE4NlKUV4nvJpbOSl1C
VrObTOIpGZk/+ODfM327wp0tCkWSB0/+PB+hWUE4PvHwcHFenwnYXIOwFX77CK8U
ZYzGmlBbCG5uFHVDTsP556TSa3ANI41HkSGzqsmxGbl61sRXYwfgtFoL6iYGNDIq
mZwnTeoDcwmi09FAqzqBg4oHPRcMByYiUFon8A1sGnTa1z09DHfE9y7whU3/m3g=
=EN1G
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
