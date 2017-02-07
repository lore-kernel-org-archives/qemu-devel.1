Received: from eggs.gnu.org ([2001:4830:134:3::10]:45554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cb9bO-0004kc-4e
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cb9bL-0004y1-Ci
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:30:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:49103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cb9bK-0004vf-VI
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:30:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cb9bI-0004w4-Gr
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 17:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 729EE2E80C1
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 17:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Feb 2017 17:20:49 -0000
From: Corey Olson <1662600@bugs.launchpad.net>
Reply-To: Bug 1662600 <1662600@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170207172049.29850.43816.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1662600] [NEW] error while building from source
 on Ubuntu 16.04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I'm trying to build Qemu from source (from git) as specified here:
http://www.qemu-project.org/download/#source

Here is the git commit hash for the source:
7d2c6c95511e42dffe2b263275e09957723d0ff4

During the 'make' step, I get the following error:

migration/rdma.c: In function =E2=80=98qemu_rdma_dump_id=E2=80=99:
migration/rdma.c:749:21: error: =E2=80=98struct ibv_port_attr=E2=80=99 has =
no member named =E2=80=98link_layer=E2=80=99
migration/rdma.c:750:22: error: =E2=80=98struct ibv_port_attr=E2=80=99 has =
no member named =E2=80=98link_layer=E2=80=99
migration/rdma.c:750:37: error: =E2=80=98IBV_LINK_LAYER_INFINIBAND=E2=80=99=
 undeclared (first use in this function)
migration/rdma.c:750:37: note: each undeclared identifier is reported only =
once for each function it appears in
migration/rdma.c:751:24: error: =E2=80=98struct ibv_port_attr=E2=80=99 has =
no member named =E2=80=98link_layer=E2=80=99
migration/rdma.c:751:39: error: =E2=80=98IBV_LINK_LAYER_ETHERNET=E2=80=99 u=
ndeclared (first use in this function)
migration/rdma.c: In function =E2=80=98qemu_rdma_broken_ipv6_kernel=E2=80=
=99:
migration/rdma.c:850:26: error: =E2=80=98struct ibv_port_attr=E2=80=99 has =
no member named =E2=80=98link_layer=E2=80=99
migration/rdma.c:850:41: error: =E2=80=98IBV_LINK_LAYER_INFINIBAND=E2=80=99=
 undeclared (first use in this function)
migration/rdma.c:852:33: error: =E2=80=98struct ibv_port_attr=E2=80=99 has =
no member named =E2=80=98link_layer=E2=80=99
migration/rdma.c:852:48: error: =E2=80=98IBV_LINK_LAYER_ETHERNET=E2=80=99 u=
ndeclared (first use in this function)
migration/rdma.c:891:18: error: =E2=80=98struct ibv_port_attr=E2=80=99 has =
no member named =E2=80=98link_layer=E2=80=99
make: *** [migration/rdma.o] Error 1

I searched around a bit, my problem seems related to this:
https://patchwork.kernel.org/patch/992952/

That issue makes me think my libibverbs may be out of date, but I
checked and I have libibverbs-dev installed.  Is that the correct
version?

FYI, I installed libibverbs-dev as suggested here: http://wiki.qemu-
project.org/index.php/Hosts/Linux#Recommended_additional_packages

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1662600

Title:
  error while building from source on Ubuntu 16.04

Status in QEMU:
  New

Bug description:
  I'm trying to build Qemu from source (from git) as specified here:
  http://www.qemu-project.org/download/#source

  Here is the git commit hash for the source:
  7d2c6c95511e42dffe2b263275e09957723d0ff4

  During the 'make' step, I get the following error:

  migration/rdma.c: In function =E2=80=98qemu_rdma_dump_id=E2=80=99:
  migration/rdma.c:749:21: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  migration/rdma.c:750:22: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  migration/rdma.c:750:37: error: =E2=80=98IBV_LINK_LAYER_INFINIBAND=E2=80=
=99 undeclared (first use in this function)
  migration/rdma.c:750:37: note: each undeclared identifier is reported onl=
y once for each function it appears in
  migration/rdma.c:751:24: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  migration/rdma.c:751:39: error: =E2=80=98IBV_LINK_LAYER_ETHERNET=E2=80=99=
 undeclared (first use in this function)
  migration/rdma.c: In function =E2=80=98qemu_rdma_broken_ipv6_kernel=E2=80=
=99:
  migration/rdma.c:850:26: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  migration/rdma.c:850:41: error: =E2=80=98IBV_LINK_LAYER_INFINIBAND=E2=80=
=99 undeclared (first use in this function)
  migration/rdma.c:852:33: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  migration/rdma.c:852:48: error: =E2=80=98IBV_LINK_LAYER_ETHERNET=E2=80=99=
 undeclared (first use in this function)
  migration/rdma.c:891:18: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  make: *** [migration/rdma.o] Error 1

  I searched around a bit, my problem seems related to this:
  https://patchwork.kernel.org/patch/992952/

  That issue makes me think my libibverbs may be out of date, but I
  checked and I have libibverbs-dev installed.  Is that the correct
  version?

  FYI, I installed libibverbs-dev as suggested here: http://wiki.qemu-
  project.org/index.php/Hosts/Linux#Recommended_additional_packages

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1662600/+subscriptions
