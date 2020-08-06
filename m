Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6813FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990452312F
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbBkehqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990452312F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3iZe-0001rU-Fv
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 12:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3iYl-0001Sh-2P
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:16:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37064
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3iYg-0002Fi-9K
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596730556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=RBzuaF5Qe/dSOZIP1zUuk0z7oBq1C4WAiDvCdbvSO6c=;
 b=CbBkehqgnTJ3q/O2HMDHjdn3w4QTnn5pKTVxCgCBr8m13Klc0F48RJ+BmzqhHAeo/GkAnH
 YsDYXizmnSOb8DfZod5SdAcDA37+R4IC1JyV7BXKmpW/Gm+FSxUHva906Lex3IYqqRvGAG
 IF5lxP2E4+/h0gGYIkxeIaByEfLJBQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-28SZGzeyMT2WdXYpnGkneA-1; Thu, 06 Aug 2020 12:15:54 -0400
X-MC-Unique: 28SZGzeyMT2WdXYpnGkneA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAECD800685;
 Thu,  6 Aug 2020 16:15:53 +0000 (UTC)
Received: from thuth.com (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44B6F1A919;
 Thu,  6 Aug 2020 16:15:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] gitlab-ci.yml: Set artifacts expiration time
Date: Thu,  6 Aug 2020 18:15:46 +0200
Message-Id: <20200806161546.15325-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default expiration time for artifacts seems to be very high (30 days?).
Since we only need the artifacts to pass the binaries from one stage to
the next one, we can decrease the expiration time to avoid to spam the
file server too much. Two days should be enough in case someone still wants
to have a look after the pipeline finished.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 672bd9a318..d5692378b7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -74,6 +74,7 @@ build-system-ubuntu:
       moxie-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
   artifacts:
+    expire_in: 2 days
     paths:
       - build
 
@@ -104,6 +105,7 @@ build-system-debian:
       riscv64-softmmu sh4eb-softmmu sparc-softmmu xtensaeb-softmmu
     MAKE_CHECK_ARGS: check-build
   artifacts:
+    expire_in: 2 days
     paths:
       - build
 
@@ -134,6 +136,7 @@ build-system-fedora:
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
   artifacts:
+    expire_in: 2 days
     paths:
       - build
 
@@ -164,6 +167,7 @@ build-system-centos:
       x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
     MAKE_CHECK_ARGS: check-build
   artifacts:
+    expire_in: 2 days
     paths:
       - build
 
-- 
2.18.1


