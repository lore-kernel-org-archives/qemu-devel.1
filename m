Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9E4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E8521556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnbnNtzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E8521556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifWyk-0007Vn-6O
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ifWpN-0005ki-RY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ifWpM-0007TK-I8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27631
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ifWpM-0007SF-Du
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576189255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvWKU1JHvgMKRwZ25koHdnVdORnUAycfGBL1yp3ddVU=;
 b=WnbnNtzUpXi+r0tbwGieH3MIPLfkRCZEyqE/OI6lZLGm42qBdUcE56Rccx3LkRkw8prw6o
 cA4iT5oWmCukgC6Z1ecj4DEHl0My14mJ5VQ/ysPDKYiVPbBGr4z+/iWmv4ykIyvQHkJ4H7
 sVZ3Z8owhNm7bxrtktXRzmcQUhptET8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-RiV5OOBhMneX9YPiZq4fIQ-1; Thu, 12 Dec 2019 17:20:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E98B107ACC9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 22:20:53 +0000 (UTC)
Received: from secure.mitica (ovpn-116-25.ams2.redhat.com [10.36.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0056910013A1;
 Thu, 12 Dec 2019 22:20:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/10] migration-test: Rename cmd_src/dst to
 arch_source/arch_target
Date: Thu, 12 Dec 2019 23:20:32 +0100
Message-Id: <20191212222033.1026-10-quintela@redhat.com>
In-Reply-To: <20191212222033.1026-1-quintela@redhat.com>
References: <20191212222033.1026-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: RiV5OOBhMneX9YPiZq4fIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This explains better what they do and avoid confussino with
command_src/target.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 5ab8cfd4b2..6c7c4163a4 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -549,7 +549,7 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
                                bool use_shmem, const char *opts_src,
                                const char *opts_dst)
 {
-    gchar *cmd_src, *cmd_dst;
+    gchar *arch_source, *arch_target;
     gchar *cmd_source, *cmd_target;
     const gchar *ignore_stderr;
     char *bootpath =3D NULL;
@@ -579,8 +579,8 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
         machine_type =3D "";
         machine_args =3D "";
         memory_size =3D "150M";
-        cmd_src =3D g_strdup_printf("-drive file=3D%s,format=3Draw", bootp=
ath);
-        cmd_dst =3D g_strdup(cmd_src);
+        arch_source =3D g_strdup_printf("-drive file=3D%s,format=3Draw", b=
ootpath);
+        arch_target =3D g_strdup(arch_source);
         start_address =3D X86_TEST_MEM_START;
         end_address =3D X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -588,20 +588,20 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         machine_type =3D "";
         machine_args =3D "";
         memory_size =3D "128M";
-        cmd_src =3D g_strdup_printf("-bios %s", bootpath);
-        cmd_dst =3D g_strdup(cmd_src);
+        arch_source =3D g_strdup_printf("-bios %s", bootpath);
+        arch_target =3D g_strdup(arch_source);
         start_address =3D S390_TEST_MEM_START;
         end_address =3D S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") =3D=3D 0) {
         machine_type =3D "";
         machine_args =3D ",vsmt=3D8";
         memory_size =3D "256M";
-        cmd_src =3D g_strdup_printf("-nodefaults "
-                                  "-prom-env 'use-nvramrc?=3Dtrue' -prom-e=
nv "
-                                  "'nvramrc=3Dhex .\" _\" begin %x %x "
-                                  "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until'", end_address, start_address);
-        cmd_dst =3D g_strdup("");
+        arch_source =3D g_strdup_printf("-nodefaults "
+                                      "-prom-env 'use-nvramrc?=3Dtrue' -pr=
om-env "
+                                      "'nvramrc=3Dhex .\" _\" begin %x %x =
"
+                                      "do i c@ 1 + i c! 1000 +loop .\" B\"=
 0 "
+                                      "until'", end_address, start_address=
);
+        arch_target =3D g_strdup("");
         start_address =3D PPC_TEST_MEM_START;
         end_address =3D PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") =3D=3D 0) {
@@ -609,10 +609,10 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         machine_type =3D "virt,";
         machine_args =3D "gic-version=3Dmax";
         memory_size =3D "150M";
-        cmd_src =3D g_strdup_printf("-cpu max "
-                                  "-kernel %s",
-                                  bootpath);
-        cmd_dst =3D g_strdup(cmd_src);
+        arch_source =3D g_strdup_printf("-cpu max "
+                                      "-kernel %s",
+                                      bootpath);
+        arch_target =3D g_strdup(arch_source);
         start_address =3D ARM_TEST_MEM_START;
         end_address =3D ARM_TEST_MEM_END;
=20
@@ -647,8 +647,9 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
                                  "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size, tmpfs,
-                                 cmd_src, shmem_opts, opts_src, ignore_std=
err);
-    g_free(cmd_src);
+                                 arch_source, shmem_opts, opts_src,
+                                 ignore_stderr);
+    g_free(arch_source);
     *from =3D qtest_init(cmd_source);
     g_free(cmd_source);
=20
@@ -660,8 +661,9 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
                                  "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size, tmpfs, uri,
-                                 cmd_dst, shmem_opts, opts_dst, ignore_std=
err);
-    g_free(cmd_dst);
+                                 arch_target, shmem_opts, opts_dst,
+                                 ignore_stderr);
+    g_free(arch_target);
     *to =3D qtest_init(cmd_target);
     g_free(cmd_target);
=20
--=20
2.21.0


