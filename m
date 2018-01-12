Received: from eggs.gnu.org ([2001:4830:134:3::10]:50293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ea5qw-00034L-K8
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ea5qv-0001j6-Ih
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:23:02 -0500
Received: from mail-dm3nam03on0726.outbound.protection.outlook.com
	([2a01:111:f400:fe49::726]:3340
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1ea5qv-0001gV-9B
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:23:01 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Fri, 12 Jan 2018 12:22:24 -0800
Message-Id: <1515788548-3570-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/4] Implements the Windows Hypervisor Platform
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

Hello QEMU Community!

Over the past few months the Hyper-V team at Microsoft has been working hard on
a new user-mode API for our hypervisor that will be released as part of the
upcoming SDK. This new API adds user-mode capabilities to create and manage
partitions at the hypervisor level, configure memory mappings for the
partition, and create and control execution of virtual processors.

With this new API we are now able to bring our hypervisor to the QEMU
community! The following patches implement the Windows Hypervisor Platform
accelerator (WHPX) for QEMU on Windows 10 hosts.

When compiling QEMU for x86_64 passing the --enable-whpx flag will compile the
accelerator for use. At runtime using the '-accel whpx' should see a
significant performance improvement over emulation, much like when using 'hax'
on Windows.

Over the next few days the pre-release version of the documentation for this new
API will be visible at https://docs.microsoft.com/en-us/virtualization under
the 'Windows Hypervisor Platform' section. Here you will see the requirements,
API, and examples.

Thank you for your feedback. 

Justin Terry (VM) (4):
  Add the Windows Hypervisor Platform accelerator.
  Add the WHPX vcpu API
  Introduce the WHPX impl
  Add the WHPX acceleration enlightenments

 accel/stubs/Makefile.objs |    9 +-
 accel/stubs/whpx-stub.c   |   48 ++
 configure                 |   48 +-
 cpus.c                    |   66 ++-
 include/sysemu/hw_accel.h |   13 +
 include/sysemu/whpx.h     |   40 ++
 qemu-options.hx           |    8 +-
 target/i386/Makefile.objs |    1 +
 target/i386/helper.c      |    2 +-
 target/i386/whpx-all.c    | 1395 +++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 1619 insertions(+), 11 deletions(-)
 create mode 100644 accel/stubs/whpx-stub.c
 create mode 100644 include/sysemu/whpx.h
 create mode 100644 target/i386/whpx-all.c

-- 
2.7.4
