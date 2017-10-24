Received: from eggs.gnu.org ([2001:4830:134:3::10]:42425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6yCn-0006QS-UC
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6yCm-0007B8-VF
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:21:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 24 Oct 2017 09:20:45 -0300
Message-Id: <20171024122045.30072-5-f4bug@amsat.org>
In-Reply-To: <20171024122045.30072-1-f4bug@amsat.org>
References: <20171024122045.30072-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/4] vl: remove unnecessary #ifdef CONFIG_TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

a stub is now provided.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
---
 vl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/vl.c b/vl.c
index 0723835bbf..ec299099ff 100644
--- a/vl.c
+++ b/vl.c
@@ -4624,11 +4624,9 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
-#ifdef CONFIG_TPM
     if (tpm_init() < 0) {
         exit(1);
     }
-#endif
 
     /* init the bluetooth world */
     if (foreach_device_config(DEV_BT, bt_parse))
-- 
2.15.0.rc1
