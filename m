Received: from eggs.gnu.org ([209.51.188.92]:44472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghxKZ-0007AV-UR
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghxKX-0000J7-Q6
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:58:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghxKX-0000Hw-Jg
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:58:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 881C34482E
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 13:58:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 11 Jan 2019 14:58:33 +0100
Message-Id: <20190111135835.3453-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Vga 20190111 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit a311f891abf3833c1e4c5a62a6e5b0f1b81f22=
c3:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-p=
ull-request' into staging (2019-01-10 17:49:54 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20190111-pull-request

for you to fetch changes up to b05b267840515730dbf6753495d5b7bd8b04ad1c:

  i2c-ddc: fix oob read (2019-01-11 11:45:00 +0100)

----------------------------------------------------------------
vga: enable virtio test, fix ddc oob read

----------------------------------------------------------------

Gerd Hoffmann (1):
  i2c-ddc: fix oob read

Thomas Huth (1):
  tests/display-vga: Enable virtio-vga test

 hw/i2c/i2c-ddc.c         |  2 +-
 tests/display-vga-test.c | 10 +++++-----
 tests/Makefile.include   |  5 +++++
 3 files changed, 11 insertions(+), 6 deletions(-)

--=20
2.9.3
