Received: from eggs.gnu.org ([2001:4830:134:3::10]:43118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZcNM-0000YO-EZ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZcNH-0002Jw-HN
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:22:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dZcNH-0002Ia-BF
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:22:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59A7437EEF
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 12:22:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-94.ams2.redhat.com
	[10.36.116.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2455A6C50D
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 12:22:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Jul 2017 14:22:07 +0200
Message-Id: <1500898928-4901-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Error reporting patches for 2017-07-24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit df95f1a298a3e16c80293343143dcedbe7978f6c:

  Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170721-tag' into staging (2017-07-24 10:01:15 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2017-07-24

for you to fetch changes up to 70f17a15ca0fe47eeae1ac83086130e6e7ba57c8:

  error: Revert unwanted change of warning messages (2017-07-24 14:16:29 +0200)

----------------------------------------------------------------
Error reporting patches for 2017-07-24

----------------------------------------------------------------
Markus Armbruster (1):
      error: Revert unwanted change of warning messages

 util/qemu-error.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.7.5
