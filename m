Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4841C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D0B2183E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D0B2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35201 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGyFr-0001WM-AC
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 00:02:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGyEd-0000wp-Kp
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGyEc-0007lg-6M
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:01:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hGyEa-0007hh-3C
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:01:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21E23307D764;
	Thu, 18 Apr 2019 04:01:07 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A48CF1001DF1;
	Thu, 18 Apr 2019 04:01:05 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 01:01:03 -0300
Message-Id: <20190418040103.15314-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 18 Apr 2019 04:01:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] hppa: Delete unused hppa_cpu_list() function
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418040103.XH7O7lN7xFRTZwhWFN2jV_KxjhLix7yod_7IwgsGXyE@z>

hppa_cpu_list() is dead code and is never called.  Delete it.

Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/hppa/cpu.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 00bf444620..b3b1826209 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -110,28 +110,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
 }
 
-static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    ObjectClass *oc = data;
-    CPUListState *s = user_data;
-
-    (*s->cpu_fprintf)(s->file, "  %s\n", object_class_get_name(oc));
-}
-
-void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
-{
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
-    GSList *list;
-
-    list = object_class_get_list_sorted(TYPE_HPPA_CPU, false);
-    (*cpu_fprintf)(f, "Available CPUs:\n");
-    g_slist_foreach(list, hppa_cpu_list_entry, &s);
-    g_slist_free(list);
-}
-
 static void hppa_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
-- 
2.18.0.rc1.1.g3f1ff2140


