Received: from eggs.gnu.org ([2001:4830:134:3::10]:55019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eK7m7-0006FK-Vm
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eK7m3-0002y6-SA
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:12:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eK7m3-0002xq-Ct
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:11:59 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vATJA5mM087618
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 14:11:55 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ej188vae4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 14:11:55 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 29 Nov 2017 12:11:54 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 29 Nov 2017 13:11:38 -0600
Message-Id: <151198269829.22232.14116010638342203089@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.11.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fourth release candidate for the QEMU 2.11 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.11.0-rc3.tar.xz
  http://download.qemu-project.org/qemu-2.11.0-rc3.tar.xz.sig

You can help improve the quality of the QEMU 2.11 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.11

Please add entries to the ChangeLog for the 2.11 release below:

  http://wiki.qemu.org/ChangeLog/2.11

Changes since rc2:

c11d61271b: Update version for v2.11.0-rc3 release (Peter Maydell)
f1a7ff770f: block/nfs: fix nfs_client_open for filesize greater than 1TB (P=
eter Lieven)
fc24908e7d: blockjob: reimplement block_job_sleep_ns to allow cancellation =
(Paolo Bonzini)
356f59b875: blockjob: introduce block_job_do_yield (Paolo Bonzini)
5bf1d5a73a: blockjob: remove clock argument from block_job_sleep_ns (Paolo =
Bonzini)
02d213009d: block: Expect graph changes in bdrv_parent_drained_begin/end (K=
evin Wolf)
0a3e155f3f: blockjob: Remove the job from the list earlier in block_job_unr=
ef() (Alberto Garcia)
51ae4f8455: nbd/server: CVE-2017-15118 Stack smash on large export name (Er=
ic Blake)
fdad35ef6c: nbd/server: CVE-2017-15119 Reject options larger than 32M (Eric=
 Blake)
2d7ad7c05e: sockets: avoid crash when cleaning up sockets for an invalid FD=
 (Daniel P. Berrange)
70e53e6e4d: virtio-net: don't touch virtqueue if vm is stopped (Jason Wang)
c117bb14ff: QAPI & interop: Clarify events emitted by 'block-job-cancel' (K=
ashyap Chamarthy)
1878eaff9b: qemu-options: Mention locking option of file driver (Fam Zheng)
b1d1cb2728: docs: Add image locking subsection (Fam Zheng)
45f1882a9e: iotests: fix 075 and 078 (John Snow)
e07cc19295: target/ppc: Fix setting of cpu->compat_pvr on incoming migratio=
n (Suraj Jitindar Singh)
ee4d9ecc36: target/ppc: Move setting of patb_entry on hash table init (Sura=
j Jitindar Singh)
e7b47c22e2: osdep.h: Make TIME_MAX handle different time_t types (Peter May=
dell)
79283dda30: hw/arm/virt: Add 2.11 machine type (Eric Auger)
c1c4c2192c: s390/kvm_virtio/linux-headers: remove traces of old virtio tran=
sport (Christian Borntraeger)
c65d5e4e1d: configure: Deal with OpenBSD/i386 emulation linker (Brad Smith)
2fe47fce78: Fix build of console and GUI executables for Windows (Stefan We=
il)
8f2c4cbc76: tcg: Fix compilation without TCG (Juan Quintela)
acab30b85d: migration/ram.c: do not set 'postcopy_running' in POSTCOPY_INCO=
MING_END (Daniel Henrique Barboza)
6dd836f5d3: ppc: fix VTB migration (Laurent Vivier)
6c3bc244d3: spapr: Implement bug in spapr-vty device to be compatible with =
PowerVM (David Gibson)
bac658d1a4: hw/ppc/spapr: Fix virtio-scsi bootindex handling for LUNs >=3D =
256 (Thomas Huth)
5d6c599fe1: migration, xen: Fix block image lock issue on live migration (A=
nthony PERARD)
