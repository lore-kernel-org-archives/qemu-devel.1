Received: from eggs.gnu.org ([2001:4830:134:3::10]:45523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dOpVk-0007zC-UR
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 14:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dOpVg-0006Fm-61
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 14:10:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dOpVf-0006EZ-Vz
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 14:10:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 008B2C049D5D
	for <qemu-devel@nongnu.org>; Sat, 24 Jun 2017 18:10:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Sat, 24 Jun 2017 12:10:06 -0600
Message-Id: <20170624181008.25497-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] qobject coccinelle followups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com

v1 was here:
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02589.html

Since then:
- reorder the series
- add R-b on patch 1
- patch 2 updated to catch recent introduction of longhand usage

Eric Blake (2):
  qobject: Catch another straggler for use of qdict_put_str()
  qobject: Update coccinelle script to catch Q{INC,DEC}REF

 monitor.c                        | 2 +-
 qemu-img.c                       | 2 +-
 scripts/coccinelle/qobject.cocci | 6 ++++++
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.9.4
