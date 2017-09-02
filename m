Received: from eggs.gnu.org ([2001:4830:134:3::10]:42341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1do8iU-0001ZD-No
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 09:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1do8iP-0004yg-Jx
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 09:44:06 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:34465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1do8iP-0004yC-CI
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 09:44:01 -0400
Received: by mail-oi0-x233.google.com with SMTP id w10so19349945oie.1
	for <qemu-devel@nongnu.org>; Sat, 02 Sep 2017 06:44:01 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
References: <1504250391-6353-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1504250391-6353-1-git-send-email-thuth@redhat.com>
Message-ID: <150435983310.16876.15013188369664932566@loki>
Date: Sat, 02 Sep 2017 08:43:53 -0500
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post about the release
 of version 2.10.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, pbonzini@redhat.com, qemu-devel@nongnu.org

Quoting Thomas Huth (2017-09-01 02:19:51)
> Using the contents of Micheal Roth's announce e-mail for this
> blog post.
> =

> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  _posts/2017-09-01-qemu-2-10-0.md | 56 ++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 _posts/2017-09-01-qemu-2-10-0.md
> =

> diff --git a/_posts/2017-09-01-qemu-2-10-0.md b/_posts/2017-09-01-qemu-2-=
10-0.md
> new file mode 100644
> index 0000000..adb1c89
> --- /dev/null
> +++ b/_posts/2017-09-01-qemu-2-10-0.md
> @@ -0,0 +1,56 @@
> +---
> +layout: post
> +title:  "QEMU version 2.10.0 released"
> +date:   2017-09-01 09:00:00 +0200
> +categories: [releases, 'qemu 2.10']
> +---
> +You can grab the tarball from our
> +[download page](https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__ww=
w.qemu.org_download_-23source&d=3DDwIBAg&c=3Djf_iaSHvJObTbx-siA1ZOg&r=3DsTh=
PI1c0u5x-3sg5Nw8wNqjg_5Z5xLzfPGC18E94zn8&m=3DPzYq08tHQcj1sxM1OMOnDI306yhwZl=
ucN-ByJd6q8sQ&s=3DYn7ZBayq012yWE5e70RVWA0QPziEmlje04XHMnXJIqY&e=3D ).
> +The full list of changes are available
> +[in the Wiki](https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__wiki=
.qemu.org_ChangeLog_2.10&d=3DDwIBAg&c=3Djf_iaSHvJObTbx-siA1ZOg&r=3DsThPI1c0=
u5x-3sg5Nw8wNqjg_5Z5xLzfPGC18E94zn8&m=3DPzYq08tHQcj1sxM1OMOnDI306yhwZlucN-B=
yJd6q8sQ&s=3Dk3QQu7lpwfgWOAF3Z0IB57eLKY8MiRYxIYxikNaGgrg&e=3D ).
> +
> +Highlights include:
> + * Support for ACPI NUMA distance info and control over CPU NUMA
> +   assignments via '-numa cpu' parameters
> + * Support for LUKS encryption format in qcow2 images
> + * Monitor/Management interface improvments: additional debug
> +   information available through 'info ramblock/cmma/register/qtree',
> +   support for viewing connected clients via 'info vnc', improved
> +   parsing support for QMP protocol, and other additional commands
> + * QXL and virtio-gpu support for controlling default display resolution
> + * Support for vhost-user-scsi devices
> + * NVMe emulation support for Write Zeroes command and Controller
> +   Memory Buffers
> + * Guest agent support for querying guest hostname, users, timezone, and
> +   OS version/release information
> + * ARM: KVM support for Raspberry Pi 3
> + * ARM: emulation support for MPS2/MPS2+ FPGA-based dev boards
> + * ARM: zynq: SPIPS flash support
> + * ARM: exynos4210: hardware PRNG device, SDHCI, and system poweroff
> + * Microblaze: support for CPU versions 9.4, 9.5, 9.6, and 10.0
> + * MIPS: support for Enhanced Virtual Addressing (EVA)
> + * MIPS: initrd support for kaslr-enabled kernels
> + * OpenRISC: support for shadow registers, idle states, and
> +   numcores/coreid/EVAR/EPH registers
> + * PowerPC: Multi-threaded TCG emulation support
> + * PowerPC: OpenBIOS VGA driver for MacOS guests
> + * PowerPC: pseries: KVM and emulation support for POWER9 guests
> + * PowerPC: pseries: support for hash page table resizing
> + * s390: channel device passthrough support via vfio-ccw
> + * s390: support for channel-attached 3270 "green screen" devices for
> +   use as guest consoles or additional TTYs
> + * s390: improved support for PCI (AEN, AIS, and zPCI)
> + * s390: support for z14 CPU models and netboot/TFTP via CCW BIOS, =

> + * s390: TCG support for atomic "LOAD AND x" and "COMPARE SWAP"
> +   operations, LOAD PROGRAM PARAMETER, extended facilities, CPU type,
> +   and many more less-common instructions.
> + * SH: TCG support for host atomic instructions for emulating tas.b and
> +   gUSA (user-space atomics), and support for fpchg/fsrra instructions
> + * SPARC: fixes for booting Solaris 2.6 on sun4m/OpenBIOS machines
> + * x86: Q35 MCH supports TSEG higher than 8MB
> + * x86: SSE register access via gdbstub
> + * Xen: support for multi-page shared rings, and 9pfs/virtfs backend
> + * Xtensa: sim machine console can be directed to chardev via -serial
> + * and lots more...
> +
> +Thank you to everyone involved!
> -- =

> 1.8.3.1
>=20
