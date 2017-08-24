Received: from eggs.gnu.org ([2001:4830:134:3::10]:49140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkqr0-0003yQ-PF
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkqqx-0001yS-2g
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkqqw-0001y5-TE
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D64C1C01416B
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 12:03:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 14:02:55 +0200
Message-Id: <1503576178-23966-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] qapi-schema: Generated doc structure fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Markus Armbruster (3):
  qapi-schema: Document how generated documentation is ordered
  qapi-schema: Introspection doc is in the wrong section, fix
  qapi-schema: Rocker doc section contains unrelated stuff, fix

 qapi-schema.json     | 21 +++++++--------------
 qapi/introspect.json |  6 ++++--
 2 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.7.5
