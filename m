Received: from eggs.gnu.org ([2001:4830:134:3::10]:54993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX8vu-0000rY-TD
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX8vp-0004Nx-QT
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:08:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gX8vo-0004L9-Vm
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:08:25 -0500
Date: Wed, 12 Dec 2018 20:08:04 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181212180804.GF5747@lap1>
References: <20181211132642.3027-1-ppandit@redhat.com>
	<20181211132642.3027-5-ppandit@redhat.com>
	<20181211164742.GA2923@lap1> <20181211172244.GD2923@lap1>
	<nycvar.YSQ.7.76.1812120137210.7578@xnncv>
	<nycvar.YSQ.7.76.1812121253200.10904@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1812121253200.10904@xnncv>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] pvrdma: release ring object in case of
 an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, yuval.shaia@oracle.com

On Wed, Dec 12, 2018 at 03:09:19PM +0530, P J P wrote:
> +-- On Wed, 12 Dec 2018, P J P wrote --+
> | | Also, can you rebase this patch on top of the patchset i posted las=
t week:
> | | https://patchwork.kernel.org/patch/10705439/
> |=20
> | Okay, I'll send revised patch set. Thanks so much for the prompt revi=
ew.
>=20
> I tried to git apply above patch-set over v3.1.0-rc2, v3.1.0-rc0, v3.0.=
0. But=20
> it does not seem to apply cleanly.
>=20
> =3D=3D=3D
> $ git branch rdma v3.1.0-rc0

Can you try master?
I just did a rebase on top of master and had no conflicts.

> $ git checkout rdma=20
> Switched to branch 'rdma'
> $ git apply --check /tmp/add-support-for-RDMA-MAD.patch
> error: patch failed: Makefile.objs:1
> error: Makefile.objs: patch does not apply
> error: patch failed: hw/rdma/vmw/pvrdma_cmd.c:224
> error: hw/rdma/vmw/pvrdma_cmd.c: patch does not apply
> =3D=3D=3D
>=20
> I skipped one of the makefile.objs/.json patch, applied others and then=
=20
> hand-fixed one of the patch pvrdma_cmd.c.
>=20
> After that when I try to build QEMU, it fails with
>=20
> =3D=3D=3D
>  $ ./configure --prefix=3D/tmp/ --enable-debug
>       --target-list=3D'x86_64-softmmu x86_64-linux-user'
>       --enable-rdma --with-sdlabi=3D2.0
>  $ make
> ../qemu/hw/rdma/rdma_backend.c:1132:5: error: implicit declaration of f=
unction=20
> =E2=80=98qapi_event_send_rdma_gid_status_changed=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]  qapi_event_send_rdma_gid_status_changed(ifn=
ame, true,
> ...
> ../qemu/hw/rdma/rdma_backend.c:22:10: fatal error: qapi/qapi-events-rdm=
a.h: No=20
> such file or directory
>  #include "qapi/qapi-events-rdma.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> =3D=3D=3D
>=20
> Not sure if other patches are required. Any idea?
>=20
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
