Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21879CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECB3206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b70XKS5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECB3206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0dl-0000pz-Q6
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tk-00057E-Eg
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tj-0001eY-2r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:12 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829]:36643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0Ti-0001eJ-Ur
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:11 -0400
Received: by mail-qt1-x829.google.com with SMTP id d17so3500045qto.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zTGJ/47FixBiMzQIk/MTjp8v2EMW7WdPBbVxHhyIgm0=;
 b=b70XKS5B7blG/ipqe8mx8ask2rtuYY3805T7kOBgKQmAsj7sHmTDmup0ViTMzpV+/I
 F9pppUcv/+jgdZnEljpMZIyfkrSr+VCtGZdm3xcv4Ep+h0xrV/SOp7uEeFf5XADUe+nk
 IkBPFPWc8a9+F9jSo6a2nb1RfioIz40lLzAeN1AkOZCJVRQy7jqK8feYjtNf/a3ToxtD
 EUN/iDvQiG4iWHNVcffuckwwNcrlQfGC53dy5qgr9bZZKQErR965WVVuWTaibjVZIjMA
 siBa4bTDqcmCM6KKny0qBuBYiee0JVWYYcejKueUwfm+tAkZFyrfmivX9568h88/lW/H
 Phvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zTGJ/47FixBiMzQIk/MTjp8v2EMW7WdPBbVxHhyIgm0=;
 b=k6TM5LGxhGF6KgwtdtQ1gJtptTGQVbVq/hYjyQ/71KmiWUKXB6MEpkROMI4QXD6IA+
 gBwvCrn7HWiAIvpAo5sEDZzrI9A7wM8Vgh5K7pYEahwUPe5Lh5LxKh4s2wifVTbKj3/u
 PsPIJcAVe2WiqKcTU8msfMzjpb1jYj4xo1zlPe2n36BS2GuR79l4xOMzhlu8GOL64gtK
 5r7+BqjpXl2hppux6bt9EE1YK3UXJhD3enXa2BAvvhAEu/BAM9+5+/j8+xPtejl1Y/Ck
 eO7+7uO8seygMZC7yCmqXbo5j2Rzx3ATzTHVBVIh72PkcGnTK38c8pUpk4xYAsLeuo9h
 YFLQ==
X-Gm-Message-State: APjAAAVkuufX7Hhq1tqJ7D4fFovdh8Xg+qaWrJpYZEfTd6sdfipN06bU
 QE/gmqPqyUnvwPqsQ8DbznJyctPP9tw=
X-Google-Smtp-Source: APXvYqy8mSN8mI2hxxgW36EsBgMu4/R+7GKx1E0cQsWbiPjghGoKKVNw6DGv0sC2ZJc5PJNxdqnv0w==
X-Received: by 2002:ac8:75c6:: with SMTP id z6mr3353923qtq.165.1572013330033; 
 Fri, 25 Oct 2019 07:22:10 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] exec: Restrict TARGET_PAGE_BITS_VARY assert to
 CONFIG_DEBUG_TCG
Date: Fri, 25 Oct 2019 10:21:54 -0400
Message-Id: <20191025142159.12459-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::829
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reduces the size of a release build by about 10k.
Noticably, within the tlb miss helpers.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 76515dc8d9..d3e4660d50 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -219,7 +219,11 @@ extern const TargetPageBits target_page;
 #else
 extern TargetPageBits target_page;
 # endif
-#define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
+# ifdef CONFIG_DEBUG_TCG
+#  define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
+# else
+#  define TARGET_PAGE_BITS target_page.bits
+# endif
 #else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 #endif
-- 
2.17.1


