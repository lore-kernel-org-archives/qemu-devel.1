Received: from eggs.gnu.org ([2001:4830:134:3::10]:43623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cr3JM-0005pb-LI
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cr3JJ-0001ZM-K7
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cr3JJ-0001Yr-EH
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:01:53 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Thu, 23 Mar 2017 01:06:44 +0100
Message-Id: <20170323000645.10756-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v3] qga: Add `guest-get-timezone` command
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

Changes since v2:

- Changed offset from reporting minutes to reporting seconds like it is
  returned from the used glib API
- Applied more checks and better error handling in the implementation

Vinzenz Feenstra (1):
  qga: Add `guest-get-timezone` command

 qga/commands.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.9.3
