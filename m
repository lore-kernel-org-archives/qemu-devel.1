Received: from eggs.gnu.org ([2001:4830:134:3::10]:33581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1gEt2S-0001Po-EB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1gEt2N-0007KF-F1
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:31:48 -0400
Received: from mail-eopbgr690088.outbound.protection.outlook.com
	([40.107.69.88]:17488
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Manish.Jaggi@cavium.com>)
	id 1gEt2N-000724-5o
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:31:43 -0400
From: <mjaggi@caviumnetworks.com>
Date: Tue, 23 Oct 2018 09:31:16 +0000
Message-ID: <cover.1536948621.git.manish.jaggi@cavium.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 0/2] [RFC] qemu: arm: Migration between
 machines with different MIDR values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, "Nowicki,
	Tomasz" <Tomasz.Nowicki@cavium.com>

From: Manish Jaggi <manish.jaggi@cavium.com>

QEMU on arm systems use -machine virt -cpu host option for a VM.
Migration thus is limited between machines with same cpu.

This is a limitation if migration is desired between cpus which are of same
family and have only few difeerences like bug fixes which have no effect on
VM operation. They just differ in say MIDR values.

This patchset introduces an option -hostinvariant whic along with a new KVM
error code -KVM_EINVARIANT will enable qemu to replace migrated guests'
invariant regiters with destination machines cpu regs.

This feature is user opt-in. So user is aware of the differences in MIDR.

Changes since v1-
This patch is revised after previous RFC comments
https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03546.html

Manish Jaggi (2):
  arm: Introduce hostinvariant command line option
  arm: program migrated guests' invariant registers with host ones

 qemu-options.hx  | 13 +++++++++++++
 target/arm/kvm.c | 15 +++++++++++++--
 vl.c             | 24 ++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 2 deletions(-)

--=20
1.8.3.1
