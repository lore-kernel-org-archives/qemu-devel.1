Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9819BC433E8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6739F2074F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcCrhxqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6739F2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyn2-0000YW-O2
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyykV-0004rt-EH
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:32:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyykT-0004Zj-Gl
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595601152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=34mGIakUadJViNFdG2ovTxD3iiZFLcirwtUz+RdiRg4=;
 b=OcCrhxqJtIiPPPCThcCL8FgYdFeWSp9ceOMNFeMbMeb1x0Xne/IBKECRMOhFAR0Ok6J6LM
 JIuykjUqaysvqINHzTWMKidQLE0Q36Agj7axMuCgWj0JBzFDbflXPcybeqUUBzA1VIU9Qv
 c207y4qi1QycBtJR5GaKWtI1U/Iok1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-xbdiJ9FuNqyMJHIoXkNupQ-1; Fri, 24 Jul 2020 10:32:30 -0400
X-MC-Unique: xbdiJ9FuNqyMJHIoXkNupQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45FC7189CEF1;
 Fri, 24 Jul 2020 14:32:29 +0000 (UTC)
Received: from thuth.com (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A44C2DE79;
 Fri, 24 Jul 2020 14:32:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/3] cirrus.yml: Compile macOS and FreeBSD with -Werror
Date: Fri, 24 Jul 2020 16:32:19 +0200
Message-Id: <20200724143220.32751-3-thuth@redhat.com>
In-Reply-To: <20200724143220.32751-1-thuth@redhat.com>
References: <20200724143220.32751-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Ed Maste <emaste@freebsd.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Compiler warnings currently go unnoticed in our FreeBSD and macOS builds,
since -Werror is only enabled for Linux and MinGW builds by default. So
let's enable them here now, too.
For macOS, that unfortunately means that we have to disable the vnc-sasl
feature, since this is marked as deprecated in the macOS headers and thus
generates a lot of deprecation warnings.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .cirrus.yml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index f287d23c5b..bb25c1723b 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -12,7 +12,7 @@ freebsd_12_task:
   script:
     - mkdir build
     - cd build
-    - ../configure || { cat config.log; exit 1; }
+    - ../configure --enable-werror || { cat config.log; exit 1; }
     - gmake -j8
     - gmake V=1 check
 
@@ -24,7 +24,8 @@ macos_task:
   script:
     - mkdir build
     - cd build
-    - ../configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
+    - ../configure --python=/usr/local/bin/python3 --disable-vnc-sasl
+        --enable-werror || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check
 
@@ -37,6 +38,7 @@ macos_xcode_task:
   script:
     - mkdir build
     - cd build
-    - ../configure --cc=clang || { cat config.log; exit 1; }
+    - ../configure --cc=clang --disable-vnc-sasl --enable-werror
+        || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check
-- 
2.18.1


