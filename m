Received: from eggs.gnu.org ([2001:4830:134:3::10]:41291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctlAc-0007mU-L9
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 21:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctlAX-00067Q-T0
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 21:16:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ctlAX-00066d-No
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 21:16:01 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 31 Mar 2017 09:15:53 +0800
Message-Id: <1490922956-19731-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit ddc2c3a57e0752c0650fdb735a8b8322542d42=
48:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-03-30 18:02:33 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to b4053c64833762f1249b2d704d2da30b5b10c8ff:

  e1000: disable debug by default (2017-03-31 08:48:13 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Jason Wang (2):
      virtio-net: avoid call tap_enable when there's only one queue
      e1000: disable debug by default

 hw/net/e1000.c      | 2 +-
 hw/net/virtio-net.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)
