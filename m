Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF12C47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F0420862
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F0420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsR4-0000XK-18
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs5g-0005TG-5e
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs5e-0004U4-8B
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs5c-0004Te-PR
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:50 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F1F9B59455
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:59:47 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id 10so10685918qka.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t+/oBfHBgFe+XZkVKBg0QFeK0Xg3a4kGOrnxOCZxdy4=;
 b=PApBpjUON5bJuj8P+Jk39yq2yVhfNlVHCVSkc5m3IV9c/wK24npaQDbvCV9agNPs9c
 08rku4ihBehuZ9EZX8njUqt2Z/hWS6X4ig5JsIYQy5t9qx/TNeH9/E53l+yPjXwuzbHr
 fk1kv/cxBjZ+PUSKmv8DeXE0SEOKPpN2BXGw2TaBPW1uRhtmnWsO+qAfmUIH+36uhweC
 4no6eZ8/SQHQuqyK0YPdkmGbloxvHPLVb+ktUgbhPGqQdAGfTXuF0w8TNnnzZ3fJgPNx
 +mT0wKTGlg9n3HEQ9/go0/QgK3RYKPLn+Rz8NcSz5HYz9EVZVpS46qDvWEAVZYSrdlHW
 PXhg==
X-Gm-Message-State: APjAAAUP81N7Pj90TuXZmpFUYmaqWz+3y2D3Xh7to6cceAudHKDqjMgC
 L6Am4g/NNXhgtc0/q5rReE6ihkF+UlCxNz9OWm8N9ZGTcCB9ErlxDtWd8ug3MDIcZq15K/ybpic
 +1sKmy9Ccdup2IfA=
X-Received: by 2002:ac8:305d:: with SMTP id g29mr23117650qte.279.1570312786972; 
 Sat, 05 Oct 2019 14:59:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx8qdU0AmT6v9PjbSmxQKrkk8CYbjsaLFRnoe9FiaP2becPiDdpwThrxpsLRJWINGHjkyj45w==
X-Received: by 2002:ac8:305d:: with SMTP id g29mr23117636qte.279.1570312786807; 
 Sat, 05 Oct 2019 14:59:46 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 k2sm4272637qtm.42.2019.10.05.14.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:59:46 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:59:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/19] tests: allow empty expected files
Message-ID: <20191005215508.28754-14-mst@redhat.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

An empty expected file is a handy way to seed the files
without creating merge conflicts.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 9b3d8b0d1b..8b066cc8f9 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -334,7 +334,10 @@ try_again:
         g_assert(ret);
         g_assert_no_error(error);
         g_assert(exp_sdt.aml);
-        g_assert(exp_sdt.aml_len);
+        if (!exp_sdt.aml_len) {
+            fprintf(stderr, "Warning! zero length expected file '%s'\n",
+                    aml_file);
+        }
 
         g_array_append_val(exp_tables, exp_sdt);
     }
-- 
MST


