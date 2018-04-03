Received: from eggs.gnu.org ([2001:4830:134:3::10]:36592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3L7k-0000fv-J9
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3L7e-0007nD-S7
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:33:16 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3L7e-0007lv-L4
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:33:10 -0400
Received: by mail-wm0-x244.google.com with SMTP id x4so34804732wmh.5
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 05:33:10 -0700 (PDT)
Date: Tue, 3 Apr 2018 13:33:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180403123307.GC4467@stefanha-x1.localdomain>
References: <BEF9E38582252C4BB07E4CB23BD2FB1C02287BDD65@H3CMLB12-EX.srv.huawei-3com.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <BEF9E38582252C4BB07E4CB23BD2FB1C02287BDD65@H3CMLB12-EX.srv.huawei-3com.com>
Subject: Re: [Qemu-devel]
 =?utf-8?q?snapshot=EF=BC=9Acreate__snapshot_for_rbd?=
 =?utf-8?q?_disk_failed=2E?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhangzijian <zhang.zijian@h3c.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2018 at 03:44:00AM +0000, Zhangzijian wrote:
> Hello,

CCing Sheepdog block driver maintainers.

You can find maintainers for a source file using:

  $ scripts/get_maintainers -f block/sheepdog.c

>=20
> In 'bdrv_all_create_snapshot', each block will create snapshot in a for l=
oop. If a domain configured disk mixed with qcow2 and rbd.
> In 'qcow2_snapshot_create', sn_info->id_str will be set. But in 'qemu_rbd=
_snap_create' the 'id_str' is checked.=20
> On this condition, 'id_str' check will be failed. Since 'id_str' is usele=
ss for rbd, why this check is needed, Can it be removed?
>=20
> #0  qemu_rbd_snap_create (bs=3D0x55596a51eba0, sn_info=3D0x7fff4b0a0d60) =
at /root/code/qemu_201801/block/rbd.c:982
> #1  0x0000555967fca15e in bdrv_snapshot_create (bs=3D0x55596a51eba0, sn_i=
nfo=3D0x7fff4b0a0d60) at /root/code/qemu_201801/block/snapshot.c:171
> #2  0x0000555967fca18d in bdrv_snapshot_create (bs=3D0x55596a518890, sn_i=
nfo=3D0x7fff4b0a0d60) at /root/code/qemu_201801/block/snapshot.c:174
> #3  0x0000555967fcaf43 in bdrv_all_create_snapshot (sn=3D0x7fff4b0a0d60, =
vm_state_bs=3D0x55596a509750, vm_state_size=3D0, first_bad_bs=3D0x7fff4b0a0=
d10)
>     at /root/code/qemu_201801/block/snapshot.c:531
> #4  0x0000555967ed9362 in save_snapshot (name=3D0x55596bc37bf0 "snap1", n=
ostate=3Dtrue, errp=3D0x7fff4b0a10c0) at /root/code/qemu_201801/migration/s=
avevm.c:2256
> #5  0x0000555967ca9ad7 in hmp_savevm (mon=3D0x7fff4b0a1180, qdict=3D0x555=
96af40d60) at /root/code/qemu_201801/hmp.c:1334
> #6  0x0000555967b0f034 in handle_hmp_command (mon=3D0x7fff4b0a1180, cmdli=
ne=3D0x55596b4741e7 "-n snap1") at /root/code/qemu_201801/monitor.c:3110
> #7  0x0000555967b0872b in qmp_human_monitor_command (command_line=3D0x555=
96b4741e0 "savevm -n snap1", has_cpu_index=3Dfalse, cpu_index=3D0, errp=3D0=
x7fff4b0a12f0)
>     at /root/code/qemu_201801/monitor.c:614
>=20

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaw3SDAAoJEJykq7OBq3PIhtsH+wf581RZ2GBIRf25sFz6QrlV
Sh7rmrTqzjP1ff1ba51uEluo+BK6zq4OcKQA8hZrTDtka+hdwI5/WlLI5EVg1gCt
FhtxG75CshDz7NV+foGP8BPokH7V/VT0s3HitE+swnby/N6RBVrXROCNuPfcQ9qC
srpOmmIEFJdjUvVBNieznJQVAjZI23kKpj6H22xIf1AATL6Z1hT+WfIOrzxXGZmc
ujvBHABAOTSJgo3URZ9H20rBjZo5mLoMIYZjd/uTvgLmX50LGjCJ23AgpCg7QET/
D1ktjAzCs7NaNjbZcCN3CvSEwZP4a+8f/SQeipyRSZ6wD3qW0856sla+h8RjrdM=
=tb0Z
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
