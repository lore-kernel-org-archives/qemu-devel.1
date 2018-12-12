Received: from eggs.gnu.org ([2001:4830:134:3::10]:39462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gX0zS-0004qx-Cn
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gX0zN-00066F-EY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:39:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gX0zN-000660-8k
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:39:33 -0500
Date: Wed, 12 Dec 2018 15:09:19 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <nycvar.YSQ.7.76.1812120137210.7578@xnncv>
Message-ID: <nycvar.YSQ.7.76.1812121253200.10904@xnncv>
References: <20181211132642.3027-1-ppandit@redhat.com>
	<20181211132642.3027-5-ppandit@redhat.com>
	<20181211164742.GA2923@lap1> <20181211172244.GD2923@lap1>
	<nycvar.YSQ.7.76.1812120137210.7578@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
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
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>

+-- On Wed, 12 Dec 2018, P J P wrote --+
| | Also, can you rebase this patch on top of the patchset i posted last =
week:
| | https://patchwork.kernel.org/patch/10705439/
|=20
| Okay, I'll send revised patch set. Thanks so much for the prompt review=
.

I tried to git apply above patch-set over v3.1.0-rc2, v3.1.0-rc0, v3.0.0.=
 But=20
it does not seem to apply cleanly.

=3D=3D=3D
$ git branch rdma v3.1.0-rc0
$ git checkout rdma=20
Switched to branch 'rdma'
$ git apply --check /tmp/add-support-for-RDMA-MAD.patch
error: patch failed: Makefile.objs:1
error: Makefile.objs: patch does not apply
error: patch failed: hw/rdma/vmw/pvrdma_cmd.c:224
error: hw/rdma/vmw/pvrdma_cmd.c: patch does not apply
=3D=3D=3D

I skipped one of the makefile.objs/.json patch, applied others and then=20
hand-fixed one of the patch pvrdma_cmd.c.

After that when I try to build QEMU, it fails with

=3D=3D=3D
 $ ./configure --prefix=3D/tmp/ --enable-debug
      --target-list=3D'x86_64-softmmu x86_64-linux-user'
      --enable-rdma --with-sdlabi=3D2.0
 $ make
../qemu/hw/rdma/rdma_backend.c:1132:5: error: implicit declaration of fun=
ction=20
=A1qapi_event_send_rdma_gid_status_changed=A2 [-Werror=3Dimplicit-functio=
n-declaration]  qapi_event_send_rdma_gid_status_changed(ifname, true,
...
../qemu/hw/rdma/rdma_backend.c:22:10: fatal error: qapi/qapi-events-rdma.=
h: No=20
such file or directory
 #include "qapi/qapi-events-rdma.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
=3D=3D=3D

Not sure if other patches are required. Any idea?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
