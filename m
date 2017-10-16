Received: from eggs.gnu.org ([2001:4830:134:3::10]:44385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4Boz-0004bZ-2h
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4Bou-0000B1-Hk
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4Bou-0000Aa-BY
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:04 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 16 Oct 2017 21:16:39 +0100
Message-Id: <20171016201650.18399-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 00/11] Merge QIO 2017-10-16
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

The following changes since commit 79b2a13aa81724228166c794f48eb75bfb696b88:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-10-14' into staging (2017-10-16 15:54:42 +0100)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qio-2017-10-16-1

for you to fetch changes up to 7fc3fcefe2fc5966c6aa1ef4f10e9740d8d73bf2:

  io: fix mem leak in websock error path (2017-10-16 16:57:08 +0100)

----------------------------------------------------------------
Merge QIO 2017/10/16 v1

----------------------------------------------------------------

Daniel P. Berrange (8):
  io: monitor encoutput buffer size from websocket GSource
  io: simplify websocket ping reply handling
  io: get rid of qio_channel_websock_encode helper method
  io: pass a struct iovec into qio_channel_websock_encode
  io: get rid of bounce buffering in websock write path
  io: cope with websock 'Connection' header having multiple values
  io: add trace points for websocket HTTP protocol headers
  io: fix mem leak in websock error path

Knut Omang (3):
  sockets: factor out a new try_bind() function
  sockets: factor out create_fast_reuse_socket
  sockets: Handle race condition between binds to the same port

 include/io/channel-websock.h |   3 +-
 io/channel-websock.c         | 168 ++++++++++++++++++++++++-------------------
 io/trace-events              |   2 +
 util/qemu-sockets.c          | 138 ++++++++++++++++++++++-------------
 4 files changed, 187 insertions(+), 124 deletions(-)

-- 
2.13.5
