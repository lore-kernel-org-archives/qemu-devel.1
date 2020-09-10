Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA807C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C44120872
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="RIJv4bo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C44120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGK8Z-0005Ca-A3
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kGK6a-00025K-Uu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:47:05 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kGK6Z-0004vR-7x
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:47:04 -0400
Received: by mail-pl1-x643.google.com with SMTP id m15so720400pls.8
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 03:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KjNeJ0OHMTFoWSl8hs1f2FDbzHjoDqMgfcwgM18B2LQ=;
 b=RIJv4bo23IcX09LvY/0oxpc9+1scYlKHzMlSUBoeWOqHx8rsjuwswle2rYkgDZ0w6R
 Z7rsNhQDPx86ycxsd30DysCaRLDqSchFURYZ+wGb1m+CThYoiDFB+52jCOTuc/WZsTpy
 7XNZZ+fgUGlEcjVevh0s1wOKP6wQz/NNvZTCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KjNeJ0OHMTFoWSl8hs1f2FDbzHjoDqMgfcwgM18B2LQ=;
 b=FWD8m2UaSPSBlWTVsIjs46LhlEINS6tK6r9BgMS4QDbiwDNkHDqr647diCvAA4YbJv
 SMhNHp2IIfa46eXy8r1yP5BYKhQm9CzWjYuLtPv/LiFVZpk0Z+o4/WR4kcm47DiiFaaW
 6uT4oxPstAK93wDDMH6+PpjR1vX5qDXL9uekn5Ed9q3tSVZ9oGTkSDIKaKnhUCRfXrum
 HO8Wo/KnCIarrGoPzwJDd4Gry7qp6/4IrIUc9Q5flhwfg4PgaqXqRLYZ9H2m5TmUiC4Y
 /uKJVYePy3yv6ULNUB1Vu856kLowEts9FZaveFRl1gDinHyHGJO/Hk4oh+B1OY+rxf8F
 8Lcw==
X-Gm-Message-State: AOAM531TWLgzWy+EI6oF5IHVfn42R5qy+acSV8i0V8XF+cDISwfoGFHc
 8mT+22ijjo09chSFPnuBe0AYvY1P7GVu+lv5
X-Google-Smtp-Source: ABdhPJyU2lsOAYU8nTxWZiEXN4paSZ8D41GdUd0rOyD1PVQJoUHaPsIQi5zD24HBYsPQnkRmaitbMA==
X-Received: by 2002:a17:90b:1990:: with SMTP id
 mv16mr4381774pjb.81.1599734820740; 
 Thu, 10 Sep 2020 03:47:00 -0700 (PDT)
Received: from localhost.localdomain (125-227-154-100.HINET-IP.hinet.net.
 [125.227.154.100])
 by smtp.googlemail.com with ESMTPSA id 31sm4783840pgs.59.2020.09.10.03.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:47:00 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] COLO: only flush dirty ram pages from colo cache
Date: Thu, 10 Sep 2020 10:46:49 +0000
Message-Id: <20200910104650.1182807-1-dereksu@qnap.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=dereksu@qnap.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Derek Su <dereksu@qnap.com>, zhang.zhanghailiang@huawei.com,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the secondary side, the colo_flush_ram_cache() calls
migration_bitmap_find_dirty() finding the dirty pages and
flushes them to host. But ram_state's ram_bulk_stage flag is always
enabled in secondary side, it leads to the whole ram pages copy
instead of only dirty pages.

In the test VM with 4GB RAM under the steady state, the
colo_flush_ram_cache() consumes 650 ms.

Here, the ram_bulk_stage flag in secondary side is disabled in the
preparation of COLO incoming process to avoid the whole dirty ram
pages flush.

After patching, the time consumption of colo_flush_ram_cache() is
reduced to 10 ms averagely.

Please help to review and give comments, thanks a lot!


Derek Su (1):
  COLO: only flush dirty ram pages from colo cache

 migration/colo.c |  6 +++++-
 migration/ram.c  | 10 ++++++++++
 migration/ram.h  |  3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.25.1


