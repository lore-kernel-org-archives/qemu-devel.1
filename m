Received: from eggs.gnu.org ([2001:4830:134:3::10]:50323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1crPyY-0006Um-QH
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1crPyU-0000NC-PA
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1crPyU-0000MT-Jc
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:13:54 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Thu, 23 Mar 2017 12:39:12 +0100
Message-Id: <20170323113913.26974-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v5] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mdroth@linux.vnet.ibm.com, sameeh@daynix.com, marcandre.lureau@gmail.com, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

Changes since v4:
- Corrected usage of the optional zone (Missing has_zone = true)
- Updated documentation string for offset in the schema
- Removed unnecessary checks
- Uses the current time to check for the interval, not 0
- Switched to UNIVERSAL time type, since that can't fail and is all that's
  needed

Vinzenz Feenstra (1):
  qga: Add `guest-get-timezone` command

 qga/commands.c       | 29 +++++++++++++++++++++++++++++
 qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

-- 
2.9.3
