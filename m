Received: from eggs.gnu.org ([2001:4830:134:3::10]:57815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <f.gruenbichler@proxmox.com>) id 1cTtrf-0005LO-6U
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <f.gruenbichler@proxmox.com>) id 1cTtra-0000hb-4o
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:17:39 -0500
Date: Wed, 18 Jan 2017 18:17:28 +0100 (CET)
From: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
Message-ID: <341909038.142.1484759849151@webmail.proxmox.com>
In-Reply-To: <5de45f2f-d83b-64d2-6406-dc09fd4c455f@redhat.com>
References: <5878AF90.8020709@kamp.de>
	<260873230.6154791.1484638426777.JavaMail.zimbra@oxygem.tv>
	<20170117080326.dfjqzwstfxusuhgc@nora.maurer-it.com>
	<b7f5dc23-6d72-4897-e9ca-6482acfb4c72@redhat.com>
	<20170117112224.2st4wuivcbwuif2m@nora.maurer-it.com>
	<196ac8f5-2fd7-37e9-d577-8177802d0fb4@redhat.com>
	<40cbdb51-3dcc-35bc-bb99-6c85a47d20d0@redhat.com>
	<20170118115050.6o2ut7wtfkuzy5oh@nora.maurer-it.com>
	<20170118161941.g72fzppyyc3pdwkf@nora.maurer-it.com>
	<5de45f2f-d83b-64d2-6406-dc09fd4c455f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-stable] Data corruption in Qemu 2.7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexandre DERUMIER <aderumier@odiso.com>, qemu-stable <qemu-stable@nongnu.org>


> Paolo Bonzini <pbonzini@redhat.com> hat am 18. Januar 2017 um 17:30 gesch=
rieben:
>=20
>=20
>=20
>=20
> On 18/01/2017 17:19, Fabian Gr=C3=BCnbichler wrote:
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#109 FAILED Result:=
 hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#109 Sense Key : Il=
legal Request [current]
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#109 Add. Sense: In=
valid field in cdb
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#109 CDB: Write(10)=
 2a 00 0d d6 51 48 00 08 00 00
> > Jan 18 17:07:51 ubuntu kernel: blk_update_request: critical target erro=
r, dev sda, sector 232149320
> > Jan 18 17:07:51 ubuntu kernel: EXT4-fs warning (device sda1): ext4_end_=
bio:329: I/O error -121 writing to inode 125 (offset 0 size 0 starting bloc=
k 29018921)
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logical=
 block 29018409
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logical=
 block 29018410
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logical=
 block 29018411
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logical=
 block 29018412
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logical=
 block 29018413
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logical=
 block 29018414
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logical=
 block 29018415
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logical=
 block 29018416
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logical=
 block 29018417
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logical=
 block 29018418
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#106 FAILED Result:=
 hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#106 Sense Key : Il=
legal Request [current]
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#106 Add. Sense: In=
valid field in cdb
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#106 CDB: Write(10)=
 2a 00 0d d6 59 48 00 08 00 00
> > Jan 18 17:07:51 ubuntu kernel: blk_update_request: critical target erro=
r, dev sda, sector 232151368
> > Jan 18 17:07:51 ubuntu kernel: EXT4-fs warning (device sda1): ext4_end_=
bio:329: I/O error -121 writing to inode 125 (offset 0 size 0 starting bloc=
k 29019177)
> > Jan 18 17:07:52 ubuntu kernel: JBD2: Detected IO errors while flushing =
file data on sda1-8
> > Jan 18 17:07:58 ubuntu kernel: JBD2: Detected IO errors while flushing =
file data on sda1-8
> >=20
> >=20
> > strace (with some random grep-ing):
> > [pid  1794] ioctl(19, SG_IO, {'S', SG_DXFER_TO_DEV, cmd[10]=3D[2a, 00, =
0d, d6, 51, 48, 00, 08, 00, 00], mx_sb_len=3D252, iovec_count=3D17, dxfer_l=
en=3D1048576, timeout=3D4294967295, flags=3D0x1, data[1048576]=3D["\0`\235=
=3Dc\177\0\0\0\0\1\0\0\0\0\0\0`\236=3Dc\177\0\0\0\0\1\0\0\0\0\0"...]}) =3D =
-1 EINVAL (Invalid argument)
> > [pid  1794] ioctl(19, SG_IO, {'S', SG_DXFER_TO_DEV, cmd[10]=3D[2a, 00, =
0d, d6, 59, 48, 00, 08, 00, 00], mx_sb_len=3D252, iovec_count=3D16, dxfer_l=
en=3D1048576, timeout=3D4294967295, flags=3D0x1, data[1048576]=3D["\0`-=3Dc=
\177\0\0\0\0\1\0\0\0\0\0\0`.=3Dc\177\0\0\0\0\1\0\0\0\0\0"...]}) =3D -1 EINV=
AL (Invalid argument)
>=20
> This is useful, thanks.  I suspect blk_rq_map_user_iov is failing,
> meaning that the scatter/gather list has too many segments for the HBA
> in the host.  (The limit can be found in /sys/block/sda/queue/max_segment=
s).

I can try to get some more info tomorrow..

>=20
> This is consistent with your finding here:
>=20
> > disabling THP on the hypervisor host with
> >=20
> > # echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled
> >=20
> > allows reproducing the bug very reliably, shutting the VM down, then
> > enabling THP (with 'always') and trying again makes it go away.
>=20
> because no THP means more memory fragmentation and thus more segments.
>=20
> I'm not sure how to fix it, unfortunately. :(

Well at least this means we have a (potentially too conservative) check for=
 deciding when to use scsi-disk instead of scsi-block (maybe this could be =
detected in qemu as well?).

Seems especially troublesome since the (hypervisor) admin can change it at =
runtime, and it seems like there are widespread recommendations to disable =
THP for e.g., DB use cases..

>=20
> Paolo
>
