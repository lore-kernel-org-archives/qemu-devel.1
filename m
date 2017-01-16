Received: from eggs.gnu.org ([2001:4830:134:3::10]:60132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cTHa0-0006kc-CP
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 19:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cTHZx-0006pY-8D
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 19:24:52 -0500
Received: from mail-db5eur01on0115.outbound.protection.outlook.com
	([104.47.2.115]:3432
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbutsykin@virtuozzo.com>)
	id 1cTHZw-0006pP-Gs
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 19:24:49 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Mon, 16 Jan 2017 18:51:11 +0300
Message-ID: <20170116155113.21034-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] migration capability to discard the
 migrated ram pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, amit.shah@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org, pbutsykin@virtuozzo.com

This feature frees the migrated memory on the source during postcopy-ram
migration. In the second step of postcopy-ram migration when the source vm
is put on pause we can free unnecessary memory. It will allow, in particular,
to start relaxing the memory stress on the source host in a load-balancing
scenario.

Pavel Butsykin (2):
  add 'discard-ram' migrate capability
  migration: discard non-dirty ram pages after the start of postcopy

 include/migration/migration.h |  2 ++
 include/migration/qemu-file.h |  3 ++-
 migration/migration.c         | 11 ++++++++
 migration/qemu-file.c         | 59 ++++++++++++++++++++++++++++++++++++++-----
 migration/ram.c               | 49 ++++++++++++++++++++++++++++++++++-
 qapi-schema.json              |  5 +++-
 6 files changed, 119 insertions(+), 10 deletions(-)

-- 
2.11.0
