Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5098CC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2274E2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3XXvdHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2274E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60082 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhiN-0004q1-Av
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:47:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVK-0001Cy-Gr
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVI-0001R5-Mq
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:18 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:36747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVG-0001OO-Ph
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:16 -0400
Received: by mail-pg1-x534.google.com with SMTP id 85so6797515pgc.3
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=HH/L9mt26ecHO3SVHPhMrOoX9weRmZOQf65hlibBofo=;
	b=x3XXvdHgCk4PbDzhb99ICvZWxdjsdUNjfjS4HLi+oUzM+5m1Wz9OBa6cvk9mq117H8
	n4Lv98wqzKAEFhQGhNysVaOKZvBNAUNaOeVlWh/i8IGVEeWHt8Bb8osvCTy1N7CNvDDF
	iyvVHwvNtbmDQYuIUelAsdxG9c29VvOM+jxeT9BMnzcGs3s8FS9YBdrsUYiEcdULAOl3
	o+a+4MWmqoNJZP6zFrg/oMRanxDMEHQbdgTWpFI8XakuShJzyQ/p1dI9+YWfnlrcZwJk
	ud8eDaZn1Jse4HM5jRgYaVPiY5Mn8p2F2rPkukqMoubFksOSbHvxUwIHX+O6rCRLRM6K
	Dswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=HH/L9mt26ecHO3SVHPhMrOoX9weRmZOQf65hlibBofo=;
	b=pPgtOxq2tQWn7osvtT466FflQtZPn1A7V+AEJZ+M1ziVyNxlOHbShZY3dReWz2GH59
	F4KFMdrhhIxa4wcyL3hXHriuc6soqk8fBjC4dGZtLceWtcfgJBicgnnqbV0rDx9M1pqg
	e2GedNg6htA/0aFq4aE1Tl++W4qumE8PThBxuj/EkQtJYztQerXDoELBZCwX6DuPHmUc
	VGaRa13GuLfsj5/24IQ2XAjQ3Xh1YTDbe0gr5Q/8R1z+WxNCOJ9pg/pI3dGlj+eczm2k
	qN+hj/7k6EkbwLr06aYPnC7yfyuQL7lPlo743jlxHMEwPns1LnkqoyudSJLRWpMqkVjk
	BVWg==
X-Gm-Message-State: APjAAAUmXb3ySMMM8ce75UJ+WlahHt8KUOPDVwQ4Dr+CfBpSnBskv/kg
	/Zl1R38RgAwOWEeze3p2hMOJs2bHFjU=
X-Google-Smtp-Source: APXvYqyUQ04TYTkVEvfpjfS4bwVXNFWCaFQk94Qk7/8Nbuf3peYAGFpR/I5fga276x7+7dQhqTfC5w==
X-Received: by 2002:a65:6496:: with SMTP id e22mr33710784pgv.249.1557164051833;
	Mon, 06 May 2019 10:34:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:42 -0700
Message-Id: <20190506173353.32206-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::534
Subject: [Qemu-devel] [PATCH v4 13/24] linux-user: Call qcrypto_init if not
 using -seed
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 7dfb202e5d..e05aebe4e1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -39,6 +39,7 @@
 #include "trace/control.h"
 #include "target_elf.h"
 #include "cpu_loop-common.h"
+#include "crypto/init.h"
 
 char *exec_path;
 
@@ -688,8 +689,18 @@ int main(int argc, char **argv, char **envp)
     if (seed_optarg == NULL) {
         seed_optarg = getenv("QEMU_RAND_SEED");
     }
-    if (seed_optarg != NULL) {
-        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
+    {
+        Error *err = NULL;
+        if (seed_optarg != NULL) {
+            qemu_guest_random_seed_main(seed_optarg, &err);
+        } else {
+            /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
+            qcrypto_init(&err);
+        }
+        if (err) {
+            error_reportf_err(err, "cannot initialize crypto: ");
+            exit(1);
+        }
     }
 
     target_environ = envlist_to_environ(envlist, NULL);
-- 
2.17.1


