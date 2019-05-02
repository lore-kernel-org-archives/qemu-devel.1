Received: from eggs.gnu.org ([209.51.188.92]:43274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKz-0004Ck-RC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKy-0002LA-VM
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMEKy-0002L2-Q0
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:32 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  2 May 2019 18:13:06 +0200
Message-Id: <20190502161310.15624-5-thuth@redhat.com>
In-Reply-To: <20190502161310.15624-1-thuth@redhat.com>
References: <20190502161310.15624-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/8] accel: Remove unused AccelClass::available
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Helge Deller <deller@gmx.de>, Eduardo Otubo <otubo@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

The field is not used anymore, we can remove it.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190422210448.2488-4-ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> [on mingw64]
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 accel/accel.c          | 5 -----
 include/sysemu/accel.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 454fef9d92..5fa31717b4 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -107,11 +107,6 @@ void configure_accelerator(MachineState *ms, const c=
har *progname)
         if (!acc) {
             continue;
         }
-        if (acc->available && !acc->available()) {
-            printf("%s not supported for this target\n",
-                   acc->name);
-            continue;
-        }
         ret =3D accel_init_machine(acc, ms);
         if (ret < 0) {
             init_failed =3D true;
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 5565e00a96..70e9e2f2a1 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -38,7 +38,6 @@ typedef struct AccelClass {
=20
     const char *opt_name;
     const char *name;
-    int (*available)(void);
     int (*init_machine)(MachineState *ms);
     void (*setup_post)(MachineState *ms, AccelState *accel);
     bool *allowed;
--=20
2.21.0
