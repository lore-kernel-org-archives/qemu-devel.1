Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E872C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F2B21707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1gSNeU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F2B21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKRA-0004Vi-AJ
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 13:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKNv-0002mk-Oj; Fri, 18 Sep 2020 13:41:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKNu-0000FG-16; Fri, 18 Sep 2020 13:41:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id e17so6089226wme.0;
 Fri, 18 Sep 2020 10:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xiTpN86kArLOhmCw6zW3VxFJ0tRE5dZhorrYnRgqPOo=;
 b=A1gSNeU0cGwUetV0XEeETgS/Wzkpi0LMouxBRMlblzO4IN3VOQXCzwO7seydYBledf
 tkZzORDZXN8USHTtER/eVDY1ekEhjuhxoTebKOw0QhgNKvBMIuzFLJieuSoDoH9IMCzy
 WdKdH4i6r1lYVsj82ZrXEtU2uyrIUFljyfCBVyQI1aQjFNE3toqPzOS+X+CCS/cmMc9l
 B4y8B4xNlhRsXMm5KUKbjEzYcvyf4GVWPNIG31okAhi7XWXcALN5UdCXYHwQLmh1ZlPj
 nmVLI4mDUJtGQyqzGFT1kPrX1BtSiCZGUzkB9YZuW0inygU2j6iNZSJ4hIaHOfAGf+GS
 LPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=xiTpN86kArLOhmCw6zW3VxFJ0tRE5dZhorrYnRgqPOo=;
 b=ovfYhDC75KfKbsMZgkLren1/EaoZGJP7GmC58E98nzENep1tGiIMypK2mOLCnNwe/7
 U0c/8o3SC6jcs5BudIVJKl7wF2n7t8iD856k12I/fMsUQYfby6+BSDZDp8gKO9udzrKP
 USsNf6HZd5tRWvALsKMiUf5y9md3TbDjVyA44bqgVNcrKKaEpGcJWFTbKxnx4pkKoQJL
 92yrZG86aGmOYFQLLm3OTKtwgRW4JOGHeY8LkybSZf8NMkBhvO4BnT0lJ9SJ6YD9SAw+
 INpn9GXDzNN9zaJN6wvk9cfTDtteahrpNW1hqkLmhqRGJ3olRAcKoMvtaHi4xp0wYBgO
 bQtg==
X-Gm-Message-State: AOAM530BVpZb8/Eo0KUm1rJ6AT31J7wMZQpymRbzatEaz0GRc5szXnTc
 0xVdh2tn3DWjuBaLeZwgvTlJkWEPEgY=
X-Google-Smtp-Source: ABdhPJxkaeI2deJcwrCWqBvgeJYG3AgJJtIQL/7fLUONNJ1XUfvDSxt/9dqLUWzkqwie/iSyoraXOA==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr18046678wmj.68.1600450879246; 
 Fri, 18 Sep 2020 10:41:19 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a81sm6356179wmf.32.2020.09.18.10.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 10:41:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/6] hw/sd/sdcard: Do not attempt to erase out of range
 addresses
Date: Fri, 18 Sep 2020 19:41:11 +0200
Message-Id: <20200918174117.180057-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yet another bug in the sdcard model found by libfuzzer:
https://bugs.launchpad.net/bugs/1895310

The bug is fixed, but there is a migration issue to
be resolved... so posting as RFC.

Philippe Mathieu-Daudé (6):
  hw/sd/sdcard: Add trace event for ERASE command (CMD38)
  hw/sd/sdcard: Introduce the INVALID_ADDRESS definition
  hw/sd/sdcard: Do not use legal address '0' for INVALID_ADDRESS
  hw/sd/sdcard: Reset both start/end addresses on error
  hw/sd/sdcard: Do not attempt to erase out of range addresses
  hw/sd/sdcard: Assert if accessing an illegal group

 hw/sd/sd.c         | 30 ++++++++++++++++++++++--------
 hw/sd/trace-events |  2 +-
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.26.2


