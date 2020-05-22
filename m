Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34CDC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C308E2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIBtX2Kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C308E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcASW-0002gS-Un
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKb-0003Jr-Bb
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:33 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKZ-0006GR-8s
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:32 -0400
Received: by mail-pg1-x543.google.com with SMTP id w20so179973pga.6
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sRbh5iLhIJgul14kcDJeTEj/XcHGk+PMKpVRoyVth+g=;
 b=PIBtX2KghCulSwqtE4E+2lMTUvnCtv2kFXVft1HT72ud2AiuiPjQeh+WoHEYj3wduP
 JUyXBazeEzx3DN9vJqFwIWgjNYXGoMKSd0q7AEbJ4zzklyLFgpoIApc538pW3WwSiwKG
 V1ED0lM1E6tpCe6h3h7gbgq2JQsibfTItSglZ9xxd0w9PKrQzNZNSlSwr4O5wPm307Bq
 G9Ca5NAx4+fWYon/N772t4WKnG2POFkg1krJ5gqcfW8zUBdN0wQ7Olq669k0GUGxugCa
 /W0dEkFBM9FJ979mgOVEvZ+x4k69qR6E4YitFAK5YQIUoJiR1OQrwYWHWl3gr2HGh1b0
 /Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sRbh5iLhIJgul14kcDJeTEj/XcHGk+PMKpVRoyVth+g=;
 b=HQe6mmFIXto2DqBirHzB/PDbBTYSuvMOEPExOaysh2JqvqAPqsIPYPtleqwWcdKmDw
 FxbZmmcEdDcesNRrx5t366DoCBzCCjaRB0l0RqTz40703auoxJnaCWidbhQEiK3aJAas
 llg59O7swA52XgT9gSBHQ/LbcfVueVrM/S9nLRJmAyBEqfwZXUF8bS05TV4z81OzsqrN
 vnNxYg2JyEzf2HXqhFbvcBHfhfp4Z7TCd5d2EG+5Jo/2KkFr8BsIUi9R7FdX3+dFZrBD
 vmNgUOGnAUFf5KxdEiOKrhSqh6RqgogBoDawxTuRGxY9HlZMYLTIqt7q0GBtSPS8a5pn
 jWeQ==
X-Gm-Message-State: AOAM533SUf4xBtd2XlRkWUzL6lFakoNJ0UlsF1Ufxthik+1tb/4qEIs4
 ryMWHQGb4fnhYgCS5RWc3z68RkvSZtmYBw==
X-Google-Smtp-Source: ABdhPJzB2duxHEauhLrjN8q6cAKEcesq2o6omT60tyUUDs27i+8CJApt/nk2nhaJ0jdlVmIcpd1AqQ==
X-Received: by 2002:a05:6a00:46:: with SMTP id
 i6mr4755152pfk.146.1590164129705; 
 Fri, 22 May 2020 09:15:29 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:29 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/19] qht: Fix tsan warnings.
Date: Fri, 22 May 2020 12:07:51 -0400
Message-Id: <20200522160755.886-16-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For example:
WARNING: ThreadSanitizer: data race (pid=23406)
  Atomic read of size 4 at 0x7b100003e3c8 by thread T7:
    #0 __tsan_atomic32_load <null> (qemu-system-aarch64+0x39a36c)
    #1 qht_do_lookup util/qht.c:495:17 (qemu-system-aarch64+0xd82f7a)
    #2 qht_lookup_custom util/qht.c:539:11 (qemu-system-aarch64+0xd82f7a)
  Previous write of size 8 at 0x7b100003e3c8 by thread T6 (mutexes: write M166769147697783108, write M995435858420506688):
    #0 posix_memalign <null> (qemu-system-aarch64+0x350dd1)
    #1 qemu_try_memalign util/oslib-posix.c:189:11 (qemu-system-aarch64+0xd59317)
    #2 qemu_memalign util/oslib-posix.c:205:27 (qemu-system-aarch64+0xd5943e)
    #3 qht_insert__locked util/qht.c:583:9 (qemu-system-aarch64+0xd837c5)

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 util/qht.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/qht.c b/util/qht.c
index 67e5d5b916..739a53ced0 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -69,6 +69,7 @@
 #include "qemu/qht.h"
 #include "qemu/atomic.h"
 #include "qemu/rcu.h"
+#include "qemu/tsan.h"
 
 //#define QHT_DEBUG
 
@@ -580,10 +581,12 @@ static void *qht_insert__locked(const struct qht *ht, struct qht_map *map,
         b = b->next;
     } while (b);
 
+    TSAN_ANNOTATE_IGNORE_WRITES_BEGIN();
     b = qemu_memalign(QHT_BUCKET_ALIGN, sizeof(*b));
     memset(b, 0, sizeof(*b));
     new = b;
     i = 0;
+    TSAN_ANNOTATE_IGNORE_WRITES_END();
     atomic_inc(&map->n_added_buckets);
     if (unlikely(qht_map_needs_resize(map)) && needs_resize) {
         *needs_resize = true;
-- 
2.17.1


