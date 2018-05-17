Received: from eggs.gnu.org ([2001:4830:134:3::10]:45578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fJB2b-00023Z-Sa
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fJB2W-0001Vv-Uz
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:01:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:63828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fJB2W-0000lw-MC
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:01:20 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Wed, 16 May 2018 23:00:20 -0600
Message-Id: <20180517050024.20101-1-ross.zwisler@linux.intel.com>
Subject: [Qemu-devel] [qemu PATCH v2 0/4] support NFIT platform capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Ross Zwisler <ross.zwisler@linux.intel.com>

The first 2 patches in this series clean up some things I noticed while
coding.

Patch 3 adds support for the new Platform Capabilities Structure, which
was added to the NFIT in ACPI 6.2 Errata A.  We add a machine command
line option "nvdimm-cap":

    -machine pc,accel=kvm,nvdimm,nvdimm-cap=2

which allows the user to pass in a value for this structure.  When such
a value is passed in we will generate the new NFIT subtable.

Patch 4 adds code to the "make check" self test infrastructure so that
we generate the new Platform Capabilities Structure, and adds it to the
expected NFIT output so that we test for it.

Thanks to Igor Mammedov for his feedback on v1 of this set.

Ross Zwisler (4):
  nvdimm: fix typo in label-size definition
  tests/.gitignore: add entry for generated file
  nvdimm, acpi: support NFIT platform capabilities
  ACPI testing: test NFIT platform capabilities

 docs/nvdimm.txt                       |  18 ++++++++++++++
 hw/acpi/nvdimm.c                      |  44 ++++++++++++++++++++++++++++++----
 hw/i386/pc.c                          |  31 ++++++++++++++++++++++++
 hw/mem/nvdimm.c                       |   2 +-
 include/hw/i386/pc.h                  |   1 +
 include/hw/mem/nvdimm.h               |   7 +++++-
 tests/.gitignore                      |   1 +
 tests/acpi-test-data/pc/NFIT.dimmpxm  | Bin 224 -> 240 bytes
 tests/acpi-test-data/q35/NFIT.dimmpxm | Bin 224 -> 240 bytes
 tests/bios-tables-test.c              |   2 +-
 10 files changed, 99 insertions(+), 7 deletions(-)

-- 
2.14.3
