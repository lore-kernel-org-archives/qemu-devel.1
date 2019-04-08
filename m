Received: from eggs.gnu.org ([209.51.188.92]:44270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDa5B-00024s-3i
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDa5A-00076O-94
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:29 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39001)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hDa59-00075h-To
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:28 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  8 Apr 2019 21:37:09 +0200
Message-Id: <20190408193711.32680-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/2] Linux user for 4.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

The following changes since commit f55a585d1037e5de6088f25e75443c2776786e29:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-04-07 14:54:55 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.0-pull-request

for you to fetch changes up to 71ba74f67eaca21b0cc9d96f534ad3b9a7161400:

  linux-user: rename gettid() to sys_gettid() to avoid clash with glibc (2019-04-08 17:27:13 +0200)

----------------------------------------------------------------
fix gettid() clash with new glibc

----------------------------------------------------------------

Daniel P. Berrangé (2):
  linux-user: assume __NR_gettid always exists
  linux-user: rename gettid() to sys_gettid() to avoid clash with glibc

 linux-user/syscall.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

-- 
2.20.1
