Received: from eggs.gnu.org ([2001:4830:134:3::10]:54568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dafN8-000390-IP
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dafN5-0001D1-Cz
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dafN5-0001Co-7L
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26D546B246
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 09:46:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-94.ams2.redhat.com
	[10.36.116.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E6EC318013
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 09:46:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 27 Jul 2017 11:46:13 +0200
Message-Id: <1501148776-16890-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] Proactive pow2floor() fix,
 and dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviving a series from 2015 I dropped on the floor.  My apologies.

v2:
* PATCH 1 (was PATCH 2): rebased, R-bys kept
* PATCH 2 (was PATCH 1): rebased, commit message updated, legibility
  improved, R-bys dropped
* PATCH 3: new

Markus Armbruster (3):
  xbzrle: Drop unused cache_resize()
  host-utils: Proactively fix pow2floor(), switch to unsigned
  host-utils: Simplify pow2ceil()

 include/qemu/host-utils.h | 44 ++++++++++++++++++++++---------------
 migration/page_cache.c    | 56 -----------------------------------------=
------
 migration/page_cache.h    | 11 ----------
 3 files changed, 26 insertions(+), 85 deletions(-)

--=20
2.7.5
