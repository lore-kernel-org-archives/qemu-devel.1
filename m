Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600BEC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263212166E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cS6X8k+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263212166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd9G-0006T6-Cn
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:31:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvO-0002bJ-3q
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvN-0006yT-4p
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:18 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:44123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvM-0006xT-Sv
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:17 -0400
Received: by mail-pg1-x52b.google.com with SMTP id z16so34193pgv.11
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=snXBlb0VD87nnHn7Q6KPOfq6Oyu7S4mMYTFxn8359jU=;
	b=cS6X8k+9x3u+9JC1Vv7LBt4ObMwsyt+ocIB02CPrAa8lIfW1gFx31NoNe073nSOMkk
	lDKTF0GO9O40go6+yOrPeq6IF4owyojh8z30sH3PL7OkbR6mt4A1jJjbFOZ3o/0AfGZu
	fhSo2B/6SzEHTpzp8vGlgJyxhwYBq0uSDVhAhzj8xQekDxnoABXILS7NPXE2Chs0vLLh
	j4ZnmGvM7cvxZG3rAd0/yg9sjB4bn5Ao+NSODB5bCf/6VVvuA4pxytazfbZJg+k8CLua
	VXFMN16gHDSLWcISHyFY/Qvjlfq+vKS8AN0EwJ13KteoQlsVZM8bc2u9dxY36hoc0uVA
	4gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=snXBlb0VD87nnHn7Q6KPOfq6Oyu7S4mMYTFxn8359jU=;
	b=U/mfU7pqCgeWpsqWybxnyMyIyDUXLn5SxLR+KGy/hzHzdej44HSGHCnpIoH61akRBX
	PWseKd+On9AbuwFCjRYnNFf4n3BOmgjIccs4DdEKUswQ5JPPyTGk0ItCnlX74nV8cyT2
	MftUrlVR03RbRLXuuLoz7z/RcvBc7mGhBWggRFrFTIoLo4QBvTjzk9BTsqhd6CNIjs7N
	FYSXR31BJnmCayjuc0khDqh0bTE3Tmcao7QGemT6riS15xXR4eJGhUrwYARG03+lE3WV
	evZfVR1vgxWR6DN/G+VzxK0q/j7MGBaD//e52zWAHB5XufpfvBTkhyied26axMurPz8s
	80KQ==
X-Gm-Message-State: APjAAAVHb5iSCejfIl2PZ/t40OEHz4teqEZWR5b8tpIojL+L6Rat+Bxy
	n9jfS1gN+w3SJGJoDBWTAOtVugXNERg=
X-Google-Smtp-Source: APXvYqynfhoJ1mqsqinp8WK7UkdVMbBPwe8WbR0t0vTY1OvRVHR/Veg0Pa3c6uMvlLAZen23GGTR4A==
X-Received: by 2002:a63:3ece:: with SMTP id l197mr1249541pga.268.1557861435565;
	Tue, 14 May 2019 12:17:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:44 -0700
Message-Id: <20190514191653.31488-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52b
Subject: [Qemu-devel] [PATCH v7 15/24] linux-user: Remove srand call
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
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
index 4c72f07555..5792c40ace 100644
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
             qcrypto_random_init(&err);
-- 
2.17.1


