Received: from eggs.gnu.org ([2001:4830:134:3::10]:49326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfmWl-0000VR-Oy
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfmWi-0006At-J8
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:25:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfmWi-00069o-Dg
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:25:24 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 10 Aug 2017 14:25:19 +0200
Message-Id: <1502367921-17730-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] vl: Partial support for non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: el13635@mail.ntua.gr, kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, pbonzini@redhat.com

Markus Armbruster (2):
  vl: Factor object_create() out of main()
  vl: Partial support for non-scalar properties with -object

 qapi-schema.json | 14 ++++++++---
 vl.c             | 74 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 75 insertions(+), 13 deletions(-)

-- 
2.7.5
