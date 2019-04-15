Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88370C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5569A20825
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5569A20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50264 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG1gT-0006dP-Ey
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 09:30:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dp-0004fg-1h
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dm-00053k-Ti
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hG1dm-00052d-34; Mon, 15 Apr 2019 09:27:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBAD73098557;
	Mon, 15 Apr 2019 13:27:15 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2C39D1001E6D;
	Mon, 15 Apr 2019 13:27:13 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 15:27:19 +0200
Message-Id: <1555334842-195718-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 15 Apr 2019 13:27:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 2/5] ppc: rs6000_mc: drop usage of
 memory_region_allocate_system_memory()
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
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
	Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
	=?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415132719.MGwoaDF-rtmP5-JqOjWq47NvrFw7a3izmRAUD5sLMIU@z>

rs6000mc_realize() violates memory_region_allocate_system_memory() contract
by calling it multiple times which could break -mem-path. Replace it with
plain memory_region_init_ram() instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/ppc/rs6000_mc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index 45cb95e..ea174f1 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -142,6 +142,7 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
     RS6000MCState *s = RS6000MC_DEVICE(dev);
     int socket = 0;
     unsigned int ram_size = s->ram_size / MiB;
+    Error *local_err = NULL;
 
     while (socket < 6) {
         if (ram_size >= 64) {
@@ -163,19 +164,21 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
         if (s->simm_size[socket]) {
             char name[] = "simm.?";
             name[5] = socket + '0';
-            memory_region_allocate_system_memory(&s->simm[socket], OBJECT(dev),
-                                                 name,
-                                                 s->simm_size[socket] * MiB);
+            memory_region_init_ram(&s->simm[socket], OBJECT(dev), name,
+                                   s->simm_size[socket] * MiB, &local_err);
+            if (local_err) {
+                goto out;
+            }
             memory_region_add_subregion_overlap(get_system_memory(), 0,
                                                 &s->simm[socket], socket);
         }
     }
     if (ram_size) {
         /* unable to push all requested RAM in SIMMs */
-        error_setg(errp, "RAM size incompatible with this board. "
+        error_setg(&local_err, "RAM size incompatible with this board. "
                    "Try again with something else, like %" PRId64 " MB",
                    s->ram_size / MiB - ram_size);
-        return;
+        goto out;
     }
 
     if (s->autoconfigure) {
@@ -191,6 +194,8 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
 
     isa_register_portio_list(ISA_DEVICE(dev), &s->portio, 0x0,
                              rs6000mc_port_list, s, "rs6000mc");
+out:
+    error_propagate(errp, local_err);
 }
 
 static const VMStateDescription vmstate_rs6000mc = {
-- 
2.7.4


