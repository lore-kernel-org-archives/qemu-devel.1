Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF694C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962EF22CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxK0qYpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962EF22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SPn-0000C9-RW
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFl-0002Me-Sd
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFk-00036p-Py
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:25 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SFk-00035l-KG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:24 -0400
Received: by mail-pl1-x644.google.com with SMTP id c2so1476557plz.13
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VSah+oM9RiageqBaU4bntxxkoSq+7j13ju7uvawPaYw=;
 b=cxK0qYpxhVFEIr3iJOeBsebgNoRENnJZ9wyH9UIVMC2lCZ/I+kSiIww/VVqju75fnH
 EZ1RZCHHotNI6oFTBYjZ31wUhAEzJ7iyhGiN1VLZD+x0X+Wz6r3vpWd9GjKGxqQIfRlW
 riN5RJ/S/H6DgLk6y4mSwrK+qW94ybpwXgy2hH/m8IJ7l85MIEJcFVXsg/3Va9nTj9m2
 Wu+eYr+IygnNZ6tWUJ0o6dHaAnlxLUxUnPaFAnNU+DAkaun3WuI4seETXAb/vkkFvGZZ
 l3/qflUXiautydVS2eWbAKsmF1VwFhcbU+tVFqZcKpEbyFrvz4pQaLiBc99S9WUF1aB2
 xotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VSah+oM9RiageqBaU4bntxxkoSq+7j13ju7uvawPaYw=;
 b=LlBgrp/CJhcHM8BEBwS2D+TZpqzyYG6DyuMN0gF5UTAOFEjBmcf98sZxfNVddQA6CG
 XmChNpi4VhXGW2bqPdeo7z5ke9tv3sAkvX4mepwHSyaq5pvBjuUtYluXOP0QtqEHzm97
 i6VmFvH2/gx7tg6FUysYUvUyCBrp0IPR2J8tzJ/IUky1jKJhmJqB31rVkyxMhdhQzMos
 +eZ6rUYk31BLLbtEEIBOd1n6GCEh8m7dlS6jm7tQKt0MqhuG9ehjn23tZJLZWJQ2wnqI
 qkYCit+JfWFzP+CEekpwlZtMUaPtxPbsz91JJGxDI+v0sg0yXepTNn3Z8ScGG3zXE6qq
 CJ/g==
X-Gm-Message-State: APjAAAUdXJNpCGHHnOdmQ96EACctJvNY0ww+eeJKalbhcOMgs2gakbXx
 CalTFlC5e8STDRsztPKgcDVXSsRXv5o=
X-Google-Smtp-Source: APXvYqwNFKA7O5Bj0JYZQ1JlDWGFrP+m2fAyT81upFpXoepkGT600b3TxFdCF1HXav+zULKJerWfpA==
X-Received: by 2002:a17:902:20c2:: with SMTP id
 v2mr31397856plg.209.1566400223573; 
 Wed, 21 Aug 2019 08:10:23 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:23 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:07 +1000
Message-Id: <9d992aa745964bd151b0e314a2e380b6612a090f.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v8 13/21] target/mips: Hard code size with
 MO_{8|16|32|64}
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Tony Nguyen <tony.nguyen.git@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Temporarily no-op size_memop was introduced to aid the conversion of
memory_region_dispatch_{read|write} operand "unsigned size" into
"MemOp op".

Now size_memop is implemented, again hard coded size but with
MO_{8|16|32|64}. This is more expressive and avoids size_memop calls.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 1f0e88364a..34bcc8d884 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -4742,11 +4742,11 @@ void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
     if (op == 9) {
         /* Index Store Tag */
         memory_region_dispatch_write(env->itc_tag, index, env->CP0_TagLo,
-                                     size_memop(8), MEMTXATTRS_UNSPECIFIED);
+                                     MO_64, MEMTXATTRS_UNSPECIFIED);
     } else if (op == 5) {
         /* Index Load Tag */
         memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
-                                    size_memop(8), MEMTXATTRS_UNSPECIFIED);
+                                    MO_64, MEMTXATTRS_UNSPECIFIED);
     }
 #endif
 }
-- 
2.23.0


