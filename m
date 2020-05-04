Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFE9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2EE206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHeWodbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2EE206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZkX-0003g2-V1
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVZie-0001qr-1u; Mon, 04 May 2020 07:57:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVZid-0001Fn-B7; Mon, 04 May 2020 07:57:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id x25so8105256wmc.0;
 Mon, 04 May 2020 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FT77jNar5f+IZ7r56mu02EcZxnI3YE/ouP7F66CkToQ=;
 b=oHeWodbxPC8aV+z0nSNTcKE8nlj9MjeFOEqksXrG24fa/tc/MGUe6WT/RV8obu47TK
 ccxfyEWM672KB0otvPJNJG7/MOGIwogYCT378lqrYTqAbBh3GSfzntxV3vG2+DVgh5YN
 0jvRL9lE9eLtK3VGfplMqCJrA22i/skO01pL8RXY9T+tZyrilgfTG7KBIkoOBHh1woTJ
 E0E7j1J6bBy6eoX30vVhzsBHdbN23e0/DVysgZYwMI69jn5Uo1YKNUeQ8JgNFv5mZxY5
 RS4BOrJCCNrGkc72s6WYz42e5qzz5nYb0lHPpvgCR8/gf4WYwmCH2FCq4ufn9mVNDHM4
 DSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=FT77jNar5f+IZ7r56mu02EcZxnI3YE/ouP7F66CkToQ=;
 b=ppGYjrtsmvvqQGqAjSq8UMJURx+ZoDAlE90YfThzH2H0QzOiXd2/SljN1UoA+R8L1x
 voNlQ04BAanMmZ7msRNhyU3EQ2Z4NfXAvHZ8W8kiHhXl9WITUOtuHPyS3G+IDCokWKTC
 KpT8yFzc6rZpY5xxLDr+tqNUx61TcM31QYz4CvIqz9ThKSZzs0CBtEkAE0EDOK0qr31m
 sqklXSaZBwuvmgZpYp1hUZxYwFdjuZtfl+U7ARfKaoQRCN+8eflBiBQxYR/h90oS7mIk
 4TIBfPdug9rVKsN41AQtTOAvtvjLoP+C1b7XWvmtQHrr/rSf+Uqsdtd3UM7AogefZ/WB
 5FdQ==
X-Gm-Message-State: AGi0PuaWYmK5t0VXWtyzKja/yMfL8CN5QW5jhz2sh+15m0beACTWnlJS
 X5r2LPllStAg5PkACRUJ9sqNJ2tv
X-Google-Smtp-Source: APiQypL5ZeHr+yHp7AKmIgfGzyeibxHdmbofDrluN2TKnx9KyspjLYwNKwpRKjvC80GxMldJQcN3+g==
X-Received: by 2002:a05:600c:218e:: with SMTP id
 e14mr15235811wme.140.1588593418848; 
 Mon, 04 May 2020 04:56:58 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n12sm5660984wrj.95.2020.05.04.04.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 04:56:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] qom: Few trivial patches
Date: Mon,  4 May 2020 13:56:53 +0200
Message-Id: <20200504115656.6045-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some QOM patches worth salvaging while doing housekeeping.

Since v1:
- Fixed test build failure (patchew)

Philippe Mathieu-Daudé (3):
  qom/object: Move Object typedef to 'qemu/typedefs.h'
  io/task: Move 'qom/object.h' header to source
  qom/object: Make reparenting error more verbose

 include/io/task.h         | 2 --
 include/qemu/typedefs.h   | 1 +
 include/qom/object.h      | 2 --
 include/qom/qom-qobject.h | 2 --
 include/sysemu/sysemu.h   | 1 -
 io/task.c                 | 1 +
 qom/object.c              | 7 ++++++-
 tests/test-io-task.c      | 1 +
 8 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.21.3


