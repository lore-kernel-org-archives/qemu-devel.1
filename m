Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCBDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F742072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlwNv7+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F742072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxe5-0003fV-8F
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWV-0002Wu-Oj
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:59 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWU-00057B-Rm
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:59 -0400
Received: by mail-pg1-x542.google.com with SMTP id u5so4284365pgn.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rJUczCRf7dBt8YUhUpO1kHr1QrkMw5NPc8UGt9HIenA=;
 b=JlwNv7+8T85n3ZlQvSqBuJS4qU6VYzQ/2w7aqL5AkZIqVR27L5i58mKqvi0CCNE18Q
 DcEaAkxdJDcu+yiekfXr8zCahz22KXdSo6GsG1hWRlTjVlk2+B05tQfFYtfadPdW359f
 WHmBIbt2ZQhYjYR3D0HNgpICN/Pt7MDsn+TPv6j51CIcmKc5D3hZ9Dpl9IRhJ0aCsRMQ
 TgZ2q/wOfmsXcCcB3cD50w4xme1jdOdkNNZfKp3Yqd4EV+BFo2yS9wggcXneTcD3+1xB
 0O3mA1YujsBXm83+DiQIz7wgDkNCo5n7DlMw1n6jtVZ+tpuM7EYWIlByh+g+KDsCPDQ8
 xEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rJUczCRf7dBt8YUhUpO1kHr1QrkMw5NPc8UGt9HIenA=;
 b=OmuhLYF3EPbqXvepDL5U+fGo+PvLTz2rwHhqNGmzVpLMottTNRjHJNfNM/u02EK6x9
 s3RN65F86Mg87PUaB5SaE6IUMFu/mat785ggOdv+1rW0UK2fwXL1MCcziGESYte+vwdL
 l4BsqFw49fEoAMM0lCrNrq+rvtDSmoFt+pNKNeO90DhZYKGLIbWXNBun97Dfqzt392qd
 pNOY/pSVvXGKsLMHuvtxivAGUri3/NfJfha7fVKMXGQqxndsci6UWw6CZQb2Sia1KQ09
 oS8kNazLNMNTjolgrYWa+FK8zE1Bj10C1WjwCujLU528Y53Ms4aHBONjCoHATxKdtCAe
 QQrQ==
X-Gm-Message-State: AOAM532SztddE1ZmUC9/rc+1JeOQDohPIcmzRt1atZfKx15UE0DysG5r
 9LrHwODFigwN0P7Wl/zmCfgXzo4mKBM=
X-Google-Smtp-Source: ABdhPJxtg2bp9JfKuE11Bo8Cv8jM5elhlGpcRSY5c/huq6iaTjo2+HriHFMbZ9JcFUixvuQHbhew7g==
X-Received: by 2002:a63:f709:: with SMTP id x9mr11658477pgh.330.1590114897162; 
 Thu, 21 May 2020 19:34:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/25] Simplify syncing with master
Date: Thu, 21 May 2020 19:34:27 -0700
Message-Id: <20200522023440.26261-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not pass status like RES_BAD_IO from apprentice to master.
This means that when master reports i/o error that we know it
came from master; the apprentice will report its own i/o error.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 reginfo.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/reginfo.c b/reginfo.c
index c37c5df..31bc699 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -90,10 +90,9 @@ RisuResult recv_and_compare_register_info(void *uc)
     }
 
     if (header.risu_op != op) {
-        /* We are out of sync */
-        res = RES_BAD_IO;
-        respond(res);
-        return res;
+        /* We are out of sync.  Tell master to exit. */
+        respond(RES_END);
+        return RES_BAD_IO;
     }
 
     /* send OK for the header */
@@ -115,7 +114,7 @@ RisuResult recv_and_compare_register_info(void *uc)
         } else if (op == OP_TESTEND) {
             res = RES_END;
         }
-        respond(res);
+        respond(res == RES_OK ? RES_OK : RES_END);
         break;
     case OP_SETMEMBLOCK:
         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&apprentice_ri);
@@ -133,7 +132,7 @@ RisuResult recv_and_compare_register_info(void *uc)
             /* memory mismatch */
             res = RES_MISMATCH;
         }
-        respond(res);
+        respond(res == RES_OK ? RES_OK : RES_END);
         break;
     default:
         abort();
-- 
2.20.1


