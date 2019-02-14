Received: from eggs.gnu.org ([209.51.188.92]:56788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1guQZp-00012q-58
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1guQZi-0006NS-Df
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:37:53 -0500
Date: Thu, 14 Feb 2019 16:37:43 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190214163743.7162ad53@w520.home>
In-Reply-To: <20190214052144.59541-1-aik@ozlabs.ru>
References: <20190214052144.59541-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v2 0/4] spapr_pci,
 vfio: NVIDIA V100 + POWER9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>

On Thu, 14 Feb 2019 16:21:40 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This is for passing through NVIDIA V100 GPUs on POWER9 systems.
>=20
> This implements a subdriver for NVIDIA V100 GPU with coherent memory and
> NPU/ATS support available in the POWER9 CPU.
>=20
> 1/4 is a preparation for bigger DMA windows.
> 2/4 is a small cleanup.
>=20
> Here is the kernel driver:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/vfio/pci?h=3Dv5.0-rc6&id=3D7f92891778dff62303c070ac81de7b7d80de331a
>=20
> SLOF changes already went in.
>=20
> This depends on "pci: Move NVIDIA vendor id to the rest of ids" (posted s=
eparately).

TBH, I'm not sure it was the best idea to let it live or die on it's
own when it now creates a build dependency for this series.

> This is based on sha1
> 1ea6057 Mark Cave-Ayland "mac_newworld: change default NIC to sungem for =
mac99 machine".

Perhaps this is why it doesn't apply cleanly against qemu.git.  Are
there dependencies we need to wait for in the ppc tree as well?

> Please comment. Thanks.

Besides the build dependency on PCI_VENDOR_ID_NVIDIA, I also get this:

.../qemu.git/hw/vfio/spapr.c: In function =E2=80=98vfio_spapr_create_window=
=E2=80=99:
.../qemu.git/hw/vfio/spapr.c:212:9: error: =E2=80=98ret=E2=80=99 may be use=
d uninitialized in this function [-Werror=3Dmaybe-uninitialized]
         error_report("Failed to create a window, ret =3D %d (%m)", ret);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Is this series expected to go in through the ppc branch given the bulk
of the changes are there?  Thanks,

Alex
