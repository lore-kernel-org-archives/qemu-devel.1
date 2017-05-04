Received: from eggs.gnu.org ([2001:4830:134:3::10]:47300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d69fG-0005CK-37
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d69fC-0005Pu-7M
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d69fC-0005P5-0w
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1D904E4C6
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 05:50:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 07:50:37 +0200
Message-Id: <20170504055040.31904-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] input patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Input patch queue, with a new tracepoint and two bugfixes (one of them
cve).

please pull,
  Gerd

The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:

  Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-input-20170504-1

for you to fetch changes up to 2222e0a633070f7f3eafcc9d0e95e7f1a4e6fe36:

  input: Add trace event for empty keyboard queue (2017-05-03 14:20:12 +0=
200)

----------------------------------------------------------------
input: limit kbd queue depth
input: don't queue delay if paused
input: Add trace event for empty keyboard queue

----------------------------------------------------------------
Alexander Graf (1):
      input: Add trace event for empty keyboard queue

Gerd Hoffmann (1):
      input: limit kbd queue depth

Marc-Andr=C3=A9 Lureau (1):
      input: don't queue delay if paused

 hw/input/hid.c        |  4 ++++
 ui/input.c            | 18 +++++++++++++++---
 hw/input/trace-events |  1 +
 3 files changed, 20 insertions(+), 3 deletions(-)
