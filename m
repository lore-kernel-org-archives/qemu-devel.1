Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C29C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437682082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eyRaLYBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437682082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhZK-0004zJ-CZ
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:38:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVA-00011h-3o
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhV9-0001IK-48
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:08 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhV5-0001FC-1S
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:05 -0400
Received: by mail-pl1-x643.google.com with SMTP id a5so1769815pls.12
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=urHRlG6kBlVfKAPWfqk7nsWOPo9eNvxapFP6SXeaD3k=;
	b=eyRaLYBIqxXVktyb+HTVaFGi3HFWopEiTqw34tPLVew1SYdIBU21YUVtW/WEm9ut+B
	IhBNdLflZ7JCc/fEIuhZeMkZaOR3xYlMf4pzAea064cyJHX52nU29X4qJ0SfKmNsRBNY
	4NMXrhVuTeGaQqctYnS9nUdcpFsffTKt7eUfgksBdv4FgYgvQoiZSHNJAE5wzJF8ldUi
	XQQILtxuLr3gnvwpr9xdp+2hY0T41/U7lJnC8aOZR6Th+Ew55T7+bDzPWe0OxpI1zNLp
	NFXQFGSZ9rt0GwSpz0430BPaIcnN64yQncwg/z+sfKWc5Pepy95baFCb4fm5ccPljbz/
	nqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=urHRlG6kBlVfKAPWfqk7nsWOPo9eNvxapFP6SXeaD3k=;
	b=I1IOskZRvtXoNPDC3Zvz4qNlkNUTwQb7M4uNKUknCGaeIWq3i62SdJgBwa9zsYEfkU
	/VCVldbq+RtOdRPhBTyOKNiPZESqkVOc9toQ/3E8snPaL7Hej6pfhlTqWKn+jOP8Uxuu
	bnVzK3VZJq04fTTmX3QEgNhpQ/QwWrZeg6hIh3izwpeUcYuszZ4kGP4Z1wugSpcZLnoB
	8gY/Bvu1xQsLTIznPAmLkzzIDLOGfJHCGApfEd7jOyngHocme+jwFtMCds287TG5883K
	YMxXhOv8YFao9XSenwy9seHocFLFzVtpGLKPr16uTMezsgJlQPlntUuirbFTO8NgYzeD
	mK0g==
X-Gm-Message-State: APjAAAVX52uATh6ztZDbXAs3QAvk7feqBjC3+nk27iv8lkalPg4EB6Hx
	c+nAk7B4bMw9Ya2N9yAt7Xq5oIpWADo=
X-Google-Smtp-Source: APXvYqykmfos0aQervz+k3Tp9yWC6q2mHow0P7dJhR1NExhbCiVWLsHoxH/0QSC8ntdBJ+AGpscGUQ==
X-Received: by 2002:a17:902:bd92:: with SMTP id
	q18mr33896137pls.136.1557164041616; 
	Mon, 06 May 2019 10:34:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:34 -0700
Message-Id: <20190506173353.32206-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v4 05/24] crypto: Use O_CLOEXEC in
 qcrypto_random_init
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoids leaking the /dev/urandom fd into any child processes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/random-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index 260b64564d..6df40744c7 100644
--- a/crypto/random-platform.c
+++ b/crypto/random-platform.c
@@ -42,9 +42,9 @@ int qcrypto_random_init(Error **errp)
 #else
     /* TBD perhaps also add support for BSD getentropy / Linux
      * getrandom syscalls directly */
-    fd = open("/dev/urandom", O_RDONLY);
+    fd = open("/dev/urandom", O_RDONLY | O_CLOEXEC);
     if (fd == -1 && errno == ENOENT) {
-        fd = open("/dev/random", O_RDONLY);
+        fd = open("/dev/random", O_RDONLY | O_CLOEXEC);
     }
 
     if (fd < 0) {
-- 
2.17.1


