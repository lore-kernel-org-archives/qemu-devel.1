Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25EDC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEA72070E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSCzFxGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEA72070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXTR-0001VR-6X
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4k-00032Y-Oy
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4j-0004nK-Nq
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:02 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:41661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4j-0004ms-Jp; Mon, 06 Jan 2020 13:26:01 -0500
Received: by mail-qv1-xf43.google.com with SMTP id x1so19420805qvr.8;
 Mon, 06 Jan 2020 10:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AeTlk6Mv4Sdw9TGJE5bJAMzPZ3CIV82gaf3D39HkxpY=;
 b=mSCzFxGkDvJH0IMXM8h4ve+2MYWjYSUJ4vRU40x8Ls6nAraZaxAfEODkR5bkOFVIky
 i2+oZq3zbx0+xFWnHOovK57omXi1H9FEOvBGxcw8rd3OcFn3bA32YjdviqLJ4v9Bgmyl
 dp8nN/Tw8//TvPwC6hY8LRh0Agag5ip8u3PG2TVYhHDVLHTmR+a0jFEYsvQXnQZBtvTr
 dm1nES3c0C1Cc0ccjxtbW2ir23ihHJQZYBys26BR0Pp44yuc7/11mIyFtGSrNba3uXvs
 xss3gMUzvuCYHgEbqpjVoLxv98zEt4z+0ipt7gs/el1J1zLTe3U6LoMIMzkgdMSeUlwh
 1QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AeTlk6Mv4Sdw9TGJE5bJAMzPZ3CIV82gaf3D39HkxpY=;
 b=r6Xj9zn7atMoWwNG35F9wMUiE9IfW/LLRASuZC/gErFmTlX++o+YbaNvGlj0Daw8nf
 BtBI5LHAxHK1U1EaNUwOiiaMr7kkmGQkHFBi4KdGNf3/MXW2zTzTDfY9SY0+IFDBk77B
 1tOBT/J23XEn4RfpxKaHZaVl3WeIAN7WEuy0X4kn/PqcYhYImSzETZwbNCWIVncdBj7K
 7tmxMeVpSUu3PRHo3wpiEJ+wk4MILeF9Y2mHVKDL10QD6D3M6dqmZcnt+DSFlEaFyay9
 6vJtlaORC/3dk6AmiTRs3PgoNjHtPpcNDRCjqtBnFg/4oVIgOh7K2D/3hyC88ySGPJ9J
 E2Sg==
X-Gm-Message-State: APjAAAVTRygo0VaZm8foCxb0pCh+rVr8OrBrbo6BMayWgzmd8EJy3Orc
 vX5r/TUfYSkQ9qGj/Uf5vRhU1god
X-Google-Smtp-Source: APXvYqydM2v6y698cHrh6e48dCGfdy3XG0GFCyDtLkp+J84lN4ZngHlwI7Wr28Og/NNJ84T9Q4lJEA==
X-Received: by 2002:a05:6214:1150:: with SMTP id
 b16mr81204786qvt.71.1578335161010; 
 Mon, 06 Jan 2020 10:26:01 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:00 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 38/59] s390x/sclp.c: remove unneeded label in
 sclp_service_call()
Date: Mon,  6 Jan 2020 15:24:04 -0300
Message-Id: <20200106182425.20312-39-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' label can be replaced by 'return' with the appropriate
value. The 'r' integer, which is used solely to set the
return value for this label, can also be removed.

CC: Cornelia Huck <cohuck@redhat.com>
CC: Halil Pasic <pasic@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/s390x/sclp.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index f57ce7b739..af0bfbc2ec 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -197,24 +197,20 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
 {
     SCLPDevice *sclp = get_sclp_device();
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
-    int r = 0;
     SCCB work_sccb;
 
     hwaddr sccb_len = sizeof(SCCB);
 
     /* first some basic checks on program checks */
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        r = -PGM_PRIVILEGED;
-        goto out;
+        return -PGM_PRIVILEGED;
     }
     if (cpu_physical_memory_is_io(sccb)) {
-        r = -PGM_ADDRESSING;
-        goto out;
+        return -PGM_ADDRESSING;
     }
     if ((sccb & ~0x1fffUL) == 0 || (sccb & ~0x1fffUL) == env->psa
         || (sccb & ~0x7ffffff8UL) != 0) {
-        r = -PGM_SPECIFICATION;
-        goto out;
+        return -PGM_SPECIFICATION;
     }
 
     /*
@@ -226,8 +222,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
 
     /* Valid sccb sizes */
     if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
-        r = -PGM_SPECIFICATION;
-        goto out;
+        return -PGM_SPECIFICATION;
     }
 
     switch (code & SCLP_CMD_CODE_MASK) {
@@ -257,8 +252,7 @@ out_write:
 
     sclp_c->service_interrupt(sclp, sccb);
 
-out:
-    return r;
+    return 0;
 }
 
 static void service_interrupt(SCLPDevice *sclp, uint32_t sccb)
-- 
2.24.1


