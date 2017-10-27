Received: from eggs.gnu.org ([2001:4830:134:3::10]:34528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Xe-0007y2-P4
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Xd-0001nS-QQ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85Xd-0001mh-Ju
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:21 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:56 +0200
Message-Id: <20171027142107.15542-29-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 28/39] sparc: cleanup cpu type name
 composition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

introduce SPARC_CPU_TYPE_NAME macro and use it to
construct cpu type names.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-32-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/sparc/cpu.h | 3 +++
 target/sparc/cpu.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index bf2b8931cc..9fde547fac 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -658,6 +658,9 @@ int cpu_sparc_signal_handler(int host_signum, void *p=
info, void *puc);
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_SPARC_CPU, cpu_model)
 #endif
=20
+#define SPARC_CPU_TYPE_SUFFIX "-" TYPE_SPARC_CPU
+#define SPARC_CPU_TYPE_NAME(model) model SPARC_CPU_TYPE_SUFFIX
+
 #define cpu_signal_handler cpu_sparc_signal_handler
 #define cpu_list sparc_cpu_list
=20
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 47d0927707..c7adc281de 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -712,7 +712,7 @@ static bool sparc_cpu_has_work(CPUState *cs)
=20
 static char *sparc_cpu_type_name(const char *cpu_model)
 {
-    char *name =3D g_strdup_printf("%s-" TYPE_SPARC_CPU, cpu_model);
+    char *name =3D g_strdup_printf(SPARC_CPU_TYPE_NAME("%s"), cpu_model)=
;
     char *s =3D name;
=20
     /* SPARC cpu model names happen to have whitespaces,
--=20
2.13.6
