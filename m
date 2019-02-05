Received: from eggs.gnu.org ([209.51.188.92]:42670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqrEN-0007Zr-BE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqr6B-0002aA-Uf
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:08:42 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  5 Feb 2019 04:08:19 +0100
Message-Id: <1549336101-17623-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Clean up the SDL audio code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=20Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>

Now that support for SDL 1.2 has been removed, we can clean up
the sdlaudio code a little bit, too.

Thomas Huth (2):
  audio/sdlaudio: Remove the semaphore code
  audio/sdlaudio: Simplify the sdl_callback function

 audio/sdlaudio.c | 188 +++++++------------------------------------------------
 1 file changed, 23 insertions(+), 165 deletions(-)

-- 
1.8.3.1
