Received: from eggs.gnu.org ([2001:4830:134:3::10]:46014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cv8H9-0005v3-BJ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cv8H6-0000Pq-6h
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:08:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cv8H6-0000PW-0w
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:08:28 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Mon,  3 Apr 2017 22:08:22 +0200
Message-Id: <20170403200823.7394-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/1] qga: Add 'guest-get-users' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

Changes since v1:
- fixed spelling issues in the commit message and schema
- added login-time field which specifies the time the users logged on
- applied changes suggested for glib hash table usage
- added new link time library dependency for wtsapi32
- setting now _WIN32_WINNT to 0x0600 if not defined globally, which is Windows
  Vista and/or Windows 2008 Server and higher

Vinzenz Feenstra (1):
  qga: Add 'guest-get-users' command

 configure             |  2 +-
 include/glib-compat.h |  5 +++
 qga/commands-posix.c  | 54 +++++++++++++++++++++++++++++++
 qga/commands-win32.c  | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json  | 22 +++++++++++++
 5 files changed, 171 insertions(+), 1 deletion(-)

-- 
2.9.3
