Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53958C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EBCD20849
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZlTUca8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBCD20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajk6-0000T8-8p
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jajjF-0007ix-0T
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:39:05 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jajjD-0004Wc-G1
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:39:04 -0400
Received: by mail-wr1-x429.google.com with SMTP id l17so12876058wrr.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 10:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fpzHu97ijixMd9DBlDSxREfDZTotPPIRTiJU9M72+M4=;
 b=WZlTUca8X7YZr4P9RDoKqF7Sk7WGlOqWHfGKiHUeEl7u1hsuP/KvlGkAxnIsJ07fVy
 UFyWzE3tFQqERlMTn2GZ+d5esWxJLyK5Ze3E0b4dxCIvC5EpBKWKJOtmb49nXKiJfkcI
 Wu4nMh2G0PFLc5EI6Ule7xCwXNrPc4LH4i4ToK+bDjzR2dySScqWfFW1QuvcvjNvN3r0
 Jtu/KpWUxkkUepgrYPhGOfIy5yNtAk4HHbnUsv76Y2npr8ng2q185YJgnsHUn/4ImqNR
 kv4D5fV9Z8zvxlRIH18uTGDt4hq+3E1YqW0tdz68cl0OlV/FC+DjnZKtvdTeWrxxMGqC
 DecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=fpzHu97ijixMd9DBlDSxREfDZTotPPIRTiJU9M72+M4=;
 b=MjuCTg0PRC+TnAJGb4qZr6ODYhJ45tlyRpWexDi6TWb3KP06vCpPBtM3J3fqQodmHr
 a4DYF/lgerc78PUu19a9lm+YlbusQvULa1ZvPO1jN8NUGVhXwCxhSXJc7UTyBaTXJfGf
 KqDi7v7ux9sM9W9/KFTKBlA/3kmGvGlxvisxhTyD6gHbLhtZIhFTQttT+XlNJyQiWTSc
 ghKGLgzzumg6mtWF3hb6vBu0ZAg7GHVrdBLs0Wm31xQYXjmNk2NmuD+Cxh8kNaG5N0wu
 PNgRXj2QdP/c8Iki2Mdt7dbBgmGO9L8D88wRmERnGWQWLDWbey2NBDFN6LkX+crUu5Lm
 NxnA==
X-Gm-Message-State: AOAM530zKTwi6iank6f1NK5Rni6yNWAjE0AbeNTzL6WP/3aGiwSaTgtl
 ZRh4R1vSEM230NO8BPvXHbM+bBRnKqM=
X-Google-Smtp-Source: ABdhPJxTzz0XUxk+niNqverV7Rt4nk8A6lxbZEK/NIaO82EHpta/w5vlD7Ft3zDMeYgvfoibqYzX0A==
X-Received: by 2002:adf:e489:: with SMTP id i9mr20528260wrm.373.1589823541634; 
 Mon, 18 May 2020 10:39:01 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id k13sm271113wmj.40.2020.05.18.10.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 10:39:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask()
Date: Mon, 18 May 2020 19:38:57 +0200
Message-Id: <20200518173859.16520-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
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
Cc: Thomas Huth <huth@tuxfamily.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


