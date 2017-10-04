Received: from eggs.gnu.org ([2001:4830:134:3::10]:55096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzijr-0002hs-Da
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzijo-0005Bz-9e
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dzijo-00059Z-4D
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:20 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  4 Oct 2017 13:25:04 +0100
Message-Id: <20171004122515.20627-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 00/11] Merge qio 2017/10/04
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

The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10=
ea:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-10-03 16:27:24 +0100)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qio-2017-10-04-1

for you to fetch changes up to 59f183bbd54eecffb8915bffe03f9c2720b28bcc:

  io: add trace events for websockets frame handling (2017-10-04 13:21:53=
 +0100)

----------------------------------------------------------------
Merge qio 2017/10/04 v1

----------------------------------------------------------------

Brandon Carpenter (7):
  ui: Always remove an old VNC channel watch before adding a new one
  io: Small updates in preparation for websocket changes
  io: Add support for fragmented websocket binary frames
  io: Allow empty websocket payload
  io: Ignore websocket PING and PONG frames
  io: Reply to ping frames
  io: Attempt to send websocket close messages to client

Daniel P. Berrange (4):
  io: send proper HTTP response for websocket errors
  io: include full error message in websocket handshake trace
  io: use case insensitive check for Connection & Upgrade websock
    headers
  io: add trace events for websockets frame handling

 include/io/channel-websock.h |   2 +
 io/channel-websock.c         | 496 +++++++++++++++++++++++++++++--------=
------
 io/trace-events              |   7 +-
 ui/vnc-auth-vencrypt.c       |   3 +
 ui/vnc-ws.c                  |   6 +
 ui/vnc.c                     |   4 +
 6 files changed, 362 insertions(+), 156 deletions(-)

--=20
2.13.5
