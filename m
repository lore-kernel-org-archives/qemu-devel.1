Received: from eggs.gnu.org ([2001:4830:134:3::10]:38080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <somlo@cmu.edu>) id 1eDrYf-0004fj-ES
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <somlo@cmu.edu>) id 1eDrYa-0005ae-NI
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:40:15 -0500
Received: from smtp.andrew.cmu.edu ([128.2.105.203]:52650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <somlo@cmu.edu>) id 1eDrYa-0005YJ-IN
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:40:12 -0500
Date: Sun, 12 Nov 2017 07:40:03 -0500
From: "Gabriel L. Somlo" <somlo@cmu.edu>
Message-ID: <20171112124003.GA19857@hedwig.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171031151938.14982-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/5] fw_cfg: add DMA operations &
 etc/vmcoreinfo support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, somlo@cmu.edu, qemu-devel@nongnu.org, mst@redhat.com

On Tue, Oct 31, 2017 at 04:19:33PM +0100, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> This series adds DMA operations support to the qemu fw_cfg kernel
> module and populates "etc/vmcoreinfo" with vmcoreinfo location
> details.
>=20
> Note: the support for this entry handling has been merged for next
> qemu release (2.11)
>=20
> v4:
> - export paddr_vmcoreinfo_note() to fix fw_cfg.ko build
> - fix build with !CONFIG_CRASH_CORE
> - replace the unbounded yield() loop with a usleep_range() loop and a
>   200ms timeout
> - do not write vmcoreinfo entry when running the kdump kernel (D. Hatay=
ama)
> - drop the experimental sysfs write support patch from this series

Tested it on x86_64, appears to work fine.
I have a couple of silly questions re. 3/5 and 5/5. Lost the v5 emails
with the vmcore folks cc-ed, but my questions are unrelated to vmcore
anyway :)

Thanks,
--Gabriel

>=20
> v3: (thanks kbuild)
> - add "fw_cfg: fix the command line module name" patch
> - fix build of "fw_cfg: add DMA register" with CONFIG_FW_CFG_SYSFS_CMDL=
INE=3Dy
> - fix 'Wshift-count-overflow'
>=20
> v2:
> - use platform device for dma mapping
> - add etc/vmcoreinfo patch
> - some code cleanups
>=20
> Marc-Andr=E9 Lureau (5):
>   fw_cfg: fix the command line module name
>   fw_cfg: add DMA register
>   fw_cfg: do DMA read operation
>   crash: export paddr_vmcoreinfo_note()
>   fw_cfg: write vmcoreinfo details
>=20
>  drivers/firmware/qemu_fw_cfg.c | 292 +++++++++++++++++++++++++++++++++=
++++----
>  kernel/crash_core.c            |   1 +
>  2 files changed, 264 insertions(+), 29 deletions(-)
>=20
> --=20
> 2.15.0.rc0.40.gaefcc5f6f
>=20
