Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5192FC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 14:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9C623110
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 14:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9zD2VQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9C623110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xe3-0000rJ-AZ
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 10:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k6xcg-0007ms-PJ
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 10:57:30 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k6xcf-0005Ai-8U
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 10:57:30 -0400
Received: by mail-pf1-x442.google.com with SMTP id 17so5953631pfw.9
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=njuy15+Nlbd8ozN5as8MIYTGB+ABWpAE9R5AWaiEs7U=;
 b=l9zD2VQCJ2xY9EPQ1Bs/TkUX5v+m1OMLuCEO0YMOBmK3GUsdEkn907n7nJHF76/WAX
 Gc7tbl1KDm/rfVWzwrqqHuwI7J07Yvi1Aoqn3GkakAsx1qG4p2NnHDJ+FCh12H8HOtrC
 ADl3xCpPwfnwi6v4I+C3r8i2vN9XiLYmBwzia129caZ4YwGin1EOaxlrPsFN2NMs2uV5
 dcweAJLaigiol6FM1OpDTyxzE4pScoX8fakIPLOQyleeTOz1e8u8+uC0YJG02k/AV1zo
 HX5EwUkf6mVWn/M8IOcypuz5nD78s2kDk8Tc+mQaI4FNeXf/k/SE5bA9Rp0huS5r1VxK
 qJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=njuy15+Nlbd8ozN5as8MIYTGB+ABWpAE9R5AWaiEs7U=;
 b=rWOojTG3EwM6wELA/Ybn6vv4fQwbtSXapsNri2BW5PGDx0Z1xtz0Ttn/GcNdfWgfR7
 b4QwvbI07iE+Cz2z2NdtUnSMUgWgqHqEVURHq0kprQZtTvWZ0OKK7e5e30G6NCe2Tr5N
 r5yuNRi6V44GtI3Pq6sbsdq8kJ5M42zkJLnpkpirpvxEINt0zJQbMjOtLXD213xfQIYh
 szJkYiFyMPObITq6oewrmaWNbTwKbdOG/iEGjXcUNsagawxzcCF0xAZ/Zgs8RRhEGuXc
 rBIzA7nlJU+ahkqjpH1HGxCKDHGnlYyNkhRvKFVqqeQ51S9p/Cp1w8WdEsXq4oKLLN1M
 O+Bw==
X-Gm-Message-State: AOAM531tcC3cR9TtLVbUGyft2Ds0khgET9V0QD3l9kLflyJnNdIPd+bH
 QSkBX355V7dYh7AvatY/Kjv3s7EmeAwQzA==
X-Google-Smtp-Source: ABdhPJxLWZO29KbHwc8nveuT86EhKnD9ig6Fi4SFZAsoNM/iWsGLHo5W2y/5KNRpFn8Q/KWfQMUyjg==
X-Received: by 2002:a0c:f607:: with SMTP id r7mr7029730qvm.219.1597496449750; 
 Sat, 15 Aug 2020 06:00:49 -0700 (PDT)
Received: from ubuntu.localdomain (pool-108-35-56-31.nwrknj.fios.verizon.net.
 [108.35.56.31])
 by smtp.gmail.com with ESMTPSA id v45sm13745573qtc.42.2020.08.15.06.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2020 06:00:49 -0700 (PDT)
From: Rohit Shinde <rohit.shinde12194@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Fixes: Fallthrough warning on line 270 of
 qemu/qapi/opts-visitor.c
Date: Sat, 15 Aug 2020 06:00:46 -0700
Message-Id: <20200815130046.5344-1-rohit.shinde12194@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Rohit Shinde <rohit.shinde12194@gmail.com>, armbru@redhat.com,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added the fallthrough comment so that the compiler doesn't emit an error on compiling with the -Wimplicit-fallthrough flag.

Signed off by: Rohit Shinde
---
 qapi/opts-visitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 7781c23a42..43cf60d3a0 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -266,6 +266,7 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
         }
         ov->list_mode = LM_IN_PROGRESS;
         /* range has been completed, fall through in order to pop option */
+        __attribute__((fallthrough));
 
     case LM_IN_PROGRESS: {
         const QemuOpt *opt;
-- 
2.25.1


