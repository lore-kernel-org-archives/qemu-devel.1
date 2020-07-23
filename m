Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC0FC433EA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B87E2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feFOEb5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B87E2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jybBg-0008Be-ME
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jybB7-0007eV-Le
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:22:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22688
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jybB6-0004UM-45
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595510546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=vZt8rkdK5Jjjjo08PqG1pwyj2txCcJYqMQPuleccBJ8=;
 b=feFOEb5AiLWzV69ttOjb0MzpGOldTSe5Zp9sizalIEbUEJBasu2FplVBQr+FQ1NA0l6UWj
 bL4sbGDwfiyWzOskjEpmhxWHJuJ2o0lfPiweIyZb5NrE7pgRhneD/qzUi+WLtacfddOidU
 oDIPtlzpFNb8U+v6X9XccHCxEM6O7pI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-TuWPSK0YPNSGUQr_DwSkfg-1; Thu, 23 Jul 2020 09:22:25 -0400
X-MC-Unique: TuWPSK0YPNSGUQr_DwSkfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5176E91B;
 Thu, 23 Jul 2020 13:22:23 +0000 (UTC)
Received: from thuth.com (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B26019D7C;
 Thu, 23 Jul 2020 13:22:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH] target/unicore32: Remove CURSES stuff from the Makefile.objs
Date: Thu, 23 Jul 2020 15:22:19 +0200
Message-Id: <20200723132219.2956-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The dependency on curses has been removed in commit c7a856b42e403e2b
("target/unicore32: Prefer qemu_semihosting_log_out() over curses").
So we can remove the related lines in the Makefile now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/unicore32/Makefile.objs | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/unicore32/Makefile.objs b/target/unicore32/Makefile.objs
index 35d8bf530d..6b41b1e9ef 100644
--- a/target/unicore32/Makefile.objs
+++ b/target/unicore32/Makefile.objs
@@ -2,7 +2,3 @@ obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += ucf64_helper.o
 
 obj-$(CONFIG_SOFTMMU) += softmmu.o
-
-# Huh? Uses curses directly instead of using ui/console.h interfaces ...
-helper.o-cflags := $(CURSES_CFLAGS)
-helper.o-libs := $(CURSES_LIBS)
-- 
2.18.1


