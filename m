Received: from eggs.gnu.org ([2001:4830:134:3::10]:55897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfj-0008Ma-Gp
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfd-0002P8-Id
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:11:11 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:24 +0100
Message-Id: <1516694904-64879-26-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 25/25] cpu: get rid of cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

There aren't any users of the helper left, remove it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Richard Henderson <richard.henderson@linaro.org>
CC: "Emilio G. Cota" <cota@braap.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
CC: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
---
 qom/cpu.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index aab8437..cf6880d 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -304,22 +304,9 @@ static ObjectClass *cpu_common_class_by_name(const c=
har *cpu_model)
 static void cpu_common_parse_features(const char *typename, char *featur=
es,
                                       Error **errp)
 {
-    char *featurestr; /* Single "key=3Dvalue" string being parsed */
     char *val;
-    static bool cpu_globals_initialized;
-
-    /* TODO: all callers of ->parse_features() need to be changed to
-     * call it only once, so we can remove this check (or change it
-     * to assert(!cpu_globals_initialized).
-     * Current callers of ->parse_features() are:
-     * - cpu_generic_init()
-     */
-    if (cpu_globals_initialized) {
-        return;
-    }
-    cpu_globals_initialized =3D true;
-
-    featurestr =3D features ? strtok(features, ",") : NULL;
+    /* Single "key=3Dvalue" string being parsed */
+    char *featurestr =3D features ? strtok(features, ",") : NULL;
=20
     while (featurestr) {
         val =3D strchr(featurestr, '=3D');
--=20
2.7.4
