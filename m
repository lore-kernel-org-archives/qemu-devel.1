Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E16C46460
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D0A217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6HYYZDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D0A217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9fl-0001DA-2o
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:51:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MX-0007Ud-LK
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MW-000690-Pn
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:13 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MW-00068j-Jt
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:12 -0400
Received: by mail-pf1-x441.google.com with SMTP id t87so3591573pfa.2
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=V+gOkII+X0gMY90Is6MzBXqbkDPGTCzHgSN8abaUrU8=;
	b=h6HYYZDwby2Pv5b/wP2xRw4m1mLD22hQYqzLyORS/nCjrEUlf246slfhBflJpEF7nr
	jPNkP0YJmfO7j7a0EiDGVc91JuLdDrdkzJlkuYiI6ntDcDk00L9d9Vj9okUXvlpiuT4+
	qQY/BEp8Ij6EZIUGBrMbBhIGsYrzgDOTdoq9fJSlG9ybNZRvlqnYmDwCBOG45OPHvepP
	oJRD4z+klAmTUe0pweO+so1/0c3U6yFZbAo1VtFC2/DyFMpB5/f17ZdL4xj7xis/4B6+
	wi5xBIiE1tAULX18AdDiT4uzaXAJzmMU3i0WR24YLnCZ+x16j1PkCXzU8g8MuqAZ7EiJ
	YNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=V+gOkII+X0gMY90Is6MzBXqbkDPGTCzHgSN8abaUrU8=;
	b=HwRILyFyT8lMhBisgbodvPmdJuj12WldkYIPdZbVxIvzFabeiLCuC8jG8EZTd/AKnu
	tLsocysjQfwXjuxO820lxa35v2wtWaYZ6DGbr4aVsCuTl46KJPGDLKo4pUrxYhfIIWjD
	/rzdfgSuHvubTSWwZ7nxa4ZvueeSqKs6QSeUQMiBqPqrZHW72XZZrDBxDtykHO/YGu6y
	UzHZLdxKUeAB30sSe6Sow9tAmqfNvov/gEnjzynK6Sr3r9+nn9JYgdBDyHKpVlUh3Dod
	MxOi2CwQ86lax6ry9zo3q0UYunCj4cs57vIvK7EbiGaNwDs6Q+5nbOmqdJ3SWVyhLEhI
	VdtA==
X-Gm-Message-State: APjAAAVmt39VYtpLalBOKPLMqWfL1/dzKb1YIr6paLgx2ZEjuJEqpsRl
	qDyu+QmkFtSB/q3WFv4d9Wip+adbjTE=
X-Google-Smtp-Source: APXvYqzTXSeCTiTLKgTzJ/K0sajBUHCcQ+OniNy9BUZVzcrt6mvXqr5h7CwX/lbNBsaDg2UHNmOoGg==
X-Received: by 2002:a63:6a41:: with SMTP id f62mr15367573pgc.392.1557509471274;
	Fri, 10 May 2019 10:31:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.10 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:40 -0700
Message-Id: <20190510173049.28171-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v6 16/25] linux-user: Remove srand call
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

We no longer use rand() within linux-user.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index e455bff1b7..5d1c6a115b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -623,8 +623,6 @@ int main(int argc, char **argv, char **envp)
 
     cpu_model = NULL;
 
-    srand(time(NULL));
-
     qemu_add_opts(&qemu_trace_opts);
 
     optind = parse_args(argc, argv);
@@ -692,15 +690,6 @@ int main(int argc, char **argv, char **envp)
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
-            unsigned long long seed;
-
-            /* This will go away with the last user of rand(). */
-            if (parse_uint_full(seed_optarg, &seed, 0) != 0) {
-                fprintf(stderr, "Invalid seed number: %s\n", seed_optarg);
-                exit(EXIT_FAILURE);
-            }
-            srand(seed);
-
             qemu_guest_random_seed_main(seed_optarg, &err);
         } else {
             /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
-- 
2.17.1


