Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE48FC06513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A067E21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A067E21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hik1Y-0000gT-Tx
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 14:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56585)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hijg2-0004bv-Cr
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hijg1-0000Yo-CI
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hijg1-0000XZ-7A
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3779308339E;
 Wed,  3 Jul 2019 18:08:14 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73D0F87C9;
 Wed,  3 Jul 2019 18:08:14 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Wed,  3 Jul 2019 15:07:02 -0300
Message-Id: <20190703180726.31267-20-ehabkost@redhat.com>
In-Reply-To: <20190703180726.31267-1-ehabkost@redhat.com>
References: <20190703180726.31267-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 03 Jul 2019 18:08:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v4 19/43] hppa: Delete unused hppa_cpu_list()
 function
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hppa_cpu_list() is dead code and is never called.  Delete it.

Cc: Richard Henderson <rth@twiddle.net>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190517191332.23400-1-ehabkost@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/hppa/cpu.h |  2 --
 target/hppa/cpu.c | 17 -----------------
 2 files changed, 19 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 2e1f2ac67c..aab251bc4b 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -241,8 +241,6 @@ void hppa_translate_init(void);
=20
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
=20
-void hppa_cpu_list(void);
-
 static inline target_ulong hppa_form_gva_psw(target_ureg psw, uint64_t s=
pc,
                                              target_ureg off)
 {
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 368cb71e6d..71b6aca45d 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -111,23 +111,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Err=
or **errp)
 #endif
 }
=20
-static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    ObjectClass *oc =3D data;
-
-    qemu_printf("  %s\n", object_class_get_name(oc));
-}
-
-void hppa_cpu_list(void)
-{
-    GSList *list;
-
-    list =3D object_class_get_list_sorted(TYPE_HPPA_CPU, false);
-    qemu_printf("Available CPUs:\n");
-    g_slist_foreach(list, hppa_cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-
 static void hppa_cpu_initfn(Object *obj)
 {
     CPUState *cs =3D CPU(obj);
--=20
2.18.0.rc1.1.g3f1ff2140


