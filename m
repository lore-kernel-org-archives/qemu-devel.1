Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1230AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3FE206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqyEB6sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3FE206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl6Ox-0005fz-1T
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6NX-0003fB-9k; Tue, 16 Jun 2020 03:51:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6NV-00084L-Jy; Tue, 16 Jun 2020 03:51:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id c3so19630760wru.12;
 Tue, 16 Jun 2020 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8+v1WtTiaBr/cU57D6WDEIafuRkg4EVCwsLaJ7Un5zA=;
 b=WqyEB6spwUThFV9nVg0pOI27fLw4PvX4EMshTCBLKZSa572rAt6aEq86ZFCFfYoUU+
 tgoto0t1sgsKsd2e/xFNgoXNEzFso8nwlNdn2u09tm1ukKJ8d3tkTlGa1rAsMfUXfe5Y
 T1TYzcU8/iwY34qbxXV7WREAOF/S9SMSL0ejUYVXW8WvNWf2uMZMVihYevSlCYcKsaKZ
 e9sgn73S6WmG1Zz/DCfml31GnOEm52zqdxsAfG0NkoLynOqqaIIA2IDuQpOxyHqcI3So
 KV13Fzg+JFP+J+rdGOF1+97h3BlXbaBcMyG15qvS4HZt4Yk0fNHxwzfd+zTDYKnZgrVB
 oCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8+v1WtTiaBr/cU57D6WDEIafuRkg4EVCwsLaJ7Un5zA=;
 b=qyStvECLHnCp8DYBY7ufOMCrsHiwin856jCDCp7F+b4iZERfvgzxTx6YYLcFgbFy3g
 Yk/E8pdUQZovSybGrLQf6hP3EqQvgFavjYjVKXbRAdvDNsrIfgr9uiJtVZ3rUrN6B2g+
 taMMcnytWfxba5NqGzNaeEMn4BXxCb2Y79uHd/6qd90lru8D+h39gYJaptB0Ql21DGFf
 IhetqvfSPd7zC6PZiOLtFw029wVfPcvYzNJpxIk+lf/UYeHWDTnLYydVbXGduaw/GLCE
 0IPlBCKlADqdb1bzjNtT0WPt1+fIkQg7DKSM/ny1AxU11AodCGOaHqscmuGrN6WOJZRm
 Gf1A==
X-Gm-Message-State: AOAM531+i89Vu9R56dK8I5tKLEp7b9pbVP52gfhGsIJayqJa00lxtaHp
 O0amYlz1bmQ2OMDgsDa0kKd3XYJn
X-Google-Smtp-Source: ABdhPJyVhsqAjnTuku/6hQtRl9inKCZTYIp+7/jbbB4OdUj3oQTfEA7fAkBKSHC2FPy7UG5FiQyngQ==
X-Received: by 2002:adf:8067:: with SMTP id 94mr1545509wrk.427.1592293886437; 
 Tue, 16 Jun 2020 00:51:26 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q11sm28093538wrv.67.2020.06.16.00.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 00:51:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] block/qcow2: Document cache_clean_interval field holds
 seconds
Date: Tue, 16 Jun 2020 09:51:16 +0200
Message-Id: <20200616075121.12837-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616075121.12837-1-f4bug@amsat.org>
References: <20200616075121.12837-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not obvious the 'cache_clean_interval' field holds
a value expressing seconds. Add a brief comment.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 block/qcow2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 7ce2c23bdb..fa5c2e64a1 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -310,6 +310,7 @@ typedef struct BDRVQcow2State {
     Qcow2Cache* l2_table_cache;
     Qcow2Cache* refcount_block_cache;
     QEMUTimer *cache_clean_timer;
+    /* Interval for cache cleanup timer (in seconds) */
     unsigned cache_clean_interval;
 
     QLIST_HEAD(, QCowL2Meta) cluster_allocs;
-- 
2.21.3


