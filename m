Received: from eggs.gnu.org ([2001:4830:134:3::10]:41651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <f.gruenbichler@proxmox.com>) id 1cUBNz-0005nK-2I
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 07:00:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <f.gruenbichler@proxmox.com>) id 1cUBNu-0005XM-8A
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 07:00:11 -0500
Date: Thu, 19 Jan 2017 12:59:58 +0100
From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Message-ID: <20170119115958.zbpy42cmntwqfuas@nora.maurer-it.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5de45f2f-d83b-64d2-6406-dc09fd4c455f@redhat.com>
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

On Wed, Jan 18, 2017 at 05:30:17PM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 18/01/2017 17:19, Fabian Gr=FCnbichler wrote:
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#109 FAILED Resul=
t: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#109 Sense Key : =
Illegal Request [current]
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#109 Add. Sense: =
Invalid field in cdb
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#109 CDB: Write(1=
0) 2a 00 0d d6 51 48 00 08 00 00
> > Jan 18 17:07:51 ubuntu kernel: blk_update_request: critical target er=
ror, dev sda, sector 232149320
> > Jan 18 17:07:51 ubuntu kernel: EXT4-fs warning (device sda1): ext4_en=
d_bio:329: I/O error -121 writing to inode 125 (offset 0 size 0 starting =
block 29018921)
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logic=
al block 29018409
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logic=
al block 29018410
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logic=
al block 29018411
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logic=
al block 29018412
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logic=
al block 29018413
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logic=
al block 29018414
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logic=
al block 29018415
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logic=
al block 29018416
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logic=
al block 29018417
> > Jan 18 17:07:51 ubuntu kernel: Buffer I/O error on device sda1, logic=
al block 29018418
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#106 FAILED Resul=
t: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#106 Sense Key : =
Illegal Request [current]
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#106 Add. Sense: =
Invalid field in cdb
> > Jan 18 17:07:51 ubuntu kernel: sd 2:0:0:0: [sda] tag#106 CDB: Write(1=
0) 2a 00 0d d6 59 48 00 08 00 00
> > Jan 18 17:07:51 ubuntu kernel: blk_update_request: critical target er=
ror, dev sda, sector 232151368
> > Jan 18 17:07:51 ubuntu kernel: EXT4-fs warning (device sda1): ext4_en=
d_bio:329: I/O error -121 writing to inode 125 (offset 0 size 0 starting =
block 29019177)
> > Jan 18 17:07:52 ubuntu kernel: JBD2: Detected IO errors while flushin=
g file data on sda1-8
> > Jan 18 17:07:58 ubuntu kernel: JBD2: Detected IO errors while flushin=
g file data on sda1-8
> >=20
> >=20
> > strace (with some random grep-ing):
> > [pid  1794] ioctl(19, SG_IO, {'S', SG_DXFER_TO_DEV, cmd[10]=3D[2a, 00=
, 0d, d6, 51, 48, 00, 08, 00, 00], mx_sb_len=3D252, iovec_count=3D17, dxf=
er_len=3D1048576, timeout=3D4294967295, flags=3D0x1, data[1048576]=3D["\0=
`\235=3Dc\177\0\0\0\0\1\0\0\0\0\0\0`\236=3Dc\177\0\0\0\0\1\0\0\0\0\0"...]=
}) =3D -1 EINVAL (Invalid argument)
> > [pid  1794] ioctl(19, SG_IO, {'S', SG_DXFER_TO_DEV, cmd[10]=3D[2a, 00=
, 0d, d6, 59, 48, 00, 08, 00, 00], mx_sb_len=3D252, iovec_count=3D16, dxf=
er_len=3D1048576, timeout=3D4294967295, flags=3D0x1, data[1048576]=3D["\0=
`-=3Dc\177\0\0\0\0\1\0\0\0\0\0\0`.=3Dc\177\0\0\0\0\1\0\0\0\0\0"...]}) =3D=
 -1 EINVAL (Invalid argument)
>=20
> This is useful, thanks.  I suspect blk_rq_map_user_iov is failing,
> meaning that the scatter/gather list has too many segments for the HBA
> in the host.  (The limit can be found in /sys/block/sda/queue/max_segme=
nts).

limit is 168 for all the disks I tested with.

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

it is also very easily reproducible with both THP enable and defrag set
to madvise or always, if tested in fragmented- or low-memory conditions.

my test host has 64G of memory, my test VM 4G, huge pages are 2k big

if I simulate some memory load by repeatedly reserving 50G memory using
stress-ng:

# stress-ng --vm 50 --vm-bytes=3D1G --vm-hang 30

and then start the test VM and the dd-ing, I can see the big chunk of
AnonHugePages allocated to the VM system grow:

# grep -E 'AnonHugePages:[[:space:]]+[0-9]{5,} kB' /proc/$(pidof qemu-sys=
tem-x86_64)/smaps

up to about 3G (of 4G), and hit the issue.

without the additional load and fragmentation using stress-ng, the
AnonHugePages allocated to the qemu process grow to the expected 4G, and
the issue does not occur.

>=20
> I'm not sure how to fix it, unfortunately. :(

so this means either use non-transparent huge pages when using
scsi-block (haven't verified but should work?), or use aggressive THP
settings and/or always leave enough memory reserves? :-/ this is very
unfortunate IMHO (and probably also not a very realistic usage
scenario?)

>=20
> Paolo
>=20
