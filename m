Received: from eggs.gnu.org ([2001:4830:134:3::10]:35446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3ezV-0000Mu-57
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3ezT-0004xY-4M
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3ezS-0004wn-UQ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:31 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 27 Apr 2017 10:41:22 +0200
Message-Id: <1493282486-28338-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] qapi: Loose ends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mdroth@linux.vnet.ibm.com

This series addresses a few minor things that came up in review, but
too late to be addressed in 2.9.

Markus Armbruster (4):
  qmp: Improve QMP dispatch error messages
  qobject-input-visitor: Document full_name_nth()
  qapi: Document intended use of @name within alternate visits
  qobject-input-visitor: Catch misuse of end_struct vs. end_list

 include/qapi/visitor.h       |  6 ++++--
 qapi/qmp-dispatch.c          | 14 +++++++-------
 qapi/qobject-input-visitor.c | 32 ++++++++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 11 deletions(-)

-- 
2.7.4
