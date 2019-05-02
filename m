Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8472C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792D82089E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uogPEuQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792D82089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6IK-0003YO-JB
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:38:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69i-0004ao-Au
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69Z-0002ZP-Cq
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69X-0000kq-Kb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id c12so1794156wrt.8
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=h06aW5JcW7mzXhhScMAGWKdRj/JzawqBM+CXGjhR2Fc=;
	b=uogPEuQfE/huP8I5yfka02P/hV4lHVpCBuvx63JKgqmA6ROcBwPDY1qsjmRj8rwxwv
	OfTKmelGa13jRlk94oraX3AOMdzoXUiKoK2UofMmYNJAn+awpMNGmRPCy23D3InTnTqJ
	CJSPW664IKjUezsszD5k5Bm7IC6LtafWLCuYCa2J7YfKlROlj3yFwokneoIUOUBDX1n1
	2HlN1uBiaGxqL5iP2f8WTxb424RtAYATjQxtWuq2HPgal/ozLWn52tndVW1zgL4QQkeV
	rgQnBxgagAxT8evlevpH2qGnNeFDRsAlVZlZcUq/bA5KlMQPImR4RR0alOSn5X9ZR4Si
	CiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=h06aW5JcW7mzXhhScMAGWKdRj/JzawqBM+CXGjhR2Fc=;
	b=MMat8vsaDqUZR4/mPmQ4NkKCJo7VUwEXu2u7baVxCQ1S5jlUQCvCAnN2Vp6GHBjTNi
	pRRwa8ObhtpQVE069MRFYtZPePuQRHSC4WVEPiZFlQgcZlBaCiAlCxq0tDxCtQNeeuJR
	0gAN4jb7ZlgeBQ4kvHzKzZoPBkPwrTEUrV/m+/P3RGgJoN2KolratdZJwPmk/wvo3NM+
	8wAqfCONTfta96qBWo7pzk0IOF11amyEoJQQa6mkiSnPrizzJ/1TG/8/E4S0HxBbvD8A
	353sRsqc29WfYtsZAnpKcCzTgBk4q2Oy9wYsBpN+lJpkKcaycFKA3E3U/Cy5fSdUTMTe
	R4Vw==
X-Gm-Message-State: APjAAAXXBAJRER41cz+PjR2udOU+Sc6SERlRsKpt7rVNgKeGi0hm3LJ4
	0JvkrmAjUOh1Ohss/bfLjwM7ShJu
X-Google-Smtp-Source: APXvYqz7jAZX8WXJ835aIdOadtXzYwjuDcdR6dE8c9DVpIU4DDudFbLmaLWB4ux4EFOpL7y/I7Eaqw==
X-Received: by 2002:a5d:4b92:: with SMTP id b18mr1499061wrt.11.1556782054601; 
	Thu, 02 May 2019 00:27:34 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:34 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:38 +0300
Message-Id: <20190502072641.4667-25-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v8 24/27] gdbstub: Add another handler for
 setting qemu.sstep
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072638._zb0GT9c0IwdpCzjaB3jl0TKJns0z6vb9gDfP5GQi6E@z>

Follow GDB general query/set packet conventions, qemu.sstep can now
be set with the following command as well:
gdb> maint packet Qqemu.sstep:Value

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 6daf779af4..bceceeec57 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2260,6 +2260,12 @@ static GdbCmdParseEntry gdb_gen_set_table[] = {
         .cmd_startswith = 1,
         .schema = "l0"
     },
+    {
+        .handler = handle_set_qemu_sstep,
+        .cmd = "qemu.sstep:",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
 };
 
 static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
-- 
2.20.1


