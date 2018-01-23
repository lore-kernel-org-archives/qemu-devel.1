Received: from eggs.gnu.org ([2001:4830:134:3::10]:52153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ee1dY-0004Ms-JG
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ee1dU-0006G9-Hu
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ee1dU-0006FT-Bi
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:24 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jan 2018 17:40:40 +0100
Message-Id: <20180123164041.30339-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180123164041.30339-1-marcandre.lureau@redhat.com>
References: <20180123164041.30339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 3/4] crash: export paddr_vmcoreinfo_note()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, slp@redhat.com, mst@redhat.com, somlo@cmu.edu, xiaolong.ye@intel.com, peterx@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, Vivek Goyal <vgoyal@redhat.com>

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
index 4f63597c824d..a93590cdd9e1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -376,6 +376,7 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
 {
 	return __pa(vmcoreinfo_note);
 }
+EXPORT_SYMBOL(paddr_vmcoreinfo_note);
=20
 static int __init crash_save_vmcoreinfo_init(void)
 {
--=20
2.16.0.rc1.1.gef27df75a1
