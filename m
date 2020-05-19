Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4BAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0611A206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvZW3FyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0611A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb7Qy-0001qL-6H
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb7Q4-0000G4-8O
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:56:52 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb7Q3-0000Da-G6
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:56:51 -0400
Received: by mail-pg1-x541.google.com with SMTP id c75so261334pga.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V5c+xkhtSjo8Q7kdxtbkQlkla+/4Upk1eGz1d53+Rt4=;
 b=JvZW3FyZ3JI2A6iARUSWKdCNRF+Pwv+2xbGzaUu/ZvpR+7dXqR7sUk7IKICF5pNyoH
 unAyMqxlzmUPfa1/8wsyTEyi6oT0eCK02WBYCtrVCpzR7N+n7LyzjsSMttgLR1vY3DpH
 lrIC+tTM5SbJUWXyO0/6y21i7+FbmqM4wSiht1dj5kMvCus6/ye049Ig2ABUJbl0Iiue
 +AaKY306C6cUyAea9PQWSaM1eqgnTmshepmk0+p9iFnmn0MBnYhtJYd1n6CgWp+N6jKD
 IT71ppkFjkzV2LD4ipD+zRXH4WkWqiifkqoiNuLKy1paEiBHWdtYzYvLQ7l8rtSdNbcy
 6q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V5c+xkhtSjo8Q7kdxtbkQlkla+/4Upk1eGz1d53+Rt4=;
 b=FAZJ8CtPXnIFcMjllih7lovxNnTHTQ/o60EPcR2XOjWX6GhFEmfAiM3AV0D9JPZVZp
 TC5514wmJFuQd2eo3dT5a2XZ3miaAPdivNMUBadq8S7EpiIuMai2AeLy/AJAc2sIuk++
 /Nj6vM9VsorigZGV6V4OFIvaHiW/Osba4WnH6LlzaMzMi9zJpgpdT+cIHOAumY4wJSsr
 dXNn0bUeaBE7OomVsQdgSqp4sAJzwBqP2VUr6rA2h27TzCefkJZr9hDjf6WxpERej7ha
 +89C4I17JAOSyBL8pnIwbhAyCDMgtU6PwoOoiNuHnnHoOEPPSOVSRv9COOQ8AIGAHV7N
 dotw==
X-Gm-Message-State: AOAM533HFrMF3Z5Jtw6MHH20GCt2UdMztfnuQCgMLFlhTs4Od94C+AS+
 5H7dEEzvynoXFkHK1pzaMHbndxSO4ic=
X-Google-Smtp-Source: ABdhPJzyJwwqsKpWQ1NrHKlYcD0jsatGZByQzmaWUkJtg15aGvwFJI7PCGhxokS+ExAF+L5Q3kNwvw==
X-Received: by 2002:aa7:9515:: with SMTP id b21mr490260pfp.282.1589914609029; 
 Tue, 19 May 2020 11:56:49 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b5sm237658pju.50.2020.05.19.11.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:56:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] linux-user: Adjust guest page protection for the host
Date: Tue, 19 May 2020 11:56:45 -0700
Message-Id: <20200519185645.3915-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519185645.3915-1-richard.henderson@linaro.org>
References: <20200519185645.3915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Executable guest pages are never directly executed by
the host, but do need to be readable for translation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 36fd1e2250..84662c3311 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -76,8 +76,12 @@ static int validate_prot_to_pageflags(int *host_prot, int prot)
      * don't bother transforming guest bit to host bit.  Any other
      * target-specific prot bits will not be understood by the host
      * and will need to be encoded into page_flags for qemu emulation.
+     *
+     * Pages that are executable by the guest will never be executed
+     * by the host, but the host will need to be able to read them.
      */
-    *host_prot = prot & (PROT_READ | PROT_WRITE | PROT_EXEC);
+    *host_prot = (prot & (PROT_READ | PROT_WRITE))
+               | (prot & PROT_EXEC ? PROT_READ : 0);
 
     return prot & ~valid ? 0 : page_flags;
 }
-- 
2.20.1


