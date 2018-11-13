Received: from eggs.gnu.org ([2001:4830:134:3::10]:59603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gMOwz-0007lH-8z
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gMOwu-0005Fn-7t
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:01:13 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:46006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gMOwt-0005ED-AV
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:01:08 -0500
Received: by mail-oi1-x22f.google.com with SMTP id b141so50426oii.12
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 19:01:05 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 12 Nov 2018 21:00:45 -0600
Message-Id: <20181113030047.11711-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-3.1 0/2] qemu-ga patch queue for 3.1.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit 160e5c22e55b3f775c2003dfc626fa872ee4a7a1:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2018-11-09 10:54:10 +0000)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2018-11-12-tag

for you to fetch changes up to 61baac2fdb7ad3891fb00bbd3c9e8b8ca87f0f62:

  qga: Add multiple include guard to guest-agent-core.h (2018-11-09 07:55:13 -0600)

----------------------------------------------------------------
qemu-ga patch queue for 3.1.0

* add missing #include guards for guest-agent-core.h
* fix leaks introduced with recent win32 enablement of disk info in
  guest-get-fsinfo

----------------------------------------------------------------
Marc-André Lureau (1):
      qga-win: fix leaks of build_guest_disk_info()

Peter Maydell (1):
      qga: Add multiple include guard to guest-agent-core.h

 qga/commands-win32.c   | 5 ++++-
 qga/guest-agent-core.h | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)
