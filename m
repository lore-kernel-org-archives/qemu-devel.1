Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEEDC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA1F208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA1F208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZL9J-0007ag-NK
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 16:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hZJfv-0006cv-DS
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hZJfr-0000zF-JG
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:33:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hZJfj-0000qG-W9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:33:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 087AB104C1;
 Fri,  7 Jun 2019 18:32:39 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5893061373;
 Fri,  7 Jun 2019 18:32:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri,  7 Jun 2019 15:32:28 -0300
Message-Id: <20190607183228.22454-3-ehabkost@redhat.com>
In-Reply-To: <20190607183228.22454-1-ehabkost@redhat.com>
References: <20190607183228.22454-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 07 Jun 2019 18:32:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] accel: Remove unused AccelClass::opt_name
 attribute
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

The AccelType type was converted to AccelClass QOM
object on b14a0b7469f, and the original data type had
a field to store the option name which in turn was
used to search an accelerator. The lookup method
(accel_find) changed too, making the option field
unnecessary but it became AccelClass::opt_name despite
that. Therefore, and given that none accelerator
implementation sets AccelClass::opt_name, let's
remove this attribute.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20190531165334.20403-2-wainersm@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/accel.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 70e9e2f2a1..81293cdb08 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -36,7 +36,6 @@ typedef struct AccelClass {
     ObjectClass parent_class;
     /*< public >*/
 
-    const char *opt_name;
     const char *name;
     int (*init_machine)(MachineState *ms);
     void (*setup_post)(MachineState *ms, AccelState *accel);
-- 
2.18.0.rc1.1.g3f1ff2140


