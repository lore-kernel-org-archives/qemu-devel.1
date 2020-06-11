Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2101C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DAD2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0MPSjWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DAD2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTwF-0007Bi-1j
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAC-0001Ta-4A
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52157
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAA-0001Mv-66
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LPB2CEdAH2eBhJn+rk8T9Y/aaFkfHqAa/A8gAWOEfA8=;
 b=f0MPSjWScjRbCquyCwLkzHcg/U+vT3lW/a6CKadKiUBruiUmEzq2BM0UmaTSJRvxOlYaG2
 Fx7D8dU+5OMMam+sGqCbd+IrLV0YHpeCDtmLrvhIZE3HLGg4Gc6WfvDD35WgVE+uehLoiM
 cwIMemjk1yR9fYEDQ2JUYo6im4PXyxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-WzmfWEFUNim0xjBzJ0t_5w-1; Thu, 11 Jun 2020 15:46:53 -0400
X-MC-Unique: WzmfWEFUNim0xjBzJ0t_5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89FDC107ACF8;
 Thu, 11 Jun 2020 19:46:45 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3094C60CC0;
 Thu, 11 Jun 2020 19:46:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 071/115] tests: machine-none-test: Enable MicroBlaze testing
Date: Thu, 11 Jun 2020 15:44:05 -0400
Message-Id: <20200611194449.31468-72-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Enable MicroBlaze testing.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <20200416193303.23674-2-edgar.iglesias@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/machine-none-test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 10d8ec26a9..8b7abea8af 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -33,8 +33,8 @@ static struct arch2cpu cpus_map[] = {
     { "cris", "crisv32" },
     { "lm32", "lm32-full" },
     { "m68k", "m5206" },
-    /* FIXME: { "microblaze", "any" }, doesn't work with -M none -cpu any */
-    /* FIXME: { "microblazeel", "any" }, doesn't work with -M none -cpu any */
+    { "microblaze", "any" },
+    { "microblazeel", "any" },
     { "mips", "4Kc" },
     { "mipsel", "I7200" },
     { "mips64", "20Kc" },
@@ -79,10 +79,8 @@ static void test_machine_cpu_cli(void)
     QTestState *qts;
 
     if (!cpu_model) {
-        if (!(!strcmp(arch, "microblaze") || !strcmp(arch, "microblazeel"))) {
-            fprintf(stderr, "WARNING: cpu name for target '%s' isn't defined,"
-                    " add it to cpus_map\n", arch);
-        }
+        fprintf(stderr, "WARNING: cpu name for target '%s' isn't defined,"
+                " add it to cpus_map\n", arch);
         return; /* TODO: die here to force all targets have a test */
     }
     qts = qtest_initf("-machine none -cpu '%s'", cpu_model);
-- 
2.26.2



