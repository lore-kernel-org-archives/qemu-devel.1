Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5337AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59E02068D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwTT6wQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59E02068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6Vt-0002so-LP
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6Ng-0004Of-L6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6NZ-0000aO-Kg
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yf9rGomi4LHyASEleBQ5pCAugrkXHIE2Bvx640kQbiM=;
 b=GwTT6wQ0jCb8ak0yfmUSZZk9UPJm/hHESoYrb2l4Z2u9JH8kKiuqKASI+Qn63ORk1hO0Kq
 aN0bRkgRb9O7NoSYf4pwQHvXFhUP1a9xo/qiUeg+b+L04qIrW2+20lA7SdsP+R8GQdCCQV
 l+vZikfVeJbzdh1n+RU1jCAdY4wsqjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-MXd1RyhFPtqS55lAV1Hdtg-1; Thu, 15 Oct 2020 12:45:16 -0400
X-MC-Unique: MXd1RyhFPtqS55lAV1Hdtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9347F8D4420;
 Thu, 15 Oct 2020 16:45:14 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 368D96EF68;
 Thu, 15 Oct 2020 16:45:14 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 9/9] i386: Mark Icelake-Client CPU models deprecated
Date: Thu, 15 Oct 2020 12:45:01 -0400
Message-Id: <20201015164501.462775-10-ehabkost@redhat.com>
In-Reply-To: <20201015164501.462775-1-ehabkost@redhat.com>
References: <20201015164501.462775-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Robert Hoo <robert.hu@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Hoo <robert.hu@linux.intel.com>

Icelake-Client CPU models will be removed in the future.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Message-Id: <1600758855-80046-2-git-send-email-robert.hu@linux.intel.com>
[ehabkost: reword deprecation note, fix version in doc]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/system/deprecated.rst |  6 ++++++
 target/i386/cpu.c          | 10 +++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 09ec8b1ae8..21d122c49a 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -314,6 +314,12 @@ a future version of QEMU. Support for this CPU was removed from the
 upstream Linux kernel, and there is no available upstream toolchain
 to build binaries for it.
 
+``Icelake-Client`` CPU Model (since 5.2.0)
+''''''''''''''''''''''''''''''''''''''''''
+
+``Icelake-Client`` CPU Models are deprecated. Use ``Icelake-Server`` CPU
+Models instead.
+
 System emulator devices
 -----------------------
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2e3ee41c56..576746d763 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3358,10 +3358,13 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Icelake)",
         .versions = (X86CPUVersionDefinition[]) {
-            { .version = 1 },
+            {
+                .version = 1,
+                .note = "deprecated"
+            },
             {
                 .version = 2,
-                .note = "no TSX",
+                .note = "no TSX, deprecated",
                 .alias = "Icelake-Client-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
@@ -3370,7 +3373,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
                 },
             },
             { /* end of list */ }
-        }
+        },
+        .deprecation_note = "use Icelake-Server instead"
     },
     {
         .name = "Icelake-Server",
-- 
2.28.0


