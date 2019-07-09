Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D55C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D293214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zud4XPcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D293214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkmKW-00088u-IO
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43403)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJA-0006qC-Mw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJ8-0001mu-Ng
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:08 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkmJ8-0001mR-9q
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:06 -0400
Received: by mail-io1-xd42.google.com with SMTP id q22so19834010iog.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pFoay7GNwEUZQB8Jr0UsvPyxNWVYPlqTjcJEEwVExaY=;
 b=zud4XPcZjkg3qLwJfacPY/UrNy72sXWazemnvyWdT7kcJwisiQhcP9GCwnaLfa1KUV
 jQYBNRfykwriAewJCJ4CF9x0Ip3rIUioQQkLcmgnW3q5jzs+Gt8tPDruYFuegUstpxq5
 ZmjM+SO9CPWFljrBCjzn1U1wi7HLy8xJIuHIS7bj02n8zPIUeCUCS4EcfGb5WbguyuK9
 pU4aIMEJMGLDqFtUgXeiV904DXy1zJj27XaX1VhtQXDw+eCIzpae1uJ1YuD5Ny2PBJJO
 bD5AGjPAKUO2eog2p4aGd5dIEp0c7N3DuEBq8GwvNB82f40UIfHhSrvnJ5NIRLWj6V4P
 vqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pFoay7GNwEUZQB8Jr0UsvPyxNWVYPlqTjcJEEwVExaY=;
 b=crmD3IKV29Tcd20lNIPntl5PJzUqKz5Fo5rthNfNyE/eK6eCDH3hBXg9VYcPKg5zPv
 Kxt+3zy7AwdcQbXTixtjm4R9/0sVkJzx1nP+mJf3YHSxX8hAnAZ6D4rOVfXlRrx7rirO
 jUBrxAS2KZm9r8RJ/FsT5hAP4pV/rrFBKe9c61PgNGyn7udg6kGL4fe/7h7UgG5RjQpY
 DXDRqjzTMd0bCfzZ3OjS9N/2OIOmyEcxr5RqzzP9KXvtRHYktzDlR9oYjxZ2xl+BYPYz
 o1neggBoB2rkVBMXipboM5ZngKlTD5K/6Hra53n5Zef/XfHwqpjRpl8VioLTJXHPi5Od
 NBLw==
X-Gm-Message-State: APjAAAV7h70RlMkZ0zc4W4s7N0Kas5aztG7CaSPeJTh7IDhTr6K4I//x
 9iXlCUrS1Ype9FFa/lexALsdbVJmjO8=
X-Google-Smtp-Source: APXvYqyjTO5GWURhixPHPpvBaQtQxahmGq49vF1YXy1nLZCxGxWI/mvndgysDuoZlhxu7t9fSiMcuw==
X-Received: by 2002:a02:c549:: with SMTP id g9mr18876778jaj.14.1562664065166; 
 Tue, 09 Jul 2019 02:21:05 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id c17sm17613817ioo.82.2019.07.09.02.21.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 02:21:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 11:20:45 +0200
Message-Id: <20190709092049.13771-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709092049.13771-1-richard.henderson@linaro.org>
References: <20190709092049.13771-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: [Qemu-devel] [PATCH 1/5] include/qemu/atomic.h: Add signal_barrier
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have some potential race conditions vs our user-exec signal
handler that will be solved with this barrier.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/atomic.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index a6ac188188..f9cd24c899 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -88,6 +88,13 @@
 #define smp_read_barrier_depends()   barrier()
 #endif
 
+/*
+ * A signal barrier forces all pending local memory ops to be observed before
+ * a SIGSEGV is delivered to the *same* thread.  In practice this is exactly
+ * the same as barrier(), but since we have the correct builtin, use it.
+ */
+#define signal_barrier()    __atomic_signal_fence(__ATOMIC_SEQ_CST)
+
 /* Sanity check that the size of an atomic operation isn't "overly large".
  * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
  * want to use them because we ought not need them, and this lets us do a
@@ -308,6 +315,10 @@
 #define smp_read_barrier_depends()   barrier()
 #endif
 
+#ifndef signal_barrier
+#define signal_barrier()    barrier()
+#endif
+
 /* These will only be atomic if the processor does the fetch or store
  * in a single issue memory operation
  */
-- 
2.17.1


