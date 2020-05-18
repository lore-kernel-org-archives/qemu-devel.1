Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714B2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E42520825
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1Eimbkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E42520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jadBn-0006mT-DK
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jadB9-0005vE-0j; Mon, 18 May 2020 06:39:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jadB5-0005fR-SK; Mon, 18 May 2020 06:39:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id m185so4879270wme.3;
 Mon, 18 May 2020 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uPz6DcNC81y6A66bRVhQqY++LZAZXdNwQwaLW3plPtA=;
 b=a1Eimbkh1PJa3BQNA9KpMn3/fRK26y4XkCAxEb/oN0FGSh9jZe99ju5gXQ4dvg0nMf
 r7ObTDh6Y75yW/sfe3hXc1fsye8TyFhh6G13NeejKgfhxt9/cOcJLb1PKDQPDuKpcWOR
 nnHM1q0JNAdNpoDyoScA3uMw6haRkFVCXlUM0HOdV91Mt7/RgIRTG73Wv03NAxZr4dEy
 rkUpQT6lkT5N51oa97QxSCKszjMSsmuf9ohTu67FmW6hj1Pzm7FTxd4MzA+fCbGhba7t
 CwdaqWOOTRVJRnzhkSfZBs0t2X6vyp8Mq2QMmn+rT025KPLFV8QxL8ikwksUaqkhAbcY
 oyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=uPz6DcNC81y6A66bRVhQqY++LZAZXdNwQwaLW3plPtA=;
 b=pslOVqLjlyn0XFyxnLObQgfqbnmqU9RqYCFZwzpS1yzpMnqslEsgnnRcwd+HftX+pT
 J+5toZdw3a41tN8nYYEkOE/eY/BrIR3Z3oIwO8lIFA7BAZ2ImO//9AeIRy/BINyWE9LP
 IKhGWnq8eHKZJsN+yuev+TCy1UxsoGJA+0tBkeMduCF8T3RyavBDQ3Zc0dZN05l5Mvx3
 t9E10Mzc1LRxF7TeEzVHsOj8abxNFVpQT5aevTaa3h8HRnYTg9hV+deUbS60I3lXkNzu
 PBRQCdPyyfsLDKk/z23+Rl2ysUcX7OomH/UhCtNVq4Yh/BXvt6WhZgkQ7k3BEyWad7QI
 kyxA==
X-Gm-Message-State: AOAM531JmbyIwPmlfxPXvGrsQRjlcCOcJ5Iwk8dNsdCHbImBXY61jKOu
 TT5Pn7frw40NnIaOCv0tdzNfGqgl2bY=
X-Google-Smtp-Source: ABdhPJxtIWNmY87ysPdNaAaPT/rp30fItD0AVqy1VwTG56LCjy+rVwQfo+FWJnGsYXJ9MfrRW8eeNg==
X-Received: by 2002:a1c:9895:: with SMTP id
 a143mr19156863wme.172.1589798361748; 
 Mon, 18 May 2020 03:39:21 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c19sm16791204wrb.89.2020.05.18.03.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 03:39:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] .mailmap: Update Fred Konrad email address
Date: Mon, 18 May 2020 12:39:20 +0200
Message-Id: <20200518103920.10699-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32b.google.com
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
Cc: qemu-trivial@nongnu.org, Frederic Konrad <konrad@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update Fred Konrad email address to avoid emails bouncing.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 6412067bde..4c7f4b7d03 100644
--- a/.mailmap
+++ b/.mailmap
@@ -44,6 +44,7 @@ Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgte
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
+Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
 Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-- 
2.21.3


