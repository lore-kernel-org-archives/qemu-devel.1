Received: from eggs.gnu.org ([2001:4830:134:3::10]:56486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqmKU-00058V-0A
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqmKT-00065s-5K
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:58:30 -0500
References: <151960115637.1084.1354693340560487769@bdbb90650ae5>
From: John Snow <jsnow@redhat.com>
Message-ID: <4e63b032-e42d-8fed-b0f5-eeb9a46d2e1f@redhat.com>
Date: Tue, 27 Feb 2018 15:58:18 -0500
MIME-Version: 1.0
In-Reply-To: <151960115637.1084.1354693340560487769@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 00/21] blockjobs: add explicit job
 management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com



On 02/25/2018 06:25 PM, no-reply@patchew.org wrote:
>   CC      scsi/qemu-pr-helper.o
> /var/tmp/patchew-tester-tmp-9ukz0kme/src/blockjob.c: In function =E2=80=
=98block_job_txn_apply.isra.8=E2=80=99:
> /var/tmp/patchew-tester-tmp-9ukz0kme/src/blockjob.c:511:5: error: =E2=80=
=98rc=E2=80=99 may be used uninitialized in this function [-Werror=3Dmayb=
e-uninitialized]
>      return rc;
>      ^
>   CC      qemu-bridge-helper.o
>   CC      blockdev.o
>   CC      blockdev-nbd.o
>   CC      bootdevice.o
>   CC      iothread.o
>   CC      qdev-monitor.o
>   CC      device-hotplug.o
>   CC      os-posix.o
>   CC      bt-host.o
>   CC      bt-vhci.o
>   CC      dma-helpers.o
>   CC      vl.o
>   CC      tpm.o
>   CC      device_tree.o
>   CC      qmp-marshal.o
>   CC      qmp.o
>   CC      hmp.o
>   CC      cpus-common.o
>   CC      audio/audio.o
> cc1: all warnings being treated as errors
> make: *** [blockjob.o] Error 1
> make: *** Waiting for unfinished jobs....
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

No idea why this would only trigger on ppc/be, but I'll look into it.
