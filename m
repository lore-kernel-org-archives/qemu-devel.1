Received: from eggs.gnu.org ([2001:4830:134:3::10]:58777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dELlY-0005XT-0b
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dELlX-0005OW-9K
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:23:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dELlX-0005OL-3Q
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:23:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D1C7C04BD36
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 20:23:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 26 May 2017 17:23:13 -0300
Message-Id: <20170526202316.22736-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qmp: Return extra information on
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

This series adds 'abstract' and 'parent' fields to the output of
qom-list-types.

For reference, below are the sizes of the output of
"qom-list-types abstract=true" on qemu-system-x86_64, before and
after applying the patches:

* before: 11724 bytes
* with 'abstract' field: 13146 bytes
* with 'abstract' and 'parent': 24046 bytes

Changes v1 (RFC) -> v2:
* Make 'parent' field optional, to make output shorter
* Return only immediate parent type on 'parent' field, instead of
  all parent-types on a 'parent-types' field

Eduardo Habkost (3):
  tests: Simplify abstract-interfaces check with a helper
  qmp: Include 'abstract' field on 'qom-list-types' output
  qmp: Include parent type on 'qom-list-types' output

 qapi-schema.json               |   7 +-
 qmp.c                          |   6 ++
 tests/device-introspect-test.c | 156 +++++++++++++++++++++++++++++++++--------
 3 files changed, 139 insertions(+), 30 deletions(-)

-- 
2.11.0.259.g40922b1
