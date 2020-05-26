Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF93C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BCB20671
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHGYwu7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BCB20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdW5q-0008LB-Gn
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 05:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdW4v-00078o-LU; Tue, 26 May 2020 05:40:57 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdW4v-0005De-1u; Tue, 26 May 2020 05:40:57 -0400
Received: by mail-ed1-x542.google.com with SMTP id k8so1027181edq.4;
 Tue, 26 May 2020 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uKvxRsw0Ou+rV8yTkVyvX3UcLqAJFgcQKp+hrzqIsVQ=;
 b=qHGYwu7/nVUbgIGVjdSwI5MT5uSvILN7X5bJLu8YnV3HV98fJo6IBJLVgJTPAw+maS
 aZNPvG1Sn6VoxmTCt3gVWa6H/QJeByA6zmB+SnkCyeDebnLh2N+pOKYWEAJvamokwNOU
 fa+WoXZhuKnoZo2vJNaZag4jEp0hy8CNG7gyn9Mu+coLaUawjllqCO1ELCD/0zIuxXSE
 Z46QAKEFXTSNJbipkhWpKQNmli6BVwjU0zOKphOrMDwfYRbQlSBClzHXH9PSmTl7Mp6S
 g6yDjIkzLavwdetLjzg+qwohQdeGzLU5UBYTXJEvH7MxwLuEvKO+rwyFGcH0FIGf2qEz
 ntRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=uKvxRsw0Ou+rV8yTkVyvX3UcLqAJFgcQKp+hrzqIsVQ=;
 b=Vm30z7lzKjkm/wWoZnxdCkug1YqhB6KG78lHEOrzAJu/flxlx2b8hjC4hxm70WLLpI
 jQe54Xaa1DFUm0amf8m6z5nmgeRmRN/LjFmYw9nP2/zcCnLOL9PmCItnPhXpryJOd14I
 CnZ354Ihag2/awOQv7mRpzsZuwei+rWJwmy7NtYiaSUXprw1N9PVQbgJpict7XT8BC/g
 cqJ+zT7+7QzQKLROXRi//8EaWoe5TNifmZuAiH3liDMoRcFch4zBgUMwenxoZIXNEIb3
 YdOy6oiFr051rJtqv8mvjfG4OAwRioapg8JxUTzmDHK9X9U79DtWKg+mzdvwBRm6fkKO
 QmBQ==
X-Gm-Message-State: AOAM5312Z8QaNHIPvhan7k8SVEehD6GAtA+njBLEM2IB8SeTcPCrSPsg
 Ikzb6QuuTp/Decz3wKHKgHp2pXzgbEw=
X-Google-Smtp-Source: ABdhPJy+zNOEP5u6EQ4wk9cwWQS6zrQvA8T8ctOHSN6/RqaCYN/6vJDd31yPHT9xhC9KephPcyFSeg==
X-Received: by 2002:aa7:dd0a:: with SMTP id i10mr18433744edv.291.1590486054663; 
 Tue, 26 May 2020 02:40:54 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id s1sm18337981ejh.81.2020.05.26.02.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 02:40:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask()
Date: Tue, 26 May 2020 11:40:50 +0200
Message-Id: <20200526094052.1723-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v2: Addressed Thomas review comments:
- use PRIx16 format for 16-bit values

Since v1: Addressed Thomas review comments:
- return instead of break + call update()
- fixed format strings
- add more LOG_UNIMP

Supersedes: <20200518094904.24226-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (2):
  hw/m68k/mcf5206: Reduce m5206_mbar_read/write() offset arg to 16-bit
  hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask()

 hw/m68k/mcf5206.c  | 14 +++++++++-----
 hw/m68k/mcf5208.c  | 16 ++++++++++------
 hw/m68k/mcf_intc.c | 10 +++++++---
 hw/net/mcf_fec.c   |  9 ++++++---
 4 files changed, 32 insertions(+), 17 deletions(-)

-- 
2.21.3


