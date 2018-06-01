Received: from eggs.gnu.org ([2001:4830:134:3::10]:54541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOlz0-0006L3-UJ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOlyw-0006Qp-0H
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:28:50 -0400
Received: from m15-112.126.com ([220.181.15.112]:45197)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOlyv-0006Np-0P
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:28:45 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Fri,  1 Jun 2018 23:27:44 +0800
Message-Id: <20180601152746.17169-1-chen_han_xiao@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 0/2] qga: report the usage of fs in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chen Hanxiao <chen_han_xiao@126.com>

This series report the usage of guest's fs
by "used_bytes" and "total_bytes" by guest-get-fsinfo.

Chen Hanxiao (2):
  qga: add mountpoint usage to GuestFilesystemInfo
  qga-win: add  driver path usage to GuestFilesystemInfo

 qga/commands-posix.c | 19 +++++++++++++++++++
 qga/commands-win32.c | 13 +++++++++++++
 qga/qapi-schema.json | 14 +++++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.17.0
