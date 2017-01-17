Received: from eggs.gnu.org ([2001:4830:134:3::10]:35275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTZSx-0003s6-8w
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTZSr-00017s-NY
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTZSr-00015z-BS
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:41 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F259483F43
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 19:30:40 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 17 Jan 2017 17:30:30 -0200
Message-Id: <20170117193033.23178-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Remove arch_init SMBIOS and ACPI code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

This creates stubs for SMBIOS and ACPI option parsing functions,
so that we don't need arch-specific #ifdefs in arch_init just for
calling the option parsers.

Eduardo Habkost (3):
  stubs: Add smbios_entry_add() stub
  stubs: acpi_table_add() stub
  arch_init: Move acpi_table_add() call back to vl.c

 include/sysemu/arch_init.h |  2 --
 arch_init.c                | 20 --------------------
 stubs/acpi.c               |  7 +++++++
 stubs/smbios.c             |  7 +++++++
 vl.c                       |  9 +++++++--
 stubs/Makefile.objs        |  2 ++
 6 files changed, 23 insertions(+), 24 deletions(-)
 create mode 100644 stubs/acpi.c
 create mode 100644 stubs/smbios.c

-- 
2.11.0.259.g40922b1
