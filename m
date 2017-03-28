Received: from eggs.gnu.org ([2001:4830:134:3::10]:36428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csuOf-0001mu-FZ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csuOc-0000vr-Ev
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:55:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csuOc-0000vD-9K
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:55:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 518F4C054917
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 16:55:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F3F7996DE4
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 16:54:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Mar 2017 18:54:57 +0200
Message-Id: <1490720098-4745-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9] Miscellaneous patches for 2017-03-28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 4d2bee82f4276b6f694fa2b0b179b4b3673984f6:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-block-2017-03-28' into staging (2017-03-28 14:48:07 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2017-03-28

for you to fetch changes up to 44fdc764550e048a2810955da7cabbfaf636231a:

  sockets: Fix socket_address_to_string() hostname truncation (2017-03-28 18:50:38 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2017-03-28

----------------------------------------------------------------
Markus Armbruster (1):
      sockets: Fix socket_address_to_string() hostname truncation

 util/qemu-sockets.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Markus Armbruster (1):
  sockets: Fix socket_address_to_string() hostname truncation

 util/qemu-sockets.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

-- 
2.7.4
