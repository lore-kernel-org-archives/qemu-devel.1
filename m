Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385CBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0474A20787
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV0Ov88t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0474A20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBE2-0002Q1-6O
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBD6-0000k9-3y; Mon, 25 May 2020 07:24:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:39345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBD5-0000pF-HB; Mon, 25 May 2020 07:23:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id y5so2449030wmj.4;
 Mon, 25 May 2020 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xi9QqR+83+B5s2IOVxfJBVAFepRnYVrkPVzemn60gzI=;
 b=mV0Ov88tOG4k8pajy0PZCGW/D7neDXPoUh++u8F5BrLIJLal2spLcI03NtxTG5Kmyh
 Uo7QMyI0aqqxn68D7aor7DU66qktLz+EyU8K328eM3r+JVriSuOrzCJnuErNdNrixz1Z
 DF7JE2W6uSSHtxj07V/Fnk3WAtCfLi+k1ifP5tI0wga4obckuZcQ8u4+ShIrWBcB+oVJ
 OygzTUdl4aFW0dm0NEHO3hzM4YRv2o/jGHgRn8IZmzv3XcRiZJXYsWawj1CNiOW9JZav
 uqLvA2Ta99OKEtFqHBHeMcrBB8sUmyUSWTAxHgUUuS2/mhlur3uOw/59vTz33HSK3EuD
 ACZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=xi9QqR+83+B5s2IOVxfJBVAFepRnYVrkPVzemn60gzI=;
 b=mBps7zDMMBvHCPtLDUAFvH0m16FIWubMfsUHKKK+r8tsr/ZFH3jcFB2+ibKBnFrrIO
 Yf2EBAYBggzl93PZMR7wdpxXnKLrTXfDM7NsuvNMlTCRrr4RiTVPAW0j+TOv6tfLZDoS
 APg1TM7zV0d2msUkC4pTLgwxiyMjVCtWuBymlfydBzEJRTMbKHCM8vbea4rSL6ppPgcs
 tURxRJqZDA31Xf7NdNSiQKGo1uGarN4t52E8dhPspyUSvkYCxPWPHS556XKgcA9qWb2t
 TShUMbgj0h6FXs/+TAXsRPti0F4ug3uSzk75BIbiaZIll7/qtHpQagpoLlrSfha3ZW/g
 qgEg==
X-Gm-Message-State: AOAM5302Wiomsys6XAhQG1kbdGy3owIkbyNKYh/ObiHiUZo1dsyOUq7L
 7VSmH6xxGwP/Ukjnn1M0NygQ88TAhyU=
X-Google-Smtp-Source: ABdhPJyT1hGMf1DrqHJx7+AHUt01BTmY6d/eIGRODJW0Cw2/nheva5h3UfKnRLokZpdzeYOCJQ1XLg==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr10395324wmk.35.1590405837114; 
 Mon, 25 May 2020 04:23:57 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id h196sm10715635wme.22.2020.05.25.04.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 04:23:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/display/vmware_vga: Trivial cleanups
Date: Mon, 25 May 2020 13:23:51 +0200
Message-Id: <20200525112354.10445-1-f4bug@amsat.org>
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use qemu_log_mask(LOG_GUEST_ERROR),
let the device be parent of a MemoryRegion.

Philippe Mathieu-Daudé (3):
  MAINTAINERS: Cover vmware_vga related files in VMware section
  hw/display/vmware_vga: Replace printf() calls by qemu_log_mask(ERROR)
  hw/display/vmware_vga: Let the PCI device own its I/O MemoryRegion

 hw/display/vmware_vga.c | 18 ++++++++++++------
 MAINTAINERS             |  3 +++
 2 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.21.3


