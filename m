Received: from eggs.gnu.org ([2001:4830:134:3::10]:42438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6yCp-0006QU-NM
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6yCi-00077n-VL
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:21:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 24 Oct 2017 09:20:44 -0300
Message-Id: <20171024122045.30072-4-f4bug@amsat.org>
In-Reply-To: <20171024122045.30072-1-f4bug@amsat.org>
References: <20171024122045.30072-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/4] tpm: remove unnecessary #ifdef
 CONFIG_TPM
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

Makefile.objs now checks for $(CONFIG_TPM).

Suggested-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tpm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tpm.c b/tpm.c
index 45520f555d..ab5d29e91e 100644
--- a/tpm.c
+++ b/tpm.c
@@ -30,8 +30,6 @@ void tpm_register_model(enum TpmModel model)
     tpm_models[model] = true;
 }
 
-#ifdef CONFIG_TPM
-
 static const TPMBackendClass *
 tpm_be_find_by_type(enum TpmType type)
 {
@@ -192,8 +190,6 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
     return 0;
 }
 
-#endif /* CONFIG_TPM */
-
 /*
  * Walk the list of active TPM backends and collect information about them
  * following the schema description in qapi-schema.json.
-- 
2.15.0.rc1
