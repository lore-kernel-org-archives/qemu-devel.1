Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753CFC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431652087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6JMmOmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431652087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsW6n-0004rf-Jb
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35547)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW23-0003v5-VB
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW23-0008RS-3F
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:35:27 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hsW22-0008R6-TX; Tue, 30 Jul 2019 13:35:27 -0400
Received: by mail-pf1-x443.google.com with SMTP id p184so30199170pfp.7;
 Tue, 30 Jul 2019 10:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kq+GocMZNBzs7h+JrH4HUXS6sT3wW7TSwegih8ayQCc=;
 b=L6JMmOmR9adQM+7Yn8wBFur6/NdLwM2ssKsQlg9abh2H4LpAA39v/LQHqVtl6kgPHL
 z0q4Ao/x3LGnT9rSQxQMsMhpoQhkatpTXZfpnAVpVo2OIUTCIqTxZ3nipA+fpG2AP3MM
 A9aEPrr2EgUjIIDGdMCX46sq8nMt7pqjiuhHCEXSxBXsnSv/vDLTvg09K8t+wJJmwGRN
 XKj5mcDdbb85gYcbT9zQjM6mk4hbe8dCBHLSNBNBddYwybhArxmdctpI+b2XuuDoqIiB
 o2lIrRbCyyKkTN28y5MMbkYqqpo3sbVKxEGTVUamB4FNteFZJP3QDGN7nW+C50dSTkXP
 XkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kq+GocMZNBzs7h+JrH4HUXS6sT3wW7TSwegih8ayQCc=;
 b=S5d2x5/MBfm6gCwgkIvEYOyGhVkrW8Hb90aXMpS3LLK2czI/f4QywMXOo+yhkl9jFl
 fWi24wyFflz2HrnuvpwGkDzl2Wk5iG9RkegO7iIRNUQg6goW1OE7NUZreAkwAJCy0jME
 +CwxjNFIK+mA2Ur7b+7+c7Sp6PgD9pKlqaxd9i6EJmvl8GCgV60CPNa7eyWWKho5M1Iu
 9n8yt/Zb0bsztH+U8BSj0jXf5e/P5FZPfEL+QqytBDMNireRXvl+GakXL53tz6F3kU3P
 cEh41b9rAVoBjZitN3s2DPI+YizABTPvdKW8EhREwYjGxwwKqEZOcwba5CoB5hOGFzD1
 7eog==
X-Gm-Message-State: APjAAAUxXmcRGkXW4+cfDUorLXF+vfMsMYkoWCIW+gQ5QJHaj3vj+IhV
 UNkwctDAQYgtr2/QLvI9sGuMgsSTakbZPQ==
X-Google-Smtp-Source: APXvYqyD5buVWI7Vla9DLEAJ0o2XwD0UDQjch1i/L9sdecxMmPoNJuU4Lnek9aBcnfbKQjnSRXbufA==
X-Received: by 2002:a63:3148:: with SMTP id x69mr23346603pgx.300.1564508125119; 
 Tue, 30 Jul 2019 10:35:25 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id q24sm59122895pjp.14.2019.07.30.10.35.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 10:35:24 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 23:04:27 +0530
Message-Id: <20190730173441.26486-3-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730173441.26486-1-mehta.aaru20@gmail.com>
References: <20190730173441.26486-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v8 02/16] qapi/block-core: add option for
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
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


