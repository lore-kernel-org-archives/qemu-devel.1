Received: from eggs.gnu.org ([2001:4830:134:3::10]:47141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1d0nER-0002WY-93
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1d0nEM-00026f-AT
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:53:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1d0nEM-000265-4P
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:53:02 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Wed, 19 Apr 2017 12:52:57 +0200
Message-Id: <20170419105258.4488-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/1] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, sameeh@daynix.com, mdroth@linux.vnet.ibm.com, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

Changes since v5:
- Dropped unnecessary g_time_zone_unref in error handling
- Made implementation check for glib 2.28 or higher
- Move variable declaration to function top

Vinzenz Feenstra (1):
  qga: Add `guest-get-timezone` command

 qga/commands.c       | 38 ++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

-- 
2.9.3
