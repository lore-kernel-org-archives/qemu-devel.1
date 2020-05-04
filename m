Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1BCC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0A3206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwqgvSSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0A3206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWlJ-0005C8-F8
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWk0-0003py-BB; Mon, 04 May 2020 04:46:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:54639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWjz-000559-Gg; Mon, 04 May 2020 04:46:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id h4so7492099wmb.4;
 Mon, 04 May 2020 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0RTS00HEifBctOofTSWRWi8RSs+cYienIFHInwck1Qg=;
 b=ZwqgvSSV3NGEsYocLS8E7fSOLGaXDliCWoZUCZHKs1pmh89DIofzmqpvg5ftTr99lO
 MW/tqi/cEz7poxAUkQuTNIULa9I2QxJpLShjjAORDmRkKfgdbZQT85hIPMFxyWJkEgLj
 B6VNbyvjU3Hs0p9TlfEXGbyhxnTToHQeW8OCEKVePtMJT/O81bIXMd2nWcKETwsa2Ngs
 ngwXCr4zJy8cwzwfig0yF1maOiWy/jXpNV1aAmtG2eMF36tREMoNbAVdTPwDloJtx5nG
 6Unue9pfydWKkSMXZQ2GkxaBAXWn7AAjKCIeXPjNC4EdSJofO8xx3BpqpT81wF4eCltO
 wVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=0RTS00HEifBctOofTSWRWi8RSs+cYienIFHInwck1Qg=;
 b=tmkvJHNSrCQfKoJEbt00Sv+NXDXb1K43Zj+skkjonsOo3QsBabJmkvYbHG+rZx1fRO
 /+EL+S/Rts+hOUrF9ZNhWe8UwyNA+IP3iG+4RVO4MXuM/Q3ILq0TRgmkEOUzd+OarlY+
 owm62LQkN1I9uUCnv8lms7v3tBSgkaSbx3u0M3B09prFQfbRc+ptOkp+O3XHyLZ5hW8W
 k80UA2Ri7ExtYiTY8irrLGbeOLhHM7K1tBkwYwDQ9wqm2XoIa1fktFd3qQ7mSvXOsKFd
 gdXMWQA5CfU7eWUv1g05UN9bfRvqpWb8Obi72h4/ZnYQoBcMoIERWTrVWubduPBY37sc
 xyIg==
X-Gm-Message-State: AGi0PuZ+gNewOGT2nI+dF4bYqkRNaHAj5cKexFYXgsYq0vcF1ESW1XQ7
 0SXdCF4UzWRatNyLM4AZck12V0WL
X-Google-Smtp-Source: APiQypJIhRjHdK6vz6kAFba2LAZrZaIF0so8/HHKTvaeNklDnm6VRdnIeja/V4S9448KC7ppg35zZg==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr13219144wmf.119.1588581977483; 
 Mon, 04 May 2020 01:46:17 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id w6sm10740621wrt.39.2020.05.04.01.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:46:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] qom: Few trivial patches
Date: Mon,  4 May 2020 10:46:12 +0200
Message-Id: <20200504084615.27642-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32d.google.com
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
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some QOM patches worth salvaging while doing housekeeping.

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
 7 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.21.3


