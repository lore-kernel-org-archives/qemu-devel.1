Received: from eggs.gnu.org ([2001:4830:134:3::10]:34026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fTNH7-0003Mc-S1
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fTNH4-0001Iv-Nu
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:06:33 -0400
Received: from m15-111.126.com ([220.181.15.111]:38816)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fTNH3-0001Fa-Vf
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:06:30 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Thu, 14 Jun 2018 16:06:05 +0800
Message-Id: <20180614080607.16604-1-chen_han_xiao@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5.2 0/2] qga: report the usage of fs in guests
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
by "used_bytes" and "total_bytes" in guest-get-fsinfo.

Chen Hanxiao (2):
  qga: add mountpoint usage info to GuestFilesystemInfo
  qga-win: add driver path usage to GuestFilesystemInfo

 qga/commands-posix.c | 15 +++++++++++++++
 qga/commands-win32.c | 12 ++++++++++++
 qga/qapi-schema.json |  3 +++
 3 files changed, 30 insertions(+)

-- 
2.17.1
