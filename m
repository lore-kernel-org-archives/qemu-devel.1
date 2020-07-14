Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B476DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBB82072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4oPX68c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBB82072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTPt-0003kP-Pp
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJE-0000F1-J4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:21:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47098
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJA-0004W1-NJ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4PIu0HMQQfwQmcqNhOsRKcF3CqOiR6vgF4LSRdEoL8=;
 b=I4oPX68cWplyaskyWsF8q1BOyKyOatqEFQuarlHi1KuBQ+rVS9T+2qOMXwBl2+WlZX2DbW
 FWd6gkxC/a9W5bbTsuoxSAwzkviRsEUSk2UFGZYQl9R2GlyzdhZFrIhAoUUMMvVnA4biVS
 z+aeYFWLe4LKcFV13uvYl+/U1/frJ3k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-qxrP7g1zO42P-jKnvr-Rvw-1; Tue, 14 Jul 2020 18:21:50 -0400
X-MC-Unique: qxrP7g1zO42P-jKnvr-Rvw-1
Received: by mail-wr1-f72.google.com with SMTP id o25so17927wro.16
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f4PIu0HMQQfwQmcqNhOsRKcF3CqOiR6vgF4LSRdEoL8=;
 b=jASlVRxaHYrxxZHForxYuacahVLR2hQa2RcZdTkJpKrImfb8IhZgNAqa3WetnDNaSo
 sfTWCcyHGuh4F1Ox1OOYkBlL9K4ksF+S5SVjxjVWtUhqrS8fAwRSU9x5vR0LqQZd5ify
 g/mcTeXobd/U8yMJzwTD3FXzZGnYJhnHa9ii+bX/UMYDKiu0HJ5itkB3NZz/MPFC/2Q4
 QqcXDIbtZ3hm4XGJSBSwRqfzLTZk9btr468OcModEbaLKg9FmDHPm22s3ntb37Vauw3A
 NdXkEsgYzuZKzf0kzzgnLVZB5oC2ChDV0COJAiOAJWNB8nrzPmrG7zjLAQ0kD3P80eCC
 bcew==
X-Gm-Message-State: AOAM531UAY87lNIP+8ovZasRU97PJdNgGuUnuXfK9bMU1DgPJyWG64mJ
 rjx7tUBplYJjlXwUjP8xRcO3Mk+KqWo6vWu+aNrwQeLJ+sZ/rzHdbNM43ZUgaNYsoEUw6Ow+9oi
 VSnbRpuItjDnXbQM=
X-Received: by 2002:a1c:3bc1:: with SMTP id i184mr5729269wma.119.1594765308880; 
 Tue, 14 Jul 2020 15:21:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKDnGybAjeG5dJqWW0wSiVBJBdnKyUwvcrZOYtDNIFnAYbHL6Th6v+//SXR1HN3sCe/buyCQ==
X-Received: by 2002:a1c:3bc1:: with SMTP id i184mr5729252wma.119.1594765308665; 
 Tue, 14 Jul 2020 15:21:48 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j6sm181798wro.25.2020.07.14.15.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:21:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/19] python/machine.py: Close QMP socket in cleanup
Date: Wed, 15 Jul 2020 00:21:16 +0200
Message-Id: <20200714222132.10815-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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

It's not important to do this before waiting for the process to exit, so
it can be done during generic post-shutdown cleanup.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200710050649.32434-3-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index ca1f2114e6..d3faa9a84c 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -294,6 +294,10 @@ def _post_launch(self):
             self._qmp.accept()
 
     def _post_shutdown(self):
+        if self._qmp:
+            self._qmp.close()
+            self._qmp = None
+
         self._load_io_log()
 
         if self._qemu_log_file is not None:
@@ -366,8 +370,6 @@ def wait(self):
         Wait for the VM to power off
         """
         self._popen.wait()
-        if self._qmp:
-            self._qmp.close()
         self._post_shutdown()
 
     def shutdown(self, has_quit=False, hard=False):
@@ -388,7 +390,6 @@ def shutdown(self, has_quit=False, hard=False):
                 try:
                     if not has_quit:
                         self._qmp.cmd('quit')
-                    self._qmp.close()
                     self._popen.wait(timeout=3)
                 except:
                     self._popen.kill()
-- 
2.21.3


