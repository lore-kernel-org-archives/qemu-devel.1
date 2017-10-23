Received: from eggs.gnu.org ([2001:4830:134:3::10]:35773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6kMm-0008Vi-Fa
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6kMl-0000Dy-DS
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:34:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 23 Oct 2017 18:33:59 -0300
Message-Id: <20171023213359.23025-4-f4bug@amsat.org>
In-Reply-To: <20171023213359.23025-1-f4bug@amsat.org>
References: <20171023213359.23025-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/3] vl: remove unnecessary #ifdef CONFIG_TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>

a stub is now provided.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
