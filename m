Received: from eggs.gnu.org ([2001:4830:134:3::10]:58699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePtPz-0007xG-Hm
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePtPw-0007tg-CR
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:05:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ePtPw-0007r3-5z
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:05:00 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 15 Dec 2017 17:04:52 +0000
Message-Id: <20171215170453.8922-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 0/1] Merge qio 2017/12/15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The following changes since commit 5705b536b597de00d82807bf14bb38f542aa4491:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20171213' into staging (2017-12-14 14:22:18 +0000)

are available in the Git repository at:

  git://github.com/berrange/qemu tags/pull-qio-201712151

for you to fetch changes up to 530473924d57fd26ba9779c8702574db4df829d3:

  io: introduce a network socket listener API (2017-12-15 15:07:26 +0000)

----------------------------------------------------------------
Merge qio 2017/12/15 v1

----------------------------------------------------------------
Daniel P. Berrange (1):
  io: introduce a network socket listener API

 include/io/net-listener.h | 174 ++++++++++++++++++++++++++
 io/Makefile.objs          |   1 +
 io/net-listener.c         | 307 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 482 insertions(+)
 create mode 100644 include/io/net-listener.h
 create mode 100644 io/net-listener.c

-- 
2.14.3
