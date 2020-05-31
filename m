Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9481AC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CBD204EA
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWlqM6b9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CBD204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfSDV-0008VA-F8
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 13:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAK-0003c5-4h; Sun, 31 May 2020 13:54:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAJ-0007b5-FL; Sun, 31 May 2020 13:54:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id u13so8639648wml.1;
 Sun, 31 May 2020 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1hu7DwCrcdSlatzn9Imjz1Afklu0mU2pvXW+JIC/CUI=;
 b=mWlqM6b9/BHwoA0IIMk6EvG4IZKUZy+M481W1L5fMaOfUoAyf/oZyIEBcI0p/rJ2Pm
 T5O4FDD2RyR3+NG8/mMcWThSQLF4wc/XQ5gGD7cqZc14u5qfccO/MQbI6He6SE4qyIMI
 iv+XlwkMhYfWyV3uJYfbftwElcMfVdNhdhHEe6/fDglOPOJkl4T91adYLY7phf1lgO2T
 yJsEGJvdRYr6H/hPsVQyJpQI5Jm+1A7XORDd9kfbh/NO8xYkfz4XO1Q8z4v8CGBbN2zr
 3O+ckKK4GC5B+UpvXC2yK+K9Xximkm2CDxwE0QjBG4dTqV/Ucb7yfNbpwCgJEHXFXcn1
 hwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1hu7DwCrcdSlatzn9Imjz1Afklu0mU2pvXW+JIC/CUI=;
 b=N6U+bbW77VvrKRBOkH/w4JsagbY+L0HaLZ9CxwaAoGNHRc0IH7kjiCCyFLsCVseOLt
 BIEKvovbF9pwXAOF+sj4EhN4pj7cBZcUlAyTyFXx0j9lkvP2A8kiPDxCLfm3NmOPhCOx
 8LWkiOq+K+aDIwuHEYbRRjdJQ/DsNNigdnIlc/zElcOWuIJ5b6erG08+eoxJJ1RVLK+G
 Pdw5EppL2vUoQ9ytyyD5q2ZOyJey0ybEW3GvRoRzGBZ4ink+S/QMJ2RkEEH0zLjNqQuF
 mfCCwUp0sY327zRUPQ+okQ1q7Y7mMl3BgeI0gkZzCRHLiez1TDgURVCTXRIxfp6tGsHn
 VNJA==
X-Gm-Message-State: AOAM533VKbHUboMGaZn796sxEzxtOS39oEbHwl7nYvIiDV/ptTWk96s9
 GLRxrb+rHjS2MbDCukYsusG3TCQ2
X-Google-Smtp-Source: ABdhPJzz/ulACo/1WfFbWBit9hOLo0uQYfC6wcVx9x4bYnRdwzQ1IZ7kqd652hpHKAlYEM6mooyAWA==
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr18162355wmf.18.1590947669222; 
 Sun, 31 May 2020 10:54:29 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id z7sm17862531wrt.6.2020.05.31.10.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 10:54:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] target/s390x/mmu_helper: Use address_space_rw() in place
Date: Sun, 31 May 2020 19:54:20 +0200
Message-Id: <20200531175425.10329-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531175425.10329-1-f4bug@amsat.org>
References: <20200531175425.10329-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In an effort to remove the cpu_physical_memory_rw() API,
update s390_cpu_virt_mem_rw() to use a more recent
address_space_rw() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/s390x/mmu_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 7d9f3059cd..632e8a8af4 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -529,8 +529,10 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
             currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
-            cpu_physical_memory_rw(pages[i] | (laddr & ~TARGET_PAGE_MASK),
-                                   hostbuf, currlen, is_write);
+            address_space_rw(CPU(cpu)->as,
+                             pages[i] | (laddr & ~TARGET_PAGE_MASK),
+                             MEMTXATTRS_UNSPECIFIED,
+                             hostbuf, currlen, is_write);
             laddr += currlen;
             hostbuf += currlen;
             len -= currlen;
-- 
2.21.3


