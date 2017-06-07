Received: from eggs.gnu.org ([2001:4830:134:3::10]:34401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIe1n-0002a6-Tn
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIe1n-00016L-0t
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIe1m-00016C-Qt
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD9DA61D16
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 16:41:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 20:36:31 +0400
Message-Id: <20170607163635.17635-40-marcandre.lureau@redhat.com>
In-Reply-To: <20170607163635.17635-1-marcandre.lureau@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 39/43] i386/cpu: use get_uint() for
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

These are properties of TYPE_X86_CPU, defined with DEFINE_PROP_UINT32()

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a91c0b6a64..52bda7b3f6 100644
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
2.13.0.91.g00982b8dd
