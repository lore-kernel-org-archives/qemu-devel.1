Received: from eggs.gnu.org ([2001:4830:134:3::10]:58202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpD8q-0004Pa-Qm
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpD8m-0008W3-6F
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:39:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpD8l-0008VR-W8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:39:40 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 13:39:30 +0100
Message-Id: <20170905123935.26645-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 0/5] Merge QEMU I/O 2017/09/05 v2
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

The following changes since commit 32f0f68bb77289b75a82925f712bb52e16eac3ba:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-09-01 17:28:54 +0100)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qio-20170905-2

for you to fetch changes up to 689ed13e73bdb5a5ca3366524475e3065fae854a:

  io: fix check for handshake completion in TLS test (2017-09-05 13:21:58 +0100)

----------------------------------------------------------------
Merge QEMU I/O 2017/09/05 v2

----------------------------------------------------------------

Changed in v2:

 - Drop socket listen refactoring which had broken test suite 

Cao jin (1):
  util: remove the obsolete non-blocking connect

Daniel P. Berrange (4):
  io: fix temp directory used by test-io-channel-tls test
  io: fix typo in docs comment for qio_channel_read
  io: add new qio_channel_{readv, writev, read, write}_all functions
  io: fix check for handshake completion in TLS test

 block/sheepdog.c            |   2 +-
 block/ssh.c                 |   2 +-
 include/io/channel.h        |  92 +++++++++++++++++++-
 include/qemu/sockets.h      |  12 +--
 io/channel-socket.c         |   2 +-
 io/channel.c                |  94 ++++++++++++++++++++
 tests/io-channel-helpers.c  | 102 ++--------------------
 tests/test-io-channel-tls.c |   6 +-
 util/qemu-sockets.c         | 205 +++++---------------------------------------
 9 files changed, 225 insertions(+), 292 deletions(-)

-- 
2.13.5
