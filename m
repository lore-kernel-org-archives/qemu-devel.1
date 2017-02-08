Received: from eggs.gnu.org ([2001:4830:134:3::10]:51443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbUjO-0004gd-N4
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbUjL-0004vE-Fu
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:04:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cbUjL-0004v3-BK
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:04:27 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8198A7E9EE
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 16:04:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Feb 2017 17:04:22 +0100
Message-Id: <1486569864-17005-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Flatten simple unions where we still can
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

Markus Armbruster (2):
  numa: Turn simple union NumaOptions into a flat union
  net: Turn simple union NetLegacyOptions into a flat union

 net/net.c        | 44 ++++++++++++++++++++++----------------------
 numa.c           |  4 ++--
 qapi-schema.json | 17 +++++++++++++++++
 3 files changed, 41 insertions(+), 24 deletions(-)

-- 
2.7.4
