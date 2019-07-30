Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCE7C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8972087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICKhoPl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8972087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsW7a-0006ez-1k
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW2C-0004LI-8g
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW2B-00006y-DX
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:35:36 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hsW2B-00006E-89; Tue, 30 Jul 2019 13:35:35 -0400
Received: by mail-pl1-x644.google.com with SMTP id c2so29140806plz.13;
 Tue, 30 Jul 2019 10:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2qHkahVEkN1zu8CSs6/qp7V0fV616Ybkp0QDQj4tHxQ=;
 b=ICKhoPl6wva4wEX+ZC6lpYQVYzWNtBkcJiH7g4h9MBHV7zku6Jf7mt4g/2YR9gwbse
 c2RNBRzcil/EhuAh11c12AhncRxNh6QxdPstU6B2Q8tTyOhbciD9inEfLSrjH1Ib0c24
 gK3zyadEhmtqCyKQsATpKC1ISsE99cmXpyZDC8e1f8GmfN8PXbYPjuMYBb0ftQyun3qG
 nTHBJYyE+9ylYdO73UKe8kyc7HE7MQ1OjZEWHs9M788xt6jLfQczTm3P4mG7XbcUI9fR
 gV/Hrj+YBrafMlLovLQYNEwx4BZwZimvr56WJqoXzgrla/FJe6qFxmW6FtkhhEyx2lUG
 qI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2qHkahVEkN1zu8CSs6/qp7V0fV616Ybkp0QDQj4tHxQ=;
 b=RIyDM9/itf1Dm5w7/41Mkxtk+olVJTpTgDee1XX+YBNYNSFQW0HiIn7JYBPNYHi6oB
 YCqnf7LOY2k9d2NF/ewYNOAkqwvygkTDmvizHc0WVSBJD6hdzPzcBNCCnQrSiaoKJPTS
 0+N3dyOpt2oNTuRw/XG5bIyW1w7wJhRHbqeUjFa9wQK96rwX6WWJgpqnNM6jPvAaUB01
 0Ldr83jwpWk+Lu0feWlg8gZgTsDPQLvnu/UQfEfirdVPSxiYQ5jSYS24grd0WNle8sat
 LTzSeRXdtktCUFa+eHXQdrlDSHepurw7Zg+G62dhrVbAgx9Jsa7xQQwS3WqYF3VIcJTB
 ubDw==
X-Gm-Message-State: APjAAAXWcApHke2/LKlbObRsOu/4dVeoEhCRWq1wEFFumGETxoHuRyHA
 M71ZG5cqpVngsrhjoexEvKdH32zv3KwbjA==
X-Google-Smtp-Source: APXvYqy6vkQKy+9TRU6BRA979Me7jvGwcqTxR+vGYSvPVHWVRy8qflztY91XnomdEGplkoJbQcazFw==
X-Received: by 2002:a17:902:e202:: with SMTP id
 ce2mr111842448plb.272.1564508132918; 
 Tue, 30 Jul 2019 10:35:32 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id q24sm59122895pjp.14.2019.07.30.10.35.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 10:35:32 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 23:04:28 +0530
Message-Id: <20190730173441.26486-4-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730173441.26486-1-mehta.aaru20@gmail.com>
References: <20190730173441.26486-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v8 03/16] block/block: add BDRV flag for
 io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 include/block/block.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/block/block.h b/include/block/block.h
index 50a07c1c33..e29baa172c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -121,6 +121,7 @@ typedef struct HDGeometry {
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
 #define BDRV_O_AUTO_RDONLY 0x20000 /* degrade to read-only if opening read-write fails */
+#define BDRV_O_IO_URING    0x40000 /* use io_uring instead of the thread pool */
 
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
-- 
2.21.0


