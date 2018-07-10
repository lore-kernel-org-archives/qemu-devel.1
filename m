Received: from eggs.gnu.org ([2001:4830:134:3::10]:38339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fcw0O-0001Sv-Ts
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fcw0O-0006GB-3b
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:00:49 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 10 Jul 2018 13:00:39 -0400
Message-Id: <20180710170041.875-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/2] file-posix: specify expected filetypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Tighten which types of files we'll allow you to specify for the various
file drivers (file, host_device, host_cdrom).

v6:
 - Rebased for 3.0
 - Actually set ret (Kevin)
 - Added test (Thanks, Kevin!)
 - Modified error messages somewhat to include driver name

John Snow (2):
  file-posix: specify expected filetypes
  iotests: add test 226 for file driver types

 block/file-posix.c         | 39 +++++++++++++++++++++------
 qemu-doc.texi              |  6 +++++
 tests/qemu-iotests/226     | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/226.out | 26 ++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 5 files changed, 130 insertions(+), 8 deletions(-)
 create mode 100755 tests/qemu-iotests/226
 create mode 100644 tests/qemu-iotests/226.out

-- 
2.14.4
