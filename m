Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CABC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6192068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGkvwhOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6192068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnNk-0000xz-3K
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMm-0007fW-Li
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40330
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMk-0004KX-NC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595319069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPtrztw9XpCfhwIOLgP9AbPXxCIFdvLDY4Et5nO8O1c=;
 b=jGkvwhOYapMnNMo5eC2zkaC/sniaO+PVjRYkGzUlyiexPeKw5FKX7kd0IT5OmCBLgPPMMj
 iTmk72D1UaU+QyqYrIIPSM0U7VTRy5WPr6mA/AC1vLgR2ublG+FyN/V+IT/687naWhbqWi
 RCI4u95/LfBYErGlYnC8EfA5YEQHp34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-rYbpRK0wOmubSoz-PevEDw-1; Tue, 21 Jul 2020 04:11:06 -0400
X-MC-Unique: rYbpRK0wOmubSoz-PevEDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A991F801A03;
 Tue, 21 Jul 2020 08:11:05 +0000 (UTC)
Received: from thuth.com (ovpn-112-102.ams2.redhat.com [10.36.112.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84B2E19C66;
 Tue, 21 Jul 2020 08:11:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 05/10] docs/fuzz: describe building fuzzers with
 enable-sanitizers
Date: Tue, 21 Jul 2020 10:10:50 +0200
Message-Id: <20200721081055.14073-6-thuth@redhat.com>
In-Reply-To: <20200721081055.14073-1-thuth@redhat.com>
References: <20200721081055.14073-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200706195534.14962-3-alxndr@bu.edu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/fuzzing.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index db5641de74..12bf6aa0ca 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -23,9 +23,12 @@ AddressSanitizer mmaps ~20TB of memory, as part of its detection. This results
 in a large page-map, and a much slower fork().
 
 To build the fuzzers, install a recent version of clang:
-Configure with (substitute the clang binaries with the version you installed):
+Configure with (substitute the clang binaries with the version you installed).
+Here, enable-sanitizers, is optional but it allows us to reliably detect bugs
+such as out-of-bounds accesses, use-after-frees, double-frees etc.
 
-    CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing
+    CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing \
+                                                --enable-sanitizers
 
 Fuzz targets are built similarly to system/softmmu:
 
-- 
2.18.1


