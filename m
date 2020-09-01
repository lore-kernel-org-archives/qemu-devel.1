Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC88C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD51A2071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0BH/vgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD51A2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDAGd-0004wU-W5
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDAFD-0003d6-Nw
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:38:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37718
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDAFC-00017v-4a
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598981932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Y8Fad6S4BrWEdxZ5sn+7TbUYXTozCssSaCacs2tUcQ=;
 b=f0BH/vgqB+w8+6dGFlxgwrKMF0Ymkp/XaJk+mep4KtM8AcrHXAePiHigMcIRNHh+jPYFTn
 G9kbh+OZ7iIJH8bL1andlgPp2uax00wFOuTQM2LOfFu1V2KD3WeYgV4157mhxWlLk3zlme
 qNyzZD+CDn/aHnhNE3xTSZIE//fjVVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-SkHBJNqmP3CUPG1iT6GkwQ-1; Tue, 01 Sep 2020 13:38:48 -0400
X-MC-Unique: SkHBJNqmP3CUPG1iT6GkwQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F29510ABDB8;
 Tue,  1 Sep 2020 17:38:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CFA751C4F;
 Tue,  1 Sep 2020 17:38:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/26] Makefile: Add back TAGS/ctags/cscope rules
Date: Tue,  1 Sep 2020 13:38:41 -0400
Message-Id: <20200901173842.5882-4-pbonzini@redhat.com>
In-Reply-To: <20200901173842.5882-1-pbonzini@redhat.com>
References: <20200901173842.5882-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

It is a bit of a pain to be forced to run configure before being able
to use cscope and friends. Add back the rules to build them in-tree
as before commit a56650518f5b.

Fixes: a56650518f5b ("configure: integrate Meson in the build system")
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159897001005.442705.16516671603870288336.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c1a93c66a0..049e2ffa03 100644
--- a/Makefile
+++ b/Makefile
@@ -62,7 +62,7 @@ ninja-distclean::
 build.ninja: config-host.mak
 
 Makefile.ninja: build.ninja ninjatool
-	./ninjatool -t ninja2make --omit clean dist uninstall < $< > $@
+	./ninjatool -t ninja2make --omit clean dist uninstall cscope TAGS ctags < $< > $@
 -include Makefile.ninja
 
 ${ninja-targets-c_COMPILER} ${ninja-targets-cpp_COMPILER}: .var.command += -MP
@@ -229,6 +229,22 @@ distclean: clean ninja-distclean
 	rm -f linux-headers/asm
 	rm -Rf .sdk
 
+.PHONY: ctags
+ctags:
+	rm -f tags
+	find "$(SRC_PATH)" -name '*.[hc]' -exec ctags --append {} +
+
+.PHONY: TAGS
+TAGS:
+	rm -f TAGS
+	find "$(SRC_PATH)" -name '*.[hc]' -exec etags --append {} +
+
+.PHONY: cscope
+cscope:
+	rm -f "$(SRC_PATH)"/cscope.*
+	find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed -e 's,^\./,,' > "$(SRC_PATH)/cscope.files"
+	cscope -b -i"$(SRC_PATH)/cscope.files"
+
 # Needed by "meson install"
 export DESTDIR
 
-- 
2.26.2



