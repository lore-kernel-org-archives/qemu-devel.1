Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F392BC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37678206E5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlBxXbQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37678206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKJbI-0005CY-5i
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKJa0-0004Yz-8R
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:01:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42822
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKJZw-0005Zh-RQ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600686111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wV4+WdW4FWzUt71VT+Q4JOE9A0gMJkMnKTuWpyklnGw=;
 b=DlBxXbQB3uwrqEbux9yeba7zAdjTSOwd0xrHXot+BrW6eYlN3TCecjjCk1SGwA6uMMK3cY
 lxzMLC5TrxD/4uCXg7vJtO9Ux3YCl2fHj0XVgbk+8KCjJE+qxw8O22zstbhB6PSj7az9J9
 hfo44kxy+0slL8OBFL2wZyUqdLO0+y8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-c953CO12PDOZin0NqUEwLw-1; Mon, 21 Sep 2020 07:01:49 -0400
X-MC-Unique: c953CO12PDOZin0NqUEwLw-1
Received: by mail-wm1-f69.google.com with SMTP id m10so2372408wmf.5
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 04:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wV4+WdW4FWzUt71VT+Q4JOE9A0gMJkMnKTuWpyklnGw=;
 b=Fmq9ssmiwuESA8jw44tfEAmIvH3i5WcAcOJ6NrBvX24gu6rQQoNvubFnD3u4YN+m7y
 McFKm3RblDKCe/9NIZr6dOqTUueO24+T04jB78TZFXBlBJM4eHy52NhWSODLqk5r3EdU
 bGfii5xHxanJtpHUOarD1vmFKtu2t/dNsxDx4yqkyucQ5x0Rcv65+LxqAmv7Ug9wiAHk
 lDRvCuct0+yCxmkdDix1U+r8sRYBLRKog+LeSpifg+gQ/U+1wEjlL+QwNxYlquw69E9A
 YzX2YnpnClgMYPsq8ed4XtSPBVMl8DPAhLd9Ru2OGgq2n8SFPyNEKTjI6BXW+hzPN9tV
 /tuQ==
X-Gm-Message-State: AOAM5339xWBj6w65YS9f3hyq6hm1z+ue7dW05DqWQtjANQ+mhcrsSmrx
 +rnqEbqnzRS2Vmt+syG8WpwCFTT3KkaHGWbtzOgA7JT4gWJlnk7kRKn2/0GG249KeloL/RHyyyY
 wb9pvYzxzCeLbhsw=
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr11890547wmk.87.1600686108445; 
 Mon, 21 Sep 2020 04:01:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHoNAzVcwsm2gbND4w/6goazRsLqMZZCIUS7TbpWeTxrshxPc2QRbyTetetlpst811HtZeBg==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr11890505wmk.87.1600686108154; 
 Mon, 21 Sep 2020 04:01:48 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z11sm20001837wru.88.2020.09.21.04.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 04:01:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block/sheepdog: Replace magic val by NANOSECONDS_PER_SECOND
 definition
Date: Mon, 21 Sep 2020 13:01:45 +0200
Message-Id: <20200921110145.520944-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 07:01:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
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
Cc: Kevin Wolf <kwolf@redhat.com>, sheepdog@lists.wpkg.org,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit NANOSECONDS_PER_SECOND definition instead
of magic value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/sheepdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index cbbebc1aaf2..cbc655a1a05 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -740,7 +740,7 @@ static coroutine_fn void reconnect_to_sdog(void *opaque)
         if (s->fd < 0) {
             trace_sheepdog_reconnect_to_sdog();
             error_report_err(local_err);
-            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000000ULL);
+            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, NANOSECONDS_PER_SECOND);
         }
     };
 
-- 
2.26.2


