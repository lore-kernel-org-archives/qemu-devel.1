Received: from eggs.gnu.org ([2001:4830:134:3::10]:48681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eg4cr-0002bw-Kf
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eg4co-0003Nz-EX
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:17:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eg4co-0003LM-7P
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:17:10 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jan 2018 16:16:59 +0800
Message-Id: <1517213825-24085-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

The following changes since commit e607bbee553cfe73072870cef458cfa4e78133=
e2:

  Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018=
-01-26.for-upstream' into staging (2018-01-26 14:24:25 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to bf4835a4d5338bb7424827715df22570a8adc67c:

  MAINTAINERS: update Dmitry Fleytman email (2018-01-29 16:05:38 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Mao Zhongyi (2):
      colo: modified the payload compare function
      colo: compare the packet based on the tcp sequence number

Philippe Mathieu-Daud=C3=A9 (1):
      MAINTAINERS: update Dmitry Fleytman email

Thomas Huth (3):
      net: Allow hubports to connect to other netdevs
      net: Allow netdevs to be used with 'hostfwd_add' and 'hostfwd_remov=
e'
      qemu-doc: Get rid of "vlan=3DX" example in the documentation

 MAINTAINERS        |   8 +-
 hmp-commands.hx    |   4 +-
 net/colo-compare.c | 411 +++++++++++++++++++++++++++++++++--------------=
------
 net/colo.c         |   9 ++
 net/colo.h         |  15 ++
 net/hub.c          |  27 +++-
 net/hub.h          |   3 +-
 net/net.c          |   2 +-
 net/slirp.c        |  33 +++--
 net/trace-events   |   2 +-
 qapi/net.json      |   4 +-
 qemu-options.hx    |  12 +-
 12 files changed, 347 insertions(+), 183 deletions(-)
