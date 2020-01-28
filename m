Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6825C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5C12173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpeRD4ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5C12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwV8V-0004NT-Oi
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3j-0005bn-Df
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3h-0007CS-KI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:53:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV3h-0007Ar-DF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:53:53 -0500
Received: by mail-wr1-x429.google.com with SMTP id t2so17091194wrr.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sk9WshqGTq9cCur9E6esTWtP0xlnXywDapbkjl0RGOM=;
 b=mpeRD4ckt/6RJnP2tbGwMRwQ7lJh1JU03w6mF9klXupWUQ4tCDU+0/Zkmc1o/d/ECf
 EfnYFNDesJmqoqAPXXKUL7tyYCpuUgTzdqNdKyS5i+y03iduHBZAz1xx3fym3TFL6JQx
 M+GSOIctafk8ajcKzNw78DsK6326n7x8OENY4kMtwdBVo/I/jcIPzMNJ9GyMzOA56zSn
 a8d6gqqc3KtECcwoOOICdvn5260RFEP8lo8G76ivzWuAdCUdY+10Z+zkuHWeELLaftFP
 fHqW4NghTLoKNeKpnRT98OT/8nk3+HGSx4KuQBRItXTt4hFAsprF5tAHOtI0uDmtG4Fk
 mjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Sk9WshqGTq9cCur9E6esTWtP0xlnXywDapbkjl0RGOM=;
 b=pFSJ6aYqTkgdjuUR2l8ihVZshJVBJaKvUStKa8RoJmvpGMax+IEPTpYOqcSpLs2bpA
 +pLNFs0Ikbp1FtmWa881jIctewlC7P7UWYfnx0qgevLl7QpVB44glEu6AePa5OSMaP6J
 eS8mhfiEGCxTePAY47U0Q7lLfVB7ylVHYIOoQHzI+gRpXROdZo9VsvAjlDzMrNM2ccCl
 s3JhKCsG+N9QUCalREivfdkr43S8VZDvjlGnm0LCS9NW/23UZz5dv1y7GUVWDLIYQYOE
 famrSZAkoM2I4OuAXixfRY8Z1/H462nMVvHkmSztZk/sfs1DTHKj3AsP4mffSN/8FwmF
 2sXw==
X-Gm-Message-State: APjAAAWtSTB8WGzFmGtlp1jr9OQH2R3t49BN/jLTAOsvS6NrR+a9YX5U
 hwi5GoqdMkkYVk/7aYGx2wvYhKH2
X-Google-Smtp-Source: APXvYqy/eu3LdShZuTouAs7feUOFAYCukvhhfJ06WGXExlVWP8Xk4UzcBfOC8Q5evWPo0YpAoHVDvA==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr29043012wro.51.1580234032259; 
 Tue, 28 Jan 2020 09:53:52 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:53:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 001/142] minikconf: accept alnum identifiers
Date: Tue, 28 Jan 2020 18:51:21 +0100
Message-Id: <20200128175342.9066-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 40ae1989e1..febd9a479f 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -645,7 +645,7 @@ class KconfigParser:
             self.cursor = self.src.find('\n', self.cursor)
             self.val = self.src[start:self.cursor]
             return TOK_SOURCE
-        elif self.tok.isalpha():
+        elif self.tok.isalnum():
             # identifier
             while self.src[self.cursor].isalnum() or self.src[self.cursor] == '_':
                 self.cursor += 1
-- 
2.21.0



