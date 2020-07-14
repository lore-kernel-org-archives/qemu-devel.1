Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74448C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE9E223AB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2QuocY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE9E223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNms-0000aw-Gl
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvNlt-0008GW-QP
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:27:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvNlr-0003oU-Sl
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594744027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D01p+tWmBT4PZHPuHyTyUvbeoiIa/o+Z403q1mmhPSQ=;
 b=Z2QuocY2w9TMTwLn78SAELvHk3u07j1up8hrt9Tux2SKsUuplZaXC3E1XIEIjNL49I+46w
 8K0MIDrEfk0IjM94E5MtNp+a+Xr/ChsiGgJ+Vc9vUsQPM01+vsvhYlxXZpeh+SGuRdtLri
 F/9TYIcL6AgasfvKjfSOpcURx7yveZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-LhEWiLGsNMWxWzJ78BA6vA-1; Tue, 14 Jul 2020 12:27:05 -0400
X-MC-Unique: LhEWiLGsNMWxWzJ78BA6vA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1671380040A;
 Tue, 14 Jul 2020 16:27:04 +0000 (UTC)
Received: from domokun.gsslab.fab.redhat.com (unknown [10.33.8.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5474660BEC;
 Tue, 14 Jul 2020 16:27:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for 5.1] docs: fix trace docs build with sphinx 3.1.1
Date: Tue, 14 Jul 2020 17:26:59 +0100
Message-Id: <20200714162659.1017432-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In Fedora 33 rawhide, we now have sphinx 3.1.1, as opposed
to previous 2.2.2. This new version generates a warning on
the source:

docs/qemu-option-trace.rst.inc:4:Malformed option description
  '[enable=]PATTERN', should look like "opt", "-opt args",
  "--opt args", "/opt args" or "+opt args"

This turns into an error when QEMU passes -W to sphinx-build

Strangely the previous 2.2.2 code has the exact same logic
for checking the syntax, but it is not being triggered. While
it is only complaining about the first option, I changed all
the options to give consistency.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/qemu-option-trace.rst.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/qemu-option-trace.rst.inc b/docs/qemu-option-trace.rst.inc
index 7e09773a9c..e79b0b43fc 100644
--- a/docs/qemu-option-trace.rst.inc
+++ b/docs/qemu-option-trace.rst.inc
@@ -1,7 +1,7 @@
 
 Specify tracing options.
 
-.. option:: [enable=]PATTERN
+.. option:: -trace [enable=]PATTERN
 
   Immediately enable events matching *PATTERN*
   (either event name or a globbing pattern).  This option is only
@@ -11,7 +11,7 @@ Specify tracing options.
 
   Use :option:`-trace help` to print a list of names of trace points.
 
-.. option:: events=FILE
+.. option:: -trace events=FILE
 
   Immediately enable events listed in *FILE*.
   The file must contain one event name (as listed in the ``trace-events-all``
@@ -19,7 +19,7 @@ Specify tracing options.
   available if QEMU has been compiled with the ``simple``, ``log`` or
   ``ftrace`` tracing backend.
 
-.. option:: file=FILE
+.. option:: -trace file=FILE
 
   Log output traces to *FILE*.
   This option is only available if QEMU has been compiled with
-- 
2.24.1


