Received: from eggs.gnu.org ([2001:4830:134:3::10]:36309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSfZ6-0005rc-NV
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSfZ3-0000SU-JB
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dSfZ3-0000S5-Cn
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:37 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  5 Jul 2017 16:21:19 +0800
Message-Id: <1499242883-2184-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] migration: fix iotest 055,
 only-migratable break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, haoqf@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

v2:
- patch 1: add r-b for Eduardo/Juan
- patch 2: add r-b for Eduardo (Markus's suggestion is a todo), and
  t-b for Qingfeng
- patch 3: rewrite the doc up, merging both Eduardo/Markus's
  suggestion [Eduardo, Markus]
- patch 4: added a TODO [Markus]

Two breakage introduced during the migration objectify series: one for
--only-migratable, another one for iotest 055.

First two patches fixes the breakages. Latter two are documentation
updates suggested by Eduardo. Please review. Thanks.

Peter Xu (4):
  migration: fix handling for --only-migratable
  vl: move global property, migrate init earlier
  doc: add item for "-M enforce-config-section"
  doc: update TYPE_MIGRATION documents

 include/migration/misc.h |  1 -
 migration/migration.c    | 17 ++++++-----------
 qemu-options.hx          | 11 +++++++++++
 vl.c                     | 26 +++++++++++++-------------
 4 files changed, 30 insertions(+), 25 deletions(-)

--=20
2.7.4
