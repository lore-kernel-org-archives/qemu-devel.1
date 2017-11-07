Received: from eggs.gnu.org ([2001:4830:134:3::10]:54208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC4zt-0002d7-9Q
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC4zp-0001ox-HN
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:37:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:1911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eC4zp-0001nA-Be
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:36:57 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  7 Nov 2017 14:36:51 +0000
Message-Id: <20171107143652.15375-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 0/1] Merge IO 2017/11/06
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

The following changes since commit 5853e92207193e967abf5e4c25b4a551c7604725:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-cocoa-20171107' into staging (2017-11-07 12:19:48 +0000)

are available in the git repository at:

  git://github.com/berrange/qemu pull-2017-11-06-2

for you to fetch changes up to 10a7b7e6fd9f250f0506568345d7b4d2ab52889d:

  sockets: avoid leak of listen file descriptor (2017-11-07 14:10:20 +0000)

----------------------------------------------------------------
Pull IO 2017/11/06 v2

----------------------------------------------------------------
Daniel P. Berrange (1):
  sockets: avoid leak of listen file descriptor

 util/qemu-sockets.c | 52 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

-- 
2.13.6
