Received: from eggs.gnu.org ([2001:4830:134:3::10]:41080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA48-00015b-8a
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA43-0002fC-Lc
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpA43-0002ev-Fx
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:35 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 10:22:21 +0100
Message-Id: <20170905092230.8243-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 0/9] Merge QEMU I/O 2017/09/05
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

  git://github.com/berrange/qemu tags/pull-qio-20170905-1

for you to fetch changes up to 33fb97121573985b4a57306b8abdb9dd992061fa:

  io: fix check for handshake completion in TLS test (2017-09-05 10:20:28 +0100)

----------------------------------------------------------------
Merge QEMU I/O 2017/09/05 v1

----------------------------------------------------------------

Cao jin (1):
  util: remove the obsolete non-blocking connect

Daniel P. Berrange (4):
  io: fix temp directory used by test-io-channel-tls test
  io: fix typo in docs comment for qio_channel_read
  io: add new qio_channel_{readv, writev, read, write}_all functions
  io: fix check for handshake completion in TLS test

Knut Omang (4):
  tests: Add test-listen - a stress test for QEMU socket listen
  sockets: factor out a new try_bind() function
  sockets: factor out create_fast_reuse_socket
  sockets: Handle race condition between binds to the same port

 block/sheepdog.c            |   2 +-
 block/ssh.c                 |   2 +-
 include/io/channel.h        |  92 +++++++++++-
 include/qemu/sockets.h      |  12 +-
 io/channel-socket.c         |   2 +-
 io/channel.c                |  94 ++++++++++++
 tests/Makefile.include      |   2 +
 tests/io-channel-helpers.c  | 102 ++-----------
 tests/test-io-channel-tls.c |   6 +-
 tests/test-listen.c         | 253 ++++++++++++++++++++++++++++++++
 util/qemu-sockets.c         | 343 +++++++++++++++-----------------------------
 11 files changed, 570 insertions(+), 340 deletions(-)
 create mode 100644 tests/test-listen.c

-- 
2.13.5
