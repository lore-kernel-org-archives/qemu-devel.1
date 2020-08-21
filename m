Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2B8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5517220656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUlabyRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5517220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94jQ-0001UZ-GZ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dx-0002T1-2U
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30414
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Ds-0001fs-Ar
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2m9BLaRc2vYcN4AzbMEg1k1RBUEJSYEg5EY4KfBueFg=;
 b=UUlabyRu6JNWm1d/2MFzpz5xLy9+oi6secud8HYFfsKfz8hzD9pRTZY2wAHwusl4Key71+
 BIN+H0oGQpBK2BgBD+zuaGwK+N2G1apcdr/7kVkS+xntZ7F6N/es0UTLBGpk7lDlZkFUXd
 TJZcqeIrEohCHCPgaHESulV842V+kn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-waLd0zNtN2SSUaysFkfikw-1; Fri, 21 Aug 2020 06:24:34 -0400
X-MC-Unique: waLd0zNtN2SSUaysFkfikw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51EC456B5B
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 028855C1D0;
 Fri, 21 Aug 2020 10:24:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 075/152] meson: convert trace/
Date: Fri, 21 Aug 2020 06:22:12 -0400
Message-Id: <20200821102329.29777-76-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 trace/Makefile.objs | 8 --------
 trace/meson.build   | 5 ++++-
 2 files changed, 4 insertions(+), 9 deletions(-)
 delete mode 100644 trace/Makefile.objs

diff --git a/trace/Makefile.objs b/trace/Makefile.objs
deleted file mode 100644
index a429474618..0000000000
--- a/trace/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-# -*- mode: makefile -*-
-
-
-##################################################
-# Translation level
-
-obj-y += generated-helpers.o
-obj-y += control-target.o
diff --git a/trace/meson.build b/trace/meson.build
index cab36a248b..9c3c128164 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -1,3 +1,5 @@
+specific_ss.add(files('control-target.c'))
+
 trace_events_files = []
 foreach dir : [ '.' ] + trace_events_subdirs
   trace_events_file = meson.source_root() / dir / 'trace-events'
@@ -61,12 +63,13 @@ foreach d : [
   ['generated-helpers.h', 'tcg-helper-h'],
   ['generated-helpers-wrappers.h', 'tcg-helper-wrapper-h'],
 ]
-  custom_target(d[0],
+  gen = custom_target(d[0],
                 output: d[0],
                 input: meson.source_root() / 'trace-events',
                 command: [ tracetool, '--group=root', '--format=@0@'.format(d[1]), '@INPUT@' ],
                 build_by_default: true, # to be removed when added to a target
                 capture: true)
+  specific_ss.add(gen)
 endforeach
 
 if 'CONFIG_TRACE_UST' in config_host
-- 
2.26.2



