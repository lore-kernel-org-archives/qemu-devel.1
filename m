Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78DFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964EE2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ9et49j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964EE2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTGj-0003Gj-Pw
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8V-0007VU-Bs
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54826
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8T-0000qz-Er
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7arBjwywDdVge+nq40Wb/WPqdlhhkJBZ1JLGzgHBd0=;
 b=IQ9et49jR2K16v1eCW9XHEVVEdgLNBTcnkwTS3JRbhlDcDM8gtjYZhbawfuiZ4XCLLyQ7Y
 Yr6yM0AfjFkZtjHTiRZgZA4jHEVEkMCfXtWJu5kePKVg/nkap2Wdb7OvD2eRC5oESHq30a
 k79ZcrcSg4Bp9zTsHlHWU36F2brRCvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-vYN2wNuUNW2ININfFuQ1Zw-1; Thu, 11 Jun 2020 15:45:05 -0400
X-MC-Unique: vYN2wNuUNW2ININfFuQ1Zw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49244107ACCA;
 Thu, 11 Jun 2020 19:45:04 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0C5F60CC0;
 Thu, 11 Jun 2020 19:45:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 015/115] io/task: Move 'qom/object.h' header to source
Date: Thu, 11 Jun 2020 15:43:09 -0400
Message-Id: <20200611194449.31468-16-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We need "qom/object.h" to call object_ref()/object_unref(),
and to test the TYPE_DUMMY.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200504115656.6045-3-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/io/task.h    | 2 --
 io/task.c            | 1 +
 tests/test-io-task.c | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/io/task.h b/include/io/task.h
index 1abbfb8b65..6818dfedd0 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -21,8 +21,6 @@
 #ifndef QIO_TASK_H
 #define QIO_TASK_H
 
-#include "qom/object.h"
-
 typedef struct QIOTask QIOTask;
 
 typedef void (*QIOTaskFunc)(QIOTask *task,
diff --git a/io/task.c b/io/task.c
index 1ae7b86488..53c0bed686 100644
--- a/io/task.c
+++ b/io/task.c
@@ -22,6 +22,7 @@
 #include "io/task.h"
 #include "qapi/error.h"
 #include "qemu/thread.h"
+#include "qom/object.h"
 #include "trace.h"
 
 struct QIOTaskThreadData {
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index aa8b653bfa..c8a3813d49 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 
+#include "qom/object.h"
 #include "io/task.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-- 
2.26.2



