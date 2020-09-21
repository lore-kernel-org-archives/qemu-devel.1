Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A88C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 04:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E2E20665
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 04:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPc31pFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E2E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKD38-0003XD-UE
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 00:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKD2E-0002zr-Op; Mon, 21 Sep 2020 00:02:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKD2D-0004SX-Co; Mon, 21 Sep 2020 00:02:38 -0400
Received: by mail-wm1-x343.google.com with SMTP id l9so11062795wme.3;
 Sun, 20 Sep 2020 21:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MPAiKLeXC283ppfLqQLlp3Ann9X1fHBDsb552s5XDKo=;
 b=hPc31pFhtAw4UzZcokkeBDFEbDmKGGdnbxIlsZye7I0iD55H6uW/GKofejhRQtg1L5
 hDtHa6zzc3UWCcAhoyvDoYTH7QoliqgQOoxl44sc+RD9lovsdRhN+BAc9yFzohlwPaCw
 v+a2kIzES62kXN+rNxybZjtbH2H/PNYDlGWXQdoXbs1uTNh7klrgOWAv2GRCAycNs7+Q
 FifU9zXrRSqVxlxQcAidhYq+xIejk/ZAWMQktu/yvIIGjifmzsg+1r91cI71ylEEcasQ
 UTXBxxi2nagufZeXMzqHdO3fqe+LPyH78nwUEj78YOtOTKjuMQwx/jR2Htya8rhGUmlT
 8ubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=MPAiKLeXC283ppfLqQLlp3Ann9X1fHBDsb552s5XDKo=;
 b=aXzmB69gjuxwr2YBujqU1/cNBkmi9k54KvKGyi2WVlWt34BQrpLq4T5HLPUbtR4LbS
 qa32FUzTjnWUSaNu80XZ1CFQVyRddPj7bKE7eGCk7en1FmpGlTTqvcoeN6W+jt1l7Skc
 YpCFFkMcyHPS9hlql41MRD1ZLrzwZRcBuJhuOoaTDDb50Z6yD3CI7f8GnEV5eAWqJtqv
 7/lxzcJX1QBtvra4t1oqsHDto27l9mWMGisEc6B6O599vFszxDS1hjjqw+e2lIz+86aB
 rywZmzCOH8ZSNjOjF10clQ9ptn+83lYaK4sLmbgc645iPCSQc+onr2M5Tq31NR7/DU9B
 moDw==
X-Gm-Message-State: AOAM533/pX+0xdY361kdq2quxN4greXvMhEOIZGJplDsgSJn/c4eOpgk
 8IJtyVOqvfgYAw+6IASSUFbdZvbb2RE=
X-Google-Smtp-Source: ABdhPJwbqQkXAvYjtsJeVQc4tho1wPXCoPLJl8wclW+1ntfmM4qocd4ubRw3F2ifhumJ5Tufxof/TQ==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr27468142wmh.152.1600660953922; 
 Sun, 20 Sep 2020 21:02:33 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m13sm17681419wrr.74.2020.09.20.21.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 21:02:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] migration/multifd: Remove superfluous semicolons
Date: Mon, 21 Sep 2020 06:02:31 +0200
Message-Id: <20200921040231.437653-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

checkpatch.pl report superfluous semicolons since commit
ee0f3c09e01, but this one was missed:

  scripts/checkpatch.pl d32ca5ad798~..d32ca5ad798
  ERROR: superfluous trailing semicolon
  #498: FILE: migration/multifd.c:308:
  +    ram_counters.transferred += transferred;;
  total: 1 errors, 1 warnings, 2073 lines checked

Fixes: d32ca5ad798 ("multifd: Split multifd code into its own file")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 migration/multifd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index d0441202aae..8aaa2f9ade1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -447,7 +447,7 @@ static int multifd_send_pages(QEMUFile *f)
                 + p->packet_len;
     qemu_file_update_transfer(f, transferred);
     ram_counters.multifd_bytes += transferred;
-    ram_counters.transferred += transferred;;
+    ram_counters.transferred += transferred;
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
-- 
2.26.2


