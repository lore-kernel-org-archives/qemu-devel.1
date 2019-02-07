Received: from eggs.gnu.org ([209.51.188.92]:47239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grjV0-00033B-D8
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grjUx-0006PV-E3
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:13:49 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:47149)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1grjUu-0006Bm-6b
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:13:46 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Feb 2019 14:13:13 +0100
Message-Id: <20190207131316.2957-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 0/3] Linux user for 4.0 patches
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

The following changes since commit 47994e16b1d66411953623e7c0bf0cdcd50bd507:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190205' into staging (2019-02-05 18:25:07 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.0-pull-request

for you to fetch changes up to 0f5faca78267beb16d8a096e9729f39d552e5c14:

  linux-user: add new netlink types (2019-02-07 14:11:19 +0100)

----------------------------------------------------------------
- add new netlink type from linux v4.18 and v4.19
- fix coverity warning (CID 1390634)
- fix ioctl(SIOCGIFCONF) crash

----------------------------------------------------------------

Kan Li (1):
  Fix linux-user crashes in ioctl(SIOCGIFCONF) when ifc_buf is NULL.

Laurent Vivier (1):
  linux-user: add new netlink types

Peter Maydell (1):
  linux-user: Check sscanf return value in open_net_route()

 linux-user/fd-trans.c |  8 +++++
 linux-user/syscall.c  | 68 +++++++++++++++++++++++++------------------
 2 files changed, 48 insertions(+), 28 deletions(-)

-- 
2.20.1
