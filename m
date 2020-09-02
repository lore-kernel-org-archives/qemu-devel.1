Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23A6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768D120767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afutbfJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768D120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSRi-0007bE-Jk
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMQ-00060P-U7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMN-00076G-Rz
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3b2k/ACQofE8pTVL55ApXrAJngPSilZmR+GnhBL4Bw=;
 b=afutbfJgwD039Er8whfZv4LUxBi/pDghdvIe2nyp5OCZu50nD4dxB9S8Rs4JreNI6PMwzF
 juczlHLYghInkRW1OGVcJ1SHticJht89TPKfHfPozVl8NylQAIw1p5xJ97A24VEESCWFTN
 FRx+c/OyGNIl/tt7GGGsRyhwT+wPmK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-THNNEqj3ME6Owtyg_vWOsw-1; Wed, 02 Sep 2020 08:59:28 -0400
X-MC-Unique: THNNEqj3ME6Owtyg_vWOsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 408868A6F0E
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:22 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 040315D9CC
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/39] ninjatool: use constant names for stamp files
Date: Wed,  2 Sep 2020 08:58:47 -0400
Message-Id: <20200902125917.26021-10-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Numbering files according to rules causes confusion, because
CUSTOM_COMMAND3.stamp from a previous build might represent
completely different targets after Makefile.ninja is regenerated.
As a result, the new targets are not rebuilt and compilation
fails.

Use the targets to build a SHA1 hash; the chances for collision
are one in 2^24 even with a 12-character prefix of the hash.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/ninjatool.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/ninjatool.py b/scripts/ninjatool.py
index ba6bd9a2a6..627a1cab45 100755
--- a/scripts/ninjatool.py
+++ b/scripts/ninjatool.py
@@ -34,6 +34,7 @@ import os
 import re
 import json
 import argparse
+import hashlib
 import shutil
 
 
@@ -51,6 +52,9 @@ else:
     normpath = os.path.normpath
 
 
+def sha1_text(text):
+    return hashlib.sha1(text.encode()).hexdigest()
+
 # ---- lexer and parser ----
 
 PATH_RE = r"[^$\s:|]+|\$[$ :]|\$[a-zA-Z0-9_-]+|\$\{[a-zA-Z0-9_.-]+\}"
@@ -767,7 +771,6 @@ class Ninja2Make(NinjaParserEventsWithVars):
         self.build_vars = defaultdict(lambda: dict())
         self.rule_targets = defaultdict(lambda: list())
         self.stamp_targets = defaultdict(lambda: list())
-        self.num_stamp = defaultdict(lambda: 0)
         self.all_outs = set()
         self.all_ins = set()
         self.all_phony = set()
@@ -903,8 +906,7 @@ class Ninja2Make(NinjaParserEventsWithVars):
             if len(out) == 1:
                 stamp = out[0] + '.stamp'
             else:
-                stamp = '%s%d.stamp' %(rule, self.num_stamp[rule])
-                self.num_stamp[rule] += 1
+                stamp = '%s@%s.stamp' % (rule, sha1_text(targets)[0:11])
             self.print('%s: %s; @:' % (targets, stamp))
             self.print('%s: %s | %s; ${ninja-command-restat}' % (stamp, inputs, orderonly))
             self.rule_targets[rule].append(stamp)
-- 
2.26.2



