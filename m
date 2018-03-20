Received: from eggs.gnu.org ([2001:4830:134:3::10]:44842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyO7K-0003QZ-TF
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyO7H-0004bC-Pm
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:44:22 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eyO7H-0004Zn-Fa
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:44:19 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Mar 2018 21:43:50 +0100
Message-Id: <20180320204351.28167-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/1] Linux user for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

The following changes since commit 036793aebfc1dd0ce124fa278d7668d89b5da936:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-03-20 12:56:20 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request

for you to fetch changes up to 2a53535af471f4bee9d6cb5b363746b8d5ed21dd:

  linux-user: init_guest_space: Try to make ARM space+commpage continuous (2018-03-20 18:26:40 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Luke Shumaker (1):
  linux-user: init_guest_space: Try to make ARM space+commpage
    continuous

 linux-user/elfload.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

-- 
2.14.3
