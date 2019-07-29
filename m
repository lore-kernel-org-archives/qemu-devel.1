Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B521C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE52D21655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGS4tzm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE52D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Si-00056D-7l
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7PF-0006Vc-GD
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7PE-00070C-Iy
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:17:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7PE-0006zW-D7; Mon, 29 Jul 2019 11:17:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id f20so19193774pgj.0;
 Mon, 29 Jul 2019 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kq+GocMZNBzs7h+JrH4HUXS6sT3wW7TSwegih8ayQCc=;
 b=QGS4tzm7A9L671zmlDCqPUdFRUyjotBK5zxFxo2k3hRIu8U4DyIR/y2QC0Rbc41RaE
 RfGn74Mby75wt6zS0vfiZBHwFdPiiro7SNdwUH3sSNyx4lD0XhTQkyN+vPahoojQL2zJ
 rB4b+liAm32VlvWJzqoMx+CFEHC0+RDEpYHBdUoGOrK+N+U1nLipQXM7mUdSBn4H4YFl
 jZz6KSL/6H8CHb6UbgZalsjm+U7ynvKdcUkC4H3nTlssNnNp2nnVxWh4Oubpv1AuasAO
 02tC0X53YvtnkQwgrwuNZnrjudiF0ZHQnXsbYJx7/L1NXVXAAmQsL8Dm8YUQXZYLdCfB
 pSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kq+GocMZNBzs7h+JrH4HUXS6sT3wW7TSwegih8ayQCc=;
 b=fgL+59yNB0eYsSZcogdyW9rvQs/QlflRKgMLXWPtP6JkULxJGbltBp2hfheBMh4iBt
 1S4xTelZ5Htnv6e72Hm6yuyxs9tbGB5O7Pbbjp0QrUjkTDFVextwjTSCNihG36fQ/3tQ
 q3HIdE6JKFaNBRqOJf33+tppSpZ3C/KuchsbvUst6AvfA0xx/P2kH2wkMaC7tV15YKXy
 gFDIKY1c7QvkXO5VUuvDbFJBtrmqmFO53b+gUPIzGCMhTvBgVO3oMJ//5z/uHsbTnOjW
 uNUoxxQIOiL6OTY8znqJhqfVjktj9Horlw3bFbbzjKAPpymvnDl/lK1YT+TEUcuKi16t
 U7fg==
X-Gm-Message-State: APjAAAUY8W4RmtZ3VENuAIP4OGkBoDIOmZbnmN1qWXDQhSirxsnNBjHW
 O3EhXAJbx0qw2qlq+gjNJqKGCgXFUoKTbw==
X-Google-Smtp-Source: APXvYqwp2RZp0ZUUnZ07WpEyKOm5SgzAl0TdXKac4UI2ZNWa7xU7CUMtw2IvME9LRQy0BPEm73Aq1Q==
X-Received: by 2002:a63:1765:: with SMTP id 37mr36148266pgx.447.1564413463042; 
 Mon, 29 Jul 2019 08:17:43 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.17.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:17:42 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:38 +0530
Message-Id: <20190729151651.21306-3-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729151651.21306-1-mehta.aaru20@gmail.com>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v7 02/15] qapi/block-core: add option for
 io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only enumerates option for devices that support it. Since QAPI schema
supports io_uring, which is the actual name of the Linux API, it is
preferred over io-uring.

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..3dc93b483f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2792,11 +2792,13 @@
 #
 # @threads:     Use qemu's thread pool
 # @native:      Use native AIO backend (only Linux and Windows)
+# @io_uring:    Use linux io_uring (since 4.2)
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevAioOptions',
-  'data': [ 'threads', 'native' ] }
+  'data': [ 'threads', 'native',
+            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }
 
 ##
 # @BlockdevCacheOptions:
-- 
2.21.0


