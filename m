Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5907FC10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 21:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286BE20896
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 21:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286BE20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44303 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIgFT-0003Lk-Ae
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 17:13:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIgEC-0002Td-OY
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIg7V-0000Id-Ad
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:04:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIg7V-0000II-5N
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:04:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76DF537F43
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 21:04:56 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0AFE25D9C8;
	Mon, 22 Apr 2019 21:04:55 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 18:04:48 -0300
Message-Id: <20190422210448.2488-4-ehabkost@redhat.com>
In-Reply-To: <20190422210448.2488-1-ehabkost@redhat.com>
References: <20190422210448.2488-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 22 Apr 2019 21:04:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] accel: Remove unused AccelClass::available
 field
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422210448.Cvv-SnobmqwrS-C_SnZWDZlLVZi6lxgrxTG6RvSw-v4@z>

The field is not used anymore, we can remove it.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/accel.h | 1 -
 accel/accel.c          | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 5565e00a96..70e9e2f2a1 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -38,7 +38,6 @@ typedef struct AccelClass {
 
     const char *opt_name;
     const char *name;
-    int (*available)(void);
     int (*init_machine)(MachineState *ms);
     void (*setup_post)(MachineState *ms, AccelState *accel);
     bool *allowed;
diff --git a/accel/accel.c b/accel/accel.c
index 454fef9d92..5fa31717b4 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -107,11 +107,6 @@ void configure_accelerator(MachineState *ms, const char *progname)
         if (!acc) {
             continue;
         }
-        if (acc->available && !acc->available()) {
-            printf("%s not supported for this target\n",
-                   acc->name);
-            continue;
-        }
         ret = accel_init_machine(acc, ms);
         if (ret < 0) {
             init_failed = true;
-- 
2.18.0.rc1.1.g3f1ff2140


