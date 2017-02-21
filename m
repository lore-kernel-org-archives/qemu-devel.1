Received: from eggs.gnu.org ([2001:4830:134:3::10]:34841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHKU-0003Ql-7y
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHKR-0001f8-5Y
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgHKQ-0001ej-VZ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:31 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEB0E83F3E
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:46:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:46:25 +0100
Message-Id: <1487709988-14322-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Flatten simple unions where we still can
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Simple unions are simpler than flat unions in the schema, but more
complicated in C and on the QMP wire: there's extra indirection in C
and extra nesting on the wire, both pointless.  They're best avoided
in new code.

But we can do more: we can flatten the simple unions that aren't used
in QMP.

In the longer run, I'd love to get rid of simple unions entirely, and
reduce the notational overhead of flat unions in the schema.

v2:
* PATCH 1+2: Since: added [Eric], commit message tweaked
* PATCH 3: new

Markus Armbruster (3):
  numa: Flatten simple union NumaOptions
  net: Flatten simple union NetLegacyOptions
  i386/cpu: net: Flatten simple union GuestPanicInformationType

 net/net.c         | 44 ++++++++++++++++++++++----------------------
 numa.c            |  4 ++--
 qapi-schema.json  | 35 +++++++++++++++++++++++++++++++++--
 target/i386/cpu.c | 17 ++++++-----------
 vl.c              | 12 ++++++------
 5 files changed, 69 insertions(+), 43 deletions(-)

-- 
2.7.4
