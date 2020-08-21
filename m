Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC3AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5530220748
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBlFl4QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5530220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94Iy-0004cc-Iy
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94D8-0000fO-9u
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:23:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39261
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94D4-0001Rc-QT
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrHVUEx7Xlep9B0WzqbnKA4wjHnNK9UAi/WWX4MDCB8=;
 b=ZBlFl4QBl+I3ajqsU6MrfZGilR6a1sbCkeYbS6OqYilsgpkwTpjnGeKBk45II05naGqBka
 40tis/k0nHPUiVbxB1o0kLiyRR5jY8zlfNXl8B7ESPChuNgqcuXNFZmveJ37EnBntKV4yn
 cJOrViwnrTzcRAgzOXd0/F4MSPaimlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-kQAOSZouO8-ijaO3OG5YDA-1; Fri, 21 Aug 2020 06:23:44 -0400
X-MC-Unique: kQAOSZouO8-ijaO3OG5YDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 838F0191E2A0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:23:43 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50EFB5DA74
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:23:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 011/152] nsis: use "make DESTDIR=" instead of "make prefix="
Date: Fri, 21 Aug 2020 06:21:08 -0400
Message-Id: <20200821102329.29777-12-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next patch will prevent modifying the prefix on "make install".  Adjust the
creation of the installer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 5596482dbd..ec12101a84 100644
--- a/Makefile
+++ b/Makefile
@@ -1188,16 +1188,16 @@ installer: $(INSTALLER)
 
 INSTDIR=/tmp/qemu-nsis
 
-$(INSTALLER): install-doc $(SRC_PATH)/qemu.nsi
-	$(MAKE) install prefix=${INSTDIR}
+$(INSTALLER): $(SRC_PATH)/qemu.nsi
+	$(MAKE) install DESTDIR=${INSTDIR}
 ifdef SIGNCODE
-	(cd ${INSTDIR}; \
+	(cd ${INSTDIR}/${bindir}; \
          for i in *.exe; do \
            $(SIGNCODE) $${i}; \
          done \
         )
 endif # SIGNCODE
-	(cd ${INSTDIR}; \
+	(cd ${INSTDIR}/${bindir}; \
          for i in qemu-system-*.exe; do \
            arch=$${i%.exe}; \
            arch=$${arch#qemu-system-}; \
@@ -1206,11 +1206,11 @@ endif # SIGNCODE
            echo File \"\$${BINDIR}\\$$i\"; \
            echo SectionEnd; \
          done \
-        ) >${INSTDIR}/system-emulations.nsh
+        ) >${INSTDIR}/${bindir}/system-emulations.nsh
 	makensis $(nsisflags) \
                 $(if $(BUILD_DOCS),-DCONFIG_DOCUMENTATION="y") \
                 $(if $(CONFIG_GTK),-DCONFIG_GTK="y") \
-                -DBINDIR="${INSTDIR}" \
+                -DBINDIR="${INSTDIR}/${bindir}" \
                 $(if $(DLL_PATH),-DDLLDIR="$(DLL_PATH)") \
                 -DSRCDIR="$(SRC_PATH)" \
                 -DOUTFILE="$(INSTALLER)" \
-- 
2.26.2



