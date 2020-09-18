Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40762C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A491A20DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7+bPsNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A491A20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOTn-000333-JB
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kJNJR-0003Lh-GN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:49:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kJNJO-0006Uf-Oe
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItsJU/Dhvavx+vu0tFfDepkCUg9sXvnudkLYoCPPh+Q=;
 b=L7+bPsNpMV+gWzta0QJDLygM2J44JOQSeDf5yBwtHb6ZD3HGTgI7Wb9ASZ/yfQx4X1FgdM
 DySz0nOz0T0HnaeZh/twpNfOST1RfduDiQ9MZy+p73+uMP/TgeT6D+su2yCmTPayQyRMcN
 knLNrDEwLgZGhaj/g+cP9quxt5DSlYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-5-ujRE9BPAqJ6X8bKDziHQ-1; Fri, 18 Sep 2020 16:48:49 -0400
X-MC-Unique: 5-ujRE9BPAqJ6X8bKDziHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFB11805EE2;
 Fri, 18 Sep 2020 20:48:48 +0000 (UTC)
Received: from localhost (unknown [10.36.110.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E70D5D9E4;
 Fri, 18 Sep 2020 20:48:44 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] meson: replace pc-bios/Makefile
Date: Sat, 19 Sep 2020 00:47:59 +0400
Message-Id: <20200918204759.225810-7-marcandre.lureau@redhat.com>
In-Reply-To: <20200918204759.225810-1-marcandre.lureau@redhat.com>
References: <20200918204759.225810-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add an alias target "update-dtb" to recompile the device-tree "sources"
to the "blob" format.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 pc-bios/Makefile    | 19 -------------------
 pc-bios/meson.build | 12 ++++++++++++
 2 files changed, 12 insertions(+), 19 deletions(-)
 delete mode 100644 pc-bios/Makefile

diff --git a/pc-bios/Makefile b/pc-bios/Makefile
deleted file mode 100644
index 315288df84..0000000000
--- a/pc-bios/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# NOTE: only compilable with x86 cross compile tools
-#
-include ../config-host.mak
-
-DEFINES=
-
-TARGETS=
-
-all: $(TARGETS)
-
-%.o: %.S
-	$(CC) $(DEFINES) -c -o $@ $<
-
-%.dtb: %.dts
-	dtc -I dts -O dtb -o $@ $<
-
-clean:
-	rm -f $(TARGETS) *.o *~
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index d25585ca97..f004df7a4d 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -92,6 +92,18 @@ endif
 subdir('descriptors')
 subdir('keymaps')
 
+dtc = find_program('dtc', required: false)
+if dtc.found()
+  t = []
+  foreach f: ['bamboo.dts', 'canyonlands.dts', 'petalogix-ml605.dts', 'petalogix-s3adsp1800.dts']
+    t += custom_target(f,
+                       input: f,
+                       output: '@BASENAME@' + '.dtb',
+                       command: [dtc, '-I', 'dts', '-O', 'dtb', '-o', '@OUTPUT@', '@INPUT@'])
+  endforeach
+  alias_target('update-dtb', t)
+endif
+
 if host_machine.cpu_family() in ['x86', 'x86_64']
   subproject('optionrom')
 endif
-- 
2.26.2


