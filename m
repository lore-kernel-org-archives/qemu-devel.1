Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A6CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E672070A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EflvFJMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E672070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcASW-0002fX-9A
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKZ-0003E9-39
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:31 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKX-0006G8-5y
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:30 -0400
Received: by mail-pf1-x444.google.com with SMTP id v63so5393931pfb.10
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kxh2o1V8iXkuJj8JRvzQtcAUGmlKoLZ53V+la2Fi9CI=;
 b=EflvFJMnpr9hfGwGwkLoT90GuXYL0WnbaWiKcadAupSoAPkuxPxNW9QyM/BF1Hml0U
 mX/OL0mCTzcp++Mr1/S3Yo6ElM8P8rpYBqLSgppjH/THbc2dw4+sEb0wW+Nx1ZIoSdcp
 cBU6oenpIQXKQqlGaLRWYbYyJ1UbjdqDfmI5gxRGLioPF/Hb9gXE22gEwpHhr5uRQDrH
 MouxUnm/XmfAP1nacc5/PPeOGQ1JYk3wGI6Lk3pylQ3HwkpkdQ1btimriCpspSrHtZBi
 owrRhdrVLrIg0HpIORotacOj10tEfxmV03k6/EWyk/RnPw+3xxJsbJha7V7J98ZTGrvl
 PuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kxh2o1V8iXkuJj8JRvzQtcAUGmlKoLZ53V+la2Fi9CI=;
 b=S/Oi52KFV14Dk60klUCaS7yf4vM6ynHIA8mOk3jErhMPzBYkHM3tKgYCwvqmrAHYdv
 t8/SQmBxdYQIEw2GVCBLBxmfGpqG+vfs8KjYUOUiFpSQECWsd3Il8qx4cOV+0cXUeIA5
 vptQ4LY/OCTx2xCTuTtD7VIzq5bvQZHAjPgREFK1lmmb4Q0bDtAu3N7DWQtLALmYg8L3
 gO4QV4cPDzKvtFfWRmG/o98JW0iu5jf4T9Nef4T62vAzhZQSn4sswkIvQgabZmKyY803
 GdyS603tv/yVUPGErYkMXT6xDYQbTQv6wRjkoZ65xG5N6imihv2kKRANKuQ36k/50NQh
 BBjQ==
X-Gm-Message-State: AOAM5317FGdp5I9gU58XB0gHw+FCNe3UNj8F+Fiwyn/vCUb4dLobDqiK
 0bLGERCf5fAy4pGGPA/sGs4ZqK+gLZtlkg==
X-Google-Smtp-Source: ABdhPJxxa8q1BvPVAb0Dfq2B3L4+SFf1kgZLZLM0P814nYfjSooeOlG+SsPMvcp4cCmCvioaenJwbw==
X-Received: by 2002:a62:7f03:: with SMTP id a3mr4594490pfd.113.1590164108266; 
 Fri, 22 May 2020 09:15:08 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:07 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/19] qht: call qemu_spin_destroy for head buckets
Date: Fri, 22 May 2020 12:07:41 -0400
Message-Id: <20200522160755.886-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x444.google.com
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

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 util/qht.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/qht.c b/util/qht.c
index aa51be3c52..67e5d5b916 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -348,6 +348,7 @@ static inline void qht_chain_destroy(const struct qht_bucket *head)
     struct qht_bucket *curr = head->next;
     struct qht_bucket *prev;
 
+    qemu_spin_destroy(&head->lock);
     while (curr) {
         prev = curr;
         curr = curr->next;
-- 
2.17.1


