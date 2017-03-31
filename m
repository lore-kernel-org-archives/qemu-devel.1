Received: from eggs.gnu.org ([2001:4830:134:3::10]:49942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cttew-0006VK-C4
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1ctter-0004cI-Dy
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:19:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1ctter-0004cD-8N
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:19:53 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Fri, 31 Mar 2017 12:19:46 +0200
Message-Id: <20170331101947.2046-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v3] qemu-ga: add guest-get-osrelease command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

This is a concept change over v2 of the guest-get-osinfo command.
The command now adds all information in the os-release format.

Vinzenz Feenstra (1):
  qemu-ga: add guest-get-osrelease command

 qga/commands-posix.c |  41 +++++++++++++++++
 qga/commands-win32.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  29 ++++++++++++
 3 files changed, 197 insertions(+)

-- 
2.9.3
