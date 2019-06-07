Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128B0C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68CA20868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68CA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZIlQ-0007Fd-VP
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZH00-0003i0-43
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZGwT-0000xp-C6
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZGwS-0000qQ-Vg
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:38:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6FB83308427E;
 Fri,  7 Jun 2019 15:37:56 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF3E7383F;
 Fri,  7 Jun 2019 15:37:53 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Jun 2019 17:37:01 +0200
Message-Id: <20190607153725.18055-6-philmd@redhat.com>
In-Reply-To: <20190607153725.18055-1-philmd@redhat.com>
References: <20190607153725.18055-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 07 Jun 2019 15:38:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v18 05/29] !fixup target/rx: CPU definition
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New qom-cpu style requested by Igor.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/rx/cpu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 3c43467534..c370f65faa 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -80,7 +80,7 @@ static void rx_cpu_list_entry(gpointer data, gpointer u=
ser_data)
 void rx_cpu_list(void)
 {
     GSList *list;
-    list =3D object_class_get_list_sorted(TYPE_RXCPU, false);
+    list =3D object_class_get_list_sorted(TYPE_RX_CPU, false);
     g_slist_foreach(list, rx_cpu_list_entry, NULL);
     g_slist_free(list);
 }
@@ -88,15 +88,26 @@ void rx_cpu_list(void)
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
-    char *typename =3D NULL;
+    char *typename;
=20
-    typename =3D g_strdup_printf(RX_CPU_TYPE_NAME(""));
+    oc =3D object_class_by_name(cpu_model);
+    if (oc !=3D NULL && object_class_dynamic_cast(oc, TYPE_RX_CPU) !=3D =
NULL &&
+        !object_class_is_abstract(oc)) {
+        return oc;
+    }
+
+    typename =3D g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
     oc =3D object_class_by_name(typename);
     if (oc !=3D NULL && object_class_is_abstract(oc)) {
         oc =3D NULL;
     }
-
     g_free(typename);
+
+    if (!oc) {
+        /* default to rx62n */
+        oc =3D object_class_by_name(RX_CPU_TYPE_NAME("rx62n"));
+    }
+
     return oc;
 }
=20
--=20
2.20.1


