Received: from eggs.gnu.org ([2001:4830:134:3::10]:55417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4jkh-0006j5-Ae
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4jke-0001TM-6k
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:30:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e4jke-0001SV-0y
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:30:56 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Oct 2017 10:30:50 +0200
Message-Id: <1508315450-187209-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-23-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-23-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/40] fixup: sh4: simplify
 superh_cpu_class_by_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, aurelien@aurel32.net

with "sh4: simplify superh_cpu_class_by_name()"
no longer accepts type names as cpu_model but linux-useri/main.c
still uses type name as default, fix it up and use
cpu_model instead

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: aurelien@aurel32.net
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 829f974..d3fde19 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4312,7 +4312,7 @@ int main(int argc, char **argv, char **envp)
         cpu_model =3D "750";
 # endif
 #elif defined TARGET_SH4
-        cpu_model =3D TYPE_SH7785_CPU;
+        cpu_model =3D "sh7785";
 #elif defined TARGET_S390X
         cpu_model =3D "qemu";
 #else
--=20
2.7.4
