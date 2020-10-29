Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3485C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263B52076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo6hWyYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263B52076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYD6b-0003Tm-2m
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYD4p-0002Il-TV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:55:13 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:33382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYD4o-0008Mw-Dp
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:55:11 -0400
Received: by mail-ed1-x542.google.com with SMTP id v4so4186442edi.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IJFpktSa/8kby6D0fReWnEGX7kDurZe78cM6aB2YW5Y=;
 b=lo6hWyYwcbd9Oeguy6CSu6xXxX0+oAKQk0In/HQVIcNaTZ39nknFBvGjLgXKcx2MZ5
 9zbEu9jhihCZzzerqDIylMP6eYDtVGIGUor0AiygIdHclEFSjEmfm0Rb95YNJuMqRSMb
 /UDzk299VGNb5A321vBBZjUjOGyHxVGT7bUgUY4i0GkJjauQdcXpsG332NA67NmfFSvA
 OyAqp9zVcQ4XXiEVj+XuENRvT+Xahtow7NTyYV3BglrPFry+ll2WNDeFhsos3Vye5P8z
 rJ5UVnnos/K19EoPD93ys0B8iEb4ZyofTRmpboMo49+wrMwo2R96uTHTfYM20n7BNdRi
 pL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=IJFpktSa/8kby6D0fReWnEGX7kDurZe78cM6aB2YW5Y=;
 b=mxv5CNUPvEIpHAJWA0T9CztZisSlrKIZIDu/TIqWJc/QLljEw/UEARja3pVJiGwiyr
 0dQ6zjHTTBAB7AryhuzbBZAH05FJkkSyuluuHia7JC/V0HeoEHNx6OCGU4iKQk2Cc5k6
 PdlY25BXiwB+2W9qiSHzyIOENlsLSTfrffHMfONYxiX9ZWqb3eQ3VXecyIJba5f2bLQ/
 GXhFz6HhxbwLLS5BHxPQ7niCydgLd9yU7J83NKLpr1fvRFlMyDyM9Py66ZY3HXRlDQrm
 Y/+jE71k570YyqUCEVAr4ou17ZiM9Wb+Ifv9uc4F5ceBrLypx9kbSo8Ge+RvjBCaLoGG
 z3hA==
X-Gm-Message-State: AOAM531BcB/m+AHt3Ecn+CeCwNAeb7wd3A/Jx54EcKg7LNT84zCeCKgA
 DQ7QTiMLsMkaVkZj3fIYZlAOZaSWYXM=
X-Google-Smtp-Source: ABdhPJy3BhkoClbm4QX7Bpb5fIT1N6uHwI2iAIctmqJ4Rje6PbWo+HKB7+Egl96gJD86eGH+UeXXuw==
X-Received: by 2002:aa7:c2d8:: with SMTP id m24mr5724396edp.90.1603997708665; 
 Thu, 29 Oct 2020 11:55:08 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id x22sm1932435ejc.102.2020.10.29.11.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 11:55:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] util/cutils: Silent Coverity array overrun warning in
 freq_to_str()
Date: Thu, 29 Oct 2020 19:55:06 +0100
Message-Id: <20201029185506.1241912-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Luc Michel <luc@lmichel.fr>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The biggest input value freq_to_str() can accept is UINT64_MAX,
which is ~18.446 EHz, less than 1000 EHz.
Add an assertion to help Coverity.

This silents CID 1435957:  Memory - illegal accesses (OVERRUN):

>>> Overrunning array "suffixes" of 7 8-byte elements at element
    index 7 (byte offset 63) using index "idx" (which evaluates to 7).

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 util/cutils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/cutils.c b/util/cutils.c
index c395974fab4..69c0ad7f888 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -891,6 +891,7 @@ char *freq_to_str(uint64_t freq_hz)
     double freq = freq_hz;
     size_t idx = 0;
 
+    assert(freq <= UINT64_MAX); /* Max 64-bit value is less than 1000 EHz */
     while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes)) {
         freq /= 1000.0;
         idx++;
-- 
2.26.2


