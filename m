Received: from eggs.gnu.org ([209.51.188.92]:41854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghF0C-0004wv-6e
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghF0B-0007Hl-6S
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:38:40 -0500
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
	<1540876720-9574-3-git-send-email-liq3ea@gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b445d1bd-48ad-82a7-9775-53419ce1a4a2@redhat.com>
Date: Wed, 9 Jan 2019 15:38:04 +0100
MIME-Version: 1.0
In-Reply-To: <1540876720-9574-3-git-send-email-liq3ea@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q7l6ofKTCdqCjQhLt3hfKX16G7ZCPcSEI"
Subject: Re: [Qemu-devel] [PATCH 2/4] nvme: ensure the num_queues is not zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q7l6ofKTCdqCjQhLt3hfKX16G7ZCPcSEI
From: Max Reitz <mreitz@redhat.com>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <b445d1bd-48ad-82a7-9775-53419ce1a4a2@redhat.com>
Subject: Re: [PATCH 2/4] nvme: ensure the num_queues is not zero
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
 <1540876720-9574-3-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540876720-9574-3-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.10.18 06:18, Li Qiang wrote:
> When it is zero, it causes segv. Backtrack:
> Thread 5 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.=

> [Switching to Thread 0x7fffc6c17700 (LWP 51808)]
> 0x0000555555acbd90 in nvme_start_ctrl (n=3D0x6240000c8100) at hw/block/=
nvme.c:820
> warning: Source file is more recent than executable.
> 820	    if (unlikely(n->cq[0])) {
> (gdb) bt
> 0  0x0000555555acbd90 in nvme_start_ctrl (n=3D0x6240000c8100) at hw/blo=
ck/nvme.c:820
> 1  0x0000555555accdbc in nvme_write_bar (n=3D0x6240000c8100, offset=3D2=
0, data=3D4587521, size=3D4) at hw/block/nvme.c:964
> 2  0x0000555555acdd2b in nvme_mmio_write (opaque=3D0x6240000c8100, addr=
=3D20, data=3D4587521, size=3D4) at hw/block/nvme.c:1158
> 3  0x00005555558973ed in memory_region_write_accessor (mr=3D0x6240000c8=
9e0, addr=3D20, value=3D0x7fffc6c14428, size=3D4, shift=3D0, mask=3D42949=
67295, attrs=3D...) at /home/liqiang02/qemu-upstream/qemu/memory.c:500
> 4  0x0000555555897600 in access_with_adjusted_size (addr=3D20, value=3D=
0x7fffc6c14428, size=3D4, access_size_min=3D2, access_size_max=3D8, acces=
s_fn=3D0x555555897304 <memory_region_write_accessor>, mr=3D0x6240000c89e0=
, attrs=3D...) at /home/liqiang02/qemu-upstream/qemu/memory.c:566
> 5  0x000055555589a200 in memory_region_dispatch_write (mr=3D0x6240000c8=
9e0, addr=3D20, data=3D4587521, size=3D4, attrs=3D...) at /home/liqiang02=
/qemu-upstream/qemu/memory.c:1442
> 6  0x0000555555835151 in flatview_write_continue (fv=3D0x6060000e6fc0, =
addr=3D4273930260, attrs=3D..., buf=3D0x7fffc8a18028 "\001", len=3D4, add=
r1=3D20, l=3D4, mr=3D0x6240000c89e0) at /home/liqiang02/qemu-upstream/qem=
u/exec.c:3233
> 7  0x000055555583529b in flatview_write (fv=3D0x6060000e6fc0, addr=3D42=
73930260, attrs=3D..., buf=3D0x7fffc8a18028 "\001", len=3D4) at /home/liq=
iang02/qemu-upstream/qemu/exec.c:3272
> 8  0x00005555558355a1 in address_space_write (as=3D0x55555683ade0 <addr=
ess_space_memory>, addr=3D4273930260, attrs=3D..., buf=3D0x7fffc8a18028 "=
\001", len=3D4) at /home/liqiang02/qemu-upstream/qemu/exec.c:3362
> 9  0x00005555558355f2 in address_space_rw (as=3D0x55555683ade0 <address=
_space_memory>, addr=3D4273930260, attrs=3D..., buf=3D0x7fffc8a18028 "\00=
1", len=3D4, is_write=3Dtrue) at /home/liqiang02/qemu-upstream/qemu/exec.=
c:3373
> 10 0x00005555558b66ac in kvm_cpu_exec (cpu=3D0x631000014800) at /home/l=
iqiang02/qemu-upstream/qemu/accel/kvm/kvm-all.c:2031
> 11 0x000055555587c3ac in qemu_kvm_cpu_thread_fn (arg=3D0x631000014800) =
at /home/liqiang02/qemu-upstream/qemu/cpus.c:1277
> 12 0x0000555555e54ae6 in qemu_thread_start (args=3D0x60300002c170) at u=
til/qemu-thread-posix.c:504
> 13 0x00007fffdadbd494 in start_thread () from /lib/x86_64-linux-gnu/lib=
pthread.so.0
> 14 0x00007fffdaaffacf in clone () from /lib/x86_64-linux-gnu/libc.so.6
> (gdb) q
>=20
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/block/nvme.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 676cc48..72c9644 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1221,6 +1221,10 @@ static void nvme_realize(PCIDevice *pci_dev, Err=
or **errp)
>          error_setg(errp, "serial property not set");
>          return;
>      }
> +
> +    if (!n->num_queues) {
> +        error_setg(errp, "num_queues can't be zero");

I think we should return here.

(Sorry for the late review...)

Max

> +    }
>      blkconf_blocksizes(&n->conf);
>      if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->c=
onf.blk),
>                                         false, errp)) {
>=20



--q7l6ofKTCdqCjQhLt3hfKX16G7ZCPcSEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2B0wACgkQ9AfbAGHV
z0AEiAgAg7yPbi6ycFmVMKC6jzGWc0aOX24EmmV1PumXSt+qU+xr3yifrEo1z3oE
q1y3u1AUvnM5jFEFC+YE4Mt0MmzVjBTDjYGR4wfu93bQbnNBcCwbvYllBavsI9nA
DKstR2DVfBEZxQGzJlfVULaBc6NBFZvbqttFQkq2lcbWTywmmMg1M2Qc65qxu1Ii
ul2sy3zjSDonm/h5LMuW/4MkCY3EY88FJfvfpFWG0KJ6Z2l8zuPxsdjYT8pxDIqS
qdJ3E3S8k2U/1rLIOXlOD3QfcWmpEjkSsZn//1bEkD2kGAca1fPyf8JDEsUAxFIt
1W3vdc04AwLZCVvyIpewb0cEUmDkkw==
=58Rm
-----END PGP SIGNATURE-----

--q7l6ofKTCdqCjQhLt3hfKX16G7ZCPcSEI--
