Received: from eggs.gnu.org ([2001:4830:134:3::10]:45262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITG-0004MY-VG
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITB-0002GM-6y
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNITA-0002Eb-WC
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9CD47EBD2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:41:06 +0200
Message-Id: <1497962468-22936-40-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 39/41] i386/cpu: use get_uint() for
 "min-level"/"min-xlevel" properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

These are properties of TYPE_X86_CPU, defined with DEFINE_PROP_UINT32()

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-40-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f118a54..642519a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2324,8 +2324,8 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDef=
inition *def, Error **errp)
      */
=20
     /* CPU models only set _minimum_ values for level/xlevel: */
-    object_property_set_int(OBJECT(cpu), def->level, "min-level", errp);
-    object_property_set_int(OBJECT(cpu), def->xlevel, "min-xlevel", errp=
);
+    object_property_set_uint(OBJECT(cpu), def->level, "min-level", errp)=
;
+    object_property_set_uint(OBJECT(cpu), def->xlevel, "min-xlevel", err=
p);
=20
     object_property_set_int(OBJECT(cpu), def->family, "family", errp);
     object_property_set_int(OBJECT(cpu), def->model, "model", errp);
--=20
2.7.5
