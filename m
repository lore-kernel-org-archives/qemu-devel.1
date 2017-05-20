Received: from eggs.gnu.org ([2001:4830:134:3::10]:45000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dBtpb-0000jr-43
	for qemu-devel@nongnu.org; Fri, 19 May 2017 22:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dBtpW-0005P4-5L
	for qemu-devel@nongnu.org; Fri, 19 May 2017 22:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dBtpV-0005Ot-VM
	for qemu-devel@nongnu.org; Fri, 19 May 2017 22:09:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6C3061E50
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 02:09:16 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 May 2017 23:09:11 -0300
Message-Id: <20170520020914.14562-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 0/3] qmp: Return extra information on
 qom-list-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

This series adds 'abstract' and 'parent-types' fields to the
output of qom-list-types.

For reference, below are the sizes of the output of
"qom-list-types abstract=true" on qemu-system-x86_64, before and
after applying the patches:

* before: 11724 bytes
* with 'abstract' field: 20119 bytes
* with 'abstract' and 'parent-types': 44383 bytes

I'm not sure if extending qom-list-types with this info is the
right way to go, or if we should keep qom-list-types as-is and
add a new "query-qom-type" QMP command to query info on one QOM
type at a time.

Eduardo Habkost (3):
  tests: Simplify abstract-interfaces check with a helper
  qmp: Include 'abstract' field on 'qom-list-types' output
  qmp: Include parent types on 'qom-list-types' output

 qapi-schema.json               |   9 ++-
 qmp.c                          |  17 ++++++
 tests/device-introspect-test.c | 131 ++++++++++++++++++++++++++++++++---------
 3 files changed, 127 insertions(+), 30 deletions(-)

-- 
2.11.0.259.g40922b1
