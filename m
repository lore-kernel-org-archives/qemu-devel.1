Received: from eggs.gnu.org ([209.51.188.92]:50357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYq-0002Kw-J7
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYl-0002oY-Uq
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:08 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 14 Feb 2019 11:47:09 +0100
Message-Id: <20190214104717.3543-7-laurent@vivier.eu>
In-Reply-To: <20190214104717.3543-1-laurent@vivier.eu>
References: <20190214104717.3543-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/14] configure: Add HAX support in NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, libvir-list@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Kamil Rytarowski <n54@gmx.com>

From: Kamil Rytarowski <n54@gmx.com>

The NetBSD support in Intel HAXM has beem merged upstream and is functional.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Message-Id: <20190207233704.29978-1-n54@gmx.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index c8fc1647fe69..649ef1b158d1 100755
--- a/configure
+++ b/configure
@@ -817,6 +817,7 @@ DragonFly)
 ;;
 NetBSD)
   bsd="yes"
+  hax="yes"
   make="${MAKE-gmake}"
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl"
-- 
2.20.1
