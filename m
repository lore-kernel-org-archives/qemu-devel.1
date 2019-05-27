Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26BDC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E54A21721
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQuJlr3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E54A21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41689 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAfd-0001yE-CP
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:07:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAbw-0007bZ-3h
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAbv-0001YB-8C
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:00 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:37049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hVAbv-0001Xd-3S; Mon, 27 May 2019 04:03:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id a23so9138416pff.4;
	Mon, 27 May 2019 01:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=RQSGLuAPTqBgY+6tSr5KG+5jBdzMRsNl3Fb9Hoj28xg=;
	b=QQuJlr3ExTcROQnlJjQC16RXxnWMwDp6nSHjtiJd+2QdwAidySjBZpsQg8nJn3kP/Z
	q2Gme8d7CL8pveG8KYs/plMNh4CpYWXVd+z/ozm/8fexw0exgp+dlkNWBhmVFVyQwLlN
	++/h0SjtoKeC1EWXXWtWJblJYe9JVdrcphX3HSdeMmZpdWFJuPF5rR3P14d9csdHuxjv
	iBLOsrpRRIHk5x+ONc1txP2eKM8AQT89MfDV2TaKyDMSzB94K1fnMq3hZsjyOt/JlPxL
	0j7K55PLgtujCgmayZ3Mj1ugGRK5S5QmSNRSGsgK7EbzeJPzIdumyaX3Kiieevbd2uKJ
	y+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=RQSGLuAPTqBgY+6tSr5KG+5jBdzMRsNl3Fb9Hoj28xg=;
	b=Vc6SBKuXpyQhCntPyQVd7qzcpsisvZPP5v30J+c3ZxLQf5WbZvxQKGI5OuABeKEb2+
	hm1kPq/Oq8B+rGl4hE5eSlG21+vAX1H8E4xipzALBEA9NfPq4YhdOXVARtDKKaRmviuM
	0f68UQud3+LxBiLOYk83INNpGVbl6KiJRQym82p8snwhYVIkWqp6/+TzWZ/e846HF5HJ
	UZFuPbrDEhklQE1kr8EvfHaxNMLzBAgvIJ98M9zJbFm/nxaK1y/CdtIHDwfStz6h4jSB
	LcKrwe3pzCJVMFp6XyDv5z41PNyxznb+vMP6VAcnYbt5hh4TmAUdYib9jjnOSUNC23+e
	6png==
X-Gm-Message-State: APjAAAWWiLvve4fzD015kSr3qqqWbvNg1eG4+TIMFRtG3ryUFRgDACD4
	5KX3++jHLOlRWGgwUnE38H7JWWjPaW4daA==
X-Google-Smtp-Source: APXvYqydHjz5nZ6RqAli1KUFP1FchkUrvrrgAJLJVZUCUEeyl4/NvIiZ5nGVgVjnAt0SP20ExYLYrA==
X-Received: by 2002:a63:cc4e:: with SMTP id q14mr121609234pgi.84.1558944237556;
	Mon, 27 May 2019 01:03:57 -0700 (PDT)
Received: from localhost.localdomain ([120.57.119.140])
	by smtp.gmail.com with ESMTPSA id
	j5sm10030853pfa.15.2019.05.27.01.03.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 01:03:56 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 27 May 2019 13:33:21 +0530
Message-Id: <20190527080327.10780-3-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527080327.10780-1-mehta.aaru20@gmail.com>
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::431
Subject: [Qemu-devel] [PATCH v3 2/8] qapi/block-core: add option for io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 qapi/block-core.json | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..2773803890 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2776,11 +2776,13 @@
 #
 # @threads:     Use qemu's thread pool
 # @native:      Use native AIO backend (only Linux and Windows)
+# @io_uring:    Use linux io_uring (only Linux)
 #
-# Since: 2.9
+# Since: 2.9 @iouring Since: 4.1
 ##
 { 'enum': 'BlockdevAioOptions',
-  'data': [ 'threads', 'native' ] }
+  'data': [ 'threads', 'native',
+            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }
 
 ##
 # @BlockdevCacheOptions:
-- 
2.17.1


