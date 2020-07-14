Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE1BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FDC20658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxLPBA93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FDC20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTMT-0005Xw-KV
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJU-0000Wp-PB
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40974
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJT-0004bC-62
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68z3SIjA0BJxIasZ4nmbsDP+rWPK+60CWkUJsZTRUF4=;
 b=RxLPBA93YB7sbadf/c0UDIDTYuJLqhdt2Vna3cJDdxJEE8V78cbGM+k6mA5uEVivQctAAD
 vrcOiKtsd4IzCOPeDMrClK4lm/pj02YhM6ZfcC9FvYvsOrfQxanZQ/bkcdMxHSXtxOKehS
 GqIlycgu393Bjgn0OuPOLpTwurQfNxM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-tHJohPzqNR2-Go2YqC_DBw-1; Tue, 14 Jul 2020 18:22:08 -0400
X-MC-Unique: tHJohPzqNR2-Go2YqC_DBw-1
Received: by mail-wr1-f72.google.com with SMTP id i12so20456wrx.11
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=68z3SIjA0BJxIasZ4nmbsDP+rWPK+60CWkUJsZTRUF4=;
 b=KgK3WZRaDPy4OYK0Zn+F3DRIvqc5Pz/A+lHhAoqQLxDkp7c5s9L4sKUknw4t74/na+
 Ir++IqUVvBXFMiom9MP4q6U/+djo6sPOixb5ac/K/rk+ndXsTFQEYoGQR6Dsqyq6poT8
 o8p87kagSKV/5S8l1SrPhMzXVUE8KudL452po/C9qF9XEH9ybwnqir3HE9W8Ay6bJKPk
 n40bPYMnSz/VubVBHOWYBG+Vu2u3AV9MiJJ2olwFrdt1dUjU+TXi9vJKsk0GQieZgy+u
 9YK1uH7+NRjtsaeWXC4B3ce1r9Vo7HJzZMGMXxPQ4lKdFUrkEv1M2ekbVI/HCbKxcL6r
 A25A==
X-Gm-Message-State: AOAM533v8rDWjBs7PNLVzET8SarUvIT/j2E1+j1UKAdVc/PZ6XicuJeT
 mXE0+16hhH4Ab+1Fe+Nc2t65M0Hbh8WtB34Zyx20OqjrbPAjSdt+MtI63YH38om6rf4a+qk+DgB
 tUn8GiDmBAhVTA4M=
X-Received: by 2002:adf:a34a:: with SMTP id d10mr8146581wrb.59.1594765327499; 
 Tue, 14 Jul 2020 15:22:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4aq8z2uTcKBNxUqaFI5a3I30Ipkmo21q/+89pXZBlZJA/2QaQOTakehim7Guk7EHZfyfkVw==
X-Received: by 2002:adf:a34a:: with SMTP id d10mr8146563wrb.59.1594765327304; 
 Tue, 14 Jul 2020 15:22:07 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d28sm205619wrc.50.2020.07.14.15.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/19] python/machine.py: Add a configurable timeout to
 shutdown()
Date: Wed, 15 Jul 2020 00:21:20 +0200
Message-Id: <20200714222132.10815-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 18:21:58
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Three seconds is hardcoded. Use it as a default parameter instead, and use that
value for both waits that may occur in the function.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200710050649.32434-7-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index c28957ee82..e825f0bdc6 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -393,7 +393,9 @@ def wait(self):
         self._popen.wait()
         self._post_shutdown()
 
-    def shutdown(self, has_quit=False, hard=False):
+    def shutdown(self, has_quit: bool = False,
+                 hard: bool = False,
+                 timeout: Optional[int] = 3) -> None:
         """
         Terminate the VM and clean up
         """
@@ -409,10 +411,10 @@ def shutdown(self, has_quit=False, hard=False):
                 try:
                     if not has_quit:
                         self._qmp.cmd('quit')
-                    self._popen.wait(timeout=3)
+                    self._popen.wait(timeout=timeout)
                 except:
                     self._popen.kill()
-            self._popen.wait()
+            self._popen.wait(timeout=timeout)
 
         self._post_shutdown()
 
-- 
2.21.3


