Received: from eggs.gnu.org ([2001:4830:134:3::10]:52962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cJ6hf-0004nv-GK
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cJ6hc-0008AZ-EI
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:46:43 -0500
Received: from mail-it0-x232.google.com ([2607:f8b0:4001:c0b::232]:35982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cJ6hc-00089t-9d
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:46:40 -0500
Received: by mail-it0-x232.google.com with SMTP id 75so46584010ite.1
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 14:46:38 -0800 (PST)
From: ben@skyportsystems.com
Date: Mon, 19 Dec 2016 14:46:29 -0800
Message-Id: <cover.1482187052.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH 0/5] RFC: Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This patch set adds support for passing a GUID to Windows guests.  It is a
re-implementation of previous patch sets written by Igor Mammedov et al, but
this time passing the GUID data as a fw_cfg blob.

This has been tested to work with Windows 2012 R2.  I consider it RFC quality
since there are probably problems with the HMP implementation and no unit tests
are included.

Ben Warren (3):
  docs: vm generation id device's description
  ACPI: Add a function for building named qword entries
  ACPI: Add Virtual Machine Generation ID support

Igor Mammedov (2):
  qmp/hmp: add query-vm-generation-id and 'info vm-generation-id'
    commands
  qmp/hmp: add set-vm-generation-id commands

 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 docs/specs/vmgenid.txt             |  39 ++++++++
 hmp-commands-info.hx               |  13 +++
 hmp-commands.hx                    |  13 +++
 hmp.c                              |  22 +++++
 hmp.h                              |   2 +
 hw/acpi/Makefile.objs              |   1 +
 hw/acpi/aml-build.c                |  28 ++++++
 hw/acpi/vmgenid.c                  | 198 +++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c               |   5 +
 hw/misc/Makefile.objs              |   1 +
 include/hw/acpi/aml-build.h        |   4 +
 include/hw/acpi/vmgenid.h          |  26 +++++
 qapi-schema.json                   |  32 ++++++
 stubs/Makefile.objs                |   1 +
 stubs/vmgenid.c                    |  14 +++
 17 files changed, 401 insertions(+)
 create mode 100644 docs/specs/vmgenid.txt
 create mode 100644 hw/acpi/vmgenid.c
 create mode 100644 include/hw/acpi/vmgenid.h
 create mode 100644 stubs/vmgenid.c

-- 
2.7.4
