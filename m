Received: from eggs.gnu.org ([2001:4830:134:3::10]:40479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fIH83-0001w5-CF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fIH80-0006GY-7H
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:19:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fIH80-0006GC-35
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:19:16 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 14 May 2018 18:19:10 +0100
Message-Id: <20180514171913.17664-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] i386: fix handling of multiboot modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This short series fixes a flaw identified by coverity which broke the
handling of multiboot modules.

Daniel P. Berrang=C3=A9 (3):
  i386: fix regression parsing multiboot initrd modules
  i386: only parse the initrd_filename once for multiboot modules
  opts: remove redundant check for NULL parameter

 hw/i386/multiboot.c | 35 ++++++++++++++++-------------------
 util/qemu-option.c  |  8 +++-----
 2 files changed, 19 insertions(+), 24 deletions(-)

--=20
2.17.0
