Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018D2C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF539206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KepNdJK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF539206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWYs-00051R-Sy
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWXr-0003KX-27
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:33:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWXp-0007Qd-RH
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:33:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id x17so19849994wrt.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 01:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=94U7vIRJ1RGCAUwbPeb/49mRpS07jgYAe+fLB8J80Qo=;
 b=KepNdJK1YXm5WtKyZpTDhNc9wEdSLDgWjSkFVctcKSikOrIH1sv8a4gQ9b0CUaDWjI
 MzbMCcIw9HzVSxJlTHoQ0Y8Ds1cYzl3mLLZ7MWdOM1MAU1H1kY6VwNSWvj/Kk5GiF261
 ThDUg8iUkKmlD87uEILczXmhahgpiGd2Jn+XkUoOFly7+p1PduX0cwo0HtpyMLQvFDXG
 sHZjqf8yRnX2WPQszuEPSqfnTZUkStDg+D0TlLBwbHo/E3XeYCk4FtyHMq4KS+rAfMRQ
 /gD4Qz4bgF014WFHiFMp6jJJJ/7v5mVMrmjrEPybQsA6aamMa/Y+wDLxg+MXbgRFQKXY
 6ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=94U7vIRJ1RGCAUwbPeb/49mRpS07jgYAe+fLB8J80Qo=;
 b=aUIORLn7LfhzCfz1dOurDsuLUdR+YMYDWH4qpbU1MJDAgY+zwVYsbUc/MTLqEVl8QP
 4RjycoLyBfZh19ZA12O1fY22VHsG5P8N+ZjZ4CLajMKmEWkXToBTAevy0hBipvXBMrPZ
 81lfDdMNH5xFBoxia44e6KLPQ+wdk/5NJRxHwuOWCl6Fh0fLHQnaAXDWekum4u+RgblD
 EOG2ae+Wte3LghK1guxnVd03EmfaehmqRUjQmw9tP9hoeIdmr/Shva6MyEDgXvt+5eUo
 3bUCjNWDK2blR3kVV1nbvmqi8UqFXWIO1tO9CwKm+LknhE9CFX1esqOIp4EPyPkGKLVd
 lG+Q==
X-Gm-Message-State: AGi0PuZBG9hek1wXpn48+/N7FJrJaPPvZTy4Jr3NQfZLEeNxIHsG8q6M
 EZQGJzwAJ+ezyO+nuOCOw1+qSZJ7
X-Google-Smtp-Source: APiQypIlQVmSNAG5OzLB+2yqeV2jqoFiqLRCzPQ1JA9YqmIlHLJlMbcYBcFOeLDFyAgMfflW+bIChg==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr19817101wrq.158.1588581223952; 
 Mon, 04 May 2020 01:33:43 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id 2sm13048053wre.25.2020.05.04.01.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:33:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/i386: Restrict vmport/vmmouse devices to x86 targets
Date: Mon,  4 May 2020 10:33:38 +0200
Message-Id: <20200504083342.24273-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some x86 patches worth salvaging while doing housekeeping:
Restrict vmport/vmmouse devices to x86 targets.

A step forward having "hw/i386/pc.h" target-specific...

Philippe Mathieu-Daudé (4):
  hw/i386/pc: Create 'vmport' device in place
  hw/i386/vmport: Remove unused 'hw/input/i8042.h' include
  hw/i386: Add 'vmport.h' local header
  hw/i386: Make vmmouse helpers static

 hw/i386/vmport.h     | 34 ++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h | 13 -------------
 hw/i386/pc.c         |  3 ++-
 hw/i386/vmmouse.c    | 23 ++++++++++++++++++++++-
 hw/i386/vmport.c     | 25 ++-----------------------
 5 files changed, 60 insertions(+), 38 deletions(-)
 create mode 100644 hw/i386/vmport.h

-- 
2.21.3


