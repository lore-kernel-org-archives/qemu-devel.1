Received: from eggs.gnu.org ([2001:4830:134:3::10]:46297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1d0lsW-0006HZ-W2
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1d0lsR-0005cX-FT
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:26:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1d0lsR-0005c6-9B
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:26:19 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Wed, 19 Apr 2017 11:26:14 +0200
Message-Id: <20170419092615.11410-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/1] qga: Add 'guest-get-users' command
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

Changes since v4:
- Removed unnecessary ifdefs
- Win32 implementation now uses W32_FT_OFFSET instead of custom constant
- Moved variable declarations to the top of the function
- Also ensure that only the earliest login time on Windows is reported

Changes since v3:
- Removed ifdef/endif around QGA_MICRO_SECOND_TO_SECOND

Changes since v2:
- Updated the documentation of login-time to be more precise what the value
  contains and what time is actually reported and in which format.

Changes since v1:
- fixed spelling issues in the commit message and schema
- added login-time field which specifies the time the users logged on
- applied changes suggested for glib hash table usage
- added new link time library dependency for wtsapi32
- setting now _WIN32_WINNT to 0x0600 if not defined globally, which is Windows
  Vista and/or Windows 2008 Server and higher

Vinzenz Feenstra (1):
  qga: Add 'guest-get-users' command

 configure             |   2 +-
 include/glib-compat.h |   5 +++
 qga/commands-posix.c  |  60 +++++++++++++++++++++++++++++
 qga/commands-win32.c  | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json  |  24 ++++++++++++
 5 files changed, 193 insertions(+), 1 deletion(-)

-- 
2.9.3
