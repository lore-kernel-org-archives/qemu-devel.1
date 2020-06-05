Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FA0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE51206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/8crOjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE51206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEjO-0001gY-Bk
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbV-0004Gy-FF
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbU-0004NJ-Gu
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id l26so8874635wme.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xoCfRO676iJlXHa8f30XQ+Y59nBqkcCwu8Qlid/6iiw=;
 b=j/8crOjbAYJvF8if18cVLtGYCN3EUH/i6YTemPmQOZdQ2FkOyflW1jywul1VMw54bv
 8r5rbsZ7pvG80D5hAVYNZ8wvQ/EClZkZukUm2x2TBvntAjqhxu6jTYZW9D4C4Yd8jIl7
 gXJaZtyYltxSYMtXHmwHY4FYE7HSZdRelth7/EEUCtQZEF0AkocIoZEoToosKj6Njqb/
 uJJzC2sTsnZjTJl6ws/WMbcOEdaNbVU7OqmzIauJovJStfNbwykEvyG6LGaeDsiAS86l
 CQOLoUlZf7JV0w2LgUArkpZnKK+ewLJRa8YtHSgTMOIkL3LhHGM925nGfOfn1sSaFbM8
 gjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xoCfRO676iJlXHa8f30XQ+Y59nBqkcCwu8Qlid/6iiw=;
 b=Hrl+dbez12CNGyBQkxRA8gLjTD5IVXHNoiIggNkLPkYL19x6+qYZBqRkLSNJx7lYW2
 MGabbugVTjfqncjqBDNOku/G/7b2Y/IP0Gfg+mKQ1xNXfsOr6mY8vHAumf8jm8Tbyvk1
 OaFf2np9s3ddIRwRyrlqvCX+JUUQNJK42tc3Zgd0AwtwYbmNx/HrfMaxK/QtXopM/Muo
 zwnQxAP+NCllzYFaDeQ9hOKleiJNIVS0B3ConMe5ZuyugYAG3595FHfJhUpT0xDO9h48
 h0xcX6hZHWRSQHcWyxmGe2tl/5RuK/knorp4atLHTWriquDCUHClecdd3u+oDh64Cjhi
 9X2g==
X-Gm-Message-State: AOAM530tc+fp4Yab7fHOx3hgo6JRKBEfAGkQ299debY7SPqdDkQGCjAD
 5W2ZuXL5410djau54qSEcm2yiA==
X-Google-Smtp-Source: ABdhPJw682UDpFSNvoQUWK+sWFBr2n6zdQ//fRQ+RJoHm0t2GfI/6HJOTVsdegibjtDndo+ayKoH5A==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr3311934wmi.175.1591372195100; 
 Fri, 05 Jun 2020 08:49:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t14sm13744176wrb.94.2020.06.05.08.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:49:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A0DB1FF9A;
 Fri,  5 Jun 2020 16:49:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 11/14] linux-user: provide fallback pgd_find_hole for bare
 chroots
Date: Fri,  5 Jun 2020 16:49:26 +0100
Message-Id: <20200605154929.26910-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
References: <20200605154929.26910-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running QEMU out of a chroot environment we may not have access
to /proc/self/maps. As there is no other "official" way to introspect
our memory map we need to fall back to the original technique of
repeatedly trying to mmap an address range until we find one that
works.

Fortunately it's not quite as ugly as the original code given we
already re-factored the complications of dealing with the
ARM_COMMPAGE. We do make an attempt to skip over brk() which is about
the only concrete piece of information we have about the address map
at this moment.

Fixes: ee9474303
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200527100546.29297-2-alex.bennee@linaro.org>

---
v3
  - skip to brk if we get there
  - round up early
---
 linux-user/elfload.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ebc663ea0b3..475d243f3bd 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2101,6 +2101,50 @@ static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
     }
 }
 
+/**
+ * pgd_find_hole_fallback: potential mmap address
+ * @guest_size: size of available space
+ * @brk: location of break
+ * @align: memory alignment
+ *
+ * This is a fallback method for finding a hole in the host address
+ * space if we don't have the benefit of being able to access
+ * /proc/self/map. It can potentially take a very long time as we can
+ * only dumbly iterate up the host address space seeing if the
+ * allocation would work.
+ */
+static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk, long align)
+{
+    uintptr_t base;
+
+    /* Start (aligned) at the bottom and work our way up */
+    base = ROUND_UP(mmap_min_addr, align);
+
+    while (true) {
+        uintptr_t align_start, end;
+        align_start = ROUND_UP(base, align);
+        end = align_start + guest_size;
+
+        /* if brk is anywhere in the range give ourselves some room to grow. */
+        if (align_start <= brk && brk < end) {
+            base = brk + (16 * MiB);
+            continue;
+        } else if (align_start + guest_size < align_start) {
+            /* we have run out of space */
+            return -1;
+        } else {
+            int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE | MAP_FIXED;
+            void * mmap_start = mmap((void *) align_start, guest_size,
+                                     PROT_NONE, flags, -1, 0);
+            if (mmap_start != MAP_FAILED) {
+                munmap((void *) align_start, guest_size);
+                return (uintptr_t) mmap_start;
+            }
+            base += qemu_host_page_size;
+        }
+    }
+}
+
 /* Return value for guest_base, or -1 if no hole found. */
 static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
                                long align)
@@ -2116,6 +2160,10 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
     /* Read brk after we've read the maps, which will malloc. */
     brk = (uintptr_t)sbrk(0);
 
+    if (!maps) {
+        return pgd_find_hole_fallback(guest_size, brk, align);
+    }
+
     /* The first hole is before the first map entry. */
     this_start = mmap_min_addr;
 
-- 
2.20.1


