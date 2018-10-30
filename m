Received: from eggs.gnu.org ([2001:4830:134:3::10]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gHTFI-0005yC-WA
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gHTFE-0002dp-M1
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1gHTFD-0002U5-8c
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:35:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B278387AF4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 12:35:32 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Tue, 30 Oct 2018 13:35:23 +0100
Message-Id: <20181030123526.26415-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] Deprecate QMP & HMP `cpu-add`;
 document vCPU hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, thuth@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>

The first patch deprecates the QMP `cpu-add`, the second its HMP 
equivalent, and the third documents vCPU hotplug procedure using QMP
`device_add` et al.

v2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03191.html

Kashyap Chamarthy (3):
  Deprecate QMP `cpu-add`
  Deprecate HMP `cpu-add`
  docs: Document vCPU hotplug procedure

 docs/cpu-hotplug.rst | 142 +++++++++++++++++++++++++++++++++++++++++++
 hmp-commands.hx      |   6 +-
 hmp.c                |   2 +
 qapi/misc.json       |   8 ++-
 qemu-deprecated.texi |   5 ++
 5 files changed, 160 insertions(+), 3 deletions(-)
 create mode 100644 docs/cpu-hotplug.rst

-- 
2.17.1
