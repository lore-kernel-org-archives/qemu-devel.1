Received: from eggs.gnu.org ([2001:4830:134:3::10]:46345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOnOE-0002hd-UF
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOnOB-0002Io-1R
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:58:59 -0400
Received: from m15-114.126.com ([220.181.15.114]:50802)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOnOA-0002Gy-Co
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:58:54 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Sat,  2 Jun 2018 00:57:48 +0800
Message-Id: <20180601165750.25420-1-chen_han_xiao@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5.1 0/2] qga: report the usage of fs in guests
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

 qga/commands-posix.c | 18 ++++++++++++++++++
 qga/commands-win32.c | 12 ++++++++++++
 qga/qapi-schema.json |  3 +++
 3 files changed, 33 insertions(+)

-- 
2.17.0
