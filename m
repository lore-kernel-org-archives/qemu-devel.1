Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154B7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688F420702
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCWOgSfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688F420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3CA-0005KB-5a
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc34M-0005Gr-E7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:02:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc34K-0004bR-L7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604912551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0eAf4G3UytQjjSQ3AIUQihXFsb/aqtAMLl5D/O9nzQ=;
 b=fCWOgSfpityIJDN+cODH6Pla3CK0TDShYPe/ou7n71fbkb3/ejj0sQVMSVZYJPbCT3DoHe
 G4MUOI76/w5ooX5XwjI2vIgbpQ2dkJCeYbT1VW7ZgbmEbDmabGTQ0OI6DWM4GmEdP7p01N
 mZ0e+npTt9QWYpsAETJx9h3gcsOHmc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-U0N7PzJsMtiBA-J-9u9_2Q-1; Mon, 09 Nov 2020 04:02:29 -0500
X-MC-Unique: U0N7PzJsMtiBA-J-9u9_2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C93EE805F03;
 Mon,  9 Nov 2020 09:02:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 279605C1DC;
 Mon,  9 Nov 2020 09:02:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF3451132921; Mon,  9 Nov 2020 10:02:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] MAINTAINERS: Add QAPI schema modules to their subsystems
Date: Mon,  9 Nov 2020 10:02:17 +0100
Message-Id: <20201109090220.825764-3-armbru@redhat.com>
In-Reply-To: <20201109090220.825764-1-armbru@redhat.com>
References: <20201109090220.825764-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: peter.maydell@linaro.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the relevant QAPI schema modules to section Audio, QMP, Tracing,
Cryptography.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20201102081550.171061-2-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63223e1183..30e1eccbec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1909,6 +1909,7 @@ Rocker
 M: Jiri Pirko <jiri@resnulli.us>
 S: Maintained
 F: hw/net/rocker/
+F: qapi/rocker.json
 F: tests/rocker/
 F: docs/specs/rocker.txt
 
@@ -2111,6 +2112,7 @@ S: Maintained
 F: audio/
 F: hw/audio/
 F: include/hw/audio/
+F: qapi/audio.json
 F: tests/qtest/ac97-test.c
 F: tests/qtest/es1370-test.c
 F: tests/qtest/intel-hda-test.c
@@ -2490,7 +2492,9 @@ F: monitor/monitor-internal.h
 F: monitor/qmp*
 F: monitor/misc.c
 F: monitor/monitor.c
+F: qapi/control.json
 F: qapi/error.json
+F: qapi/introspect.json
 F: docs/devel/*qmp-*
 F: docs/interop/*qmp-*
 F: scripts/qmp/
@@ -2551,6 +2555,7 @@ S: Maintained
 F: trace/
 F: trace-events
 F: docs/qemu-option-trace.rst.inc
+F: qapi/trace.json
 F: scripts/tracetool.py
 F: scripts/tracetool/
 F: scripts/qemu-trace-stap*
@@ -2610,6 +2615,7 @@ M: Daniel P. Berrange <berrange@redhat.com>
 S: Maintained
 F: crypto/
 F: include/crypto/
+F: qapi/crypto.json
 F: tests/test-crypto-*
 F: tests/benchmark-crypto-*
 F: tests/crypto-tls-*
-- 
2.26.2


