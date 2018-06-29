Received: from eggs.gnu.org ([2001:4830:134:3::10]:44839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYzUj-0000K6-3O
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYzUg-0004eN-0V
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:55:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYzUf-0004e7-Ry
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:55:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 178057DAC6
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 19:55:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 29 Jun 2018 14:55:42 -0500
Message-Id: <20180629195544.34263-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qapi: easier debugging of introspection
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

When inspecting the generated qapi-introspect.c (for debugging,
or to see what QAPI changes are user visible vs. internal only),
the fact that we've intentionally masked names from the QMP client
makes it harder to tie back generated code back to the original
QAPI .json files.  We have a -u switch to qapi-gen for temporarily
bypassing the name masking, but that's a rather heavy-handed
tactic just for some temporary debugging.  Better is to just make
the generated file include strategic comments.

Eric Blake (2):
  qapi: Add comments to aid debugging generated introspection
  qapi: Drop qapi-gen --unmask option

 scripts/qapi-gen.py        |  5 +----
 scripts/qapi/introspect.py | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.14.4
