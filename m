Received: from eggs.gnu.org ([2001:4830:134:3::10]:44747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eEKRb-0000N0-VL
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eEKRa-0002X5-V8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:30:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eEKRa-0002Wo-PO
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:30:54 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 13 Nov 2017 20:29:57 +0100
Message-Id: <20171113192958.22953-5-marcandre.lureau@redhat.com>
In-Reply-To: <20171113192958.22953-1-marcandre.lureau@redhat.com>
References: <20171113192958.22953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 4/5] crash: export paddr_vmcoreinfo_note()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: somlo@cmu.edu, qemu-devel@nongnu.org, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, Vivek Goyal <vgoyal@redhat.com>

The following patch is going to use the symbol from the fw_cfg module,
to call the function and write the note location details in the
vmcoreinfo entry, so qemu can produce dumps with the vmcoreinfo note.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Baoquan He <bhe@redhat.com>
CC: Dave Young <dyoung@redhat.com>
CC: Dave Young <dyoung@redhat.com>
CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
CC: Tony Luck <tony.luck@intel.com>
CC: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Gabriel Somlo <somlo@cmu.edu>
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 6db80fc0810b..47541c891810 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -375,6 +375,7 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
 {
 	return __pa(vmcoreinfo_note);
 }
+EXPORT_SYMBOL(paddr_vmcoreinfo_note);
=20
 static int __init crash_save_vmcoreinfo_init(void)
 {
--=20
2.15.0.125.g8f49766d64
