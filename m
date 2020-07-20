Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604F6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDDF22482
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DArq+U/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDDF22482
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxZX0-00064r-8S
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 13:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxZW7-0005TY-A3; Mon, 20 Jul 2020 13:23:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxZW5-0003pF-CH; Mon, 20 Jul 2020 13:23:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id a14so3783767wra.5;
 Mon, 20 Jul 2020 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RPtr2B1YzHyMjWgtik1s/pvOZlnzirJaX2W4j3uurgc=;
 b=DArq+U/983gz+oG39ecUzWe2TB62v60pCUm21zDXOAqNS7cJLbgcO3Ba848pNZS/xn
 Ay9Ei9NlNt72PqletDe75JFsh2eMz1fnQOnxzeqt4Lh4gyMufovyPB0vU86eM/nb69XX
 8v5JVKO7mORADvFNrLj6bZRbLY28HRU0hS7iOflDBBXKpBhqxtMPbIrYtC31Q7+2GPqP
 jKDmeRJbv2mdafWR5cakihixgLgn1eKksSRD6ma8akPlJOjs8bJB6mJZLHSRfgnATDXb
 5ADCpLB9sztXZRkICavxEpnhPUvqZIsh6eSJ04VSFYDr2G4fJLVDlgdtRh84lLvheKCA
 c/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=RPtr2B1YzHyMjWgtik1s/pvOZlnzirJaX2W4j3uurgc=;
 b=eronPVPKHHbKAfTqEoAbSmURucakBJNzxSJF2QEYZoP6bUyzgDcrZ0NOYnF4eDUuX4
 UQNFvfxpYx1skzxspIsMWJsGfuYHIxBfIllN/OfLXe0OcKQRHsvzL/v5hvA9GMgCx6Vp
 gqzvrwd/McBn2T99ilCZcfG8EC6gd2N+T+rA+EZdNydRZfFsEM1xsORsftO4VvxMgdeM
 QByoOmJI4b5iZGFnZr9bmBthCo1RM6ci9rjah+LLPuwCnxAzqHQ9YeU5B/Y88KjyqS8P
 D/ONyEkrmzK5SAB7pXW9wyavzU4xpuFSfcTOHEAyVaEdQAv/Yj22R2iWyoCUO9hYGT2W
 9nQA==
X-Gm-Message-State: AOAM532WDEQ5ZJOUr+X+RhMAZ2Jj2xm39HwCbshLsJOpur/BloDItJWJ
 ouzC1jaFcqs07mtJ/pza6jM7LNG/CqU=
X-Google-Smtp-Source: ABdhPJyRbDcW7cUblcHV/47tvCjYZs89GDI0/B8l6WSVnKMvL9mBgcQ/YQFSEU98rztlzAD2ysMyqw==
X-Received: by 2002:adf:f082:: with SMTP id n2mr24379697wro.326.1595265830433; 
 Mon, 20 Jul 2020 10:23:50 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w12sm36994698wrm.79.2020.07.20.10.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 10:23:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] hw/isa/isa-superio: Fix IDE controller realization
Date: Mon, 20 Jul 2020 19:23:48 +0200
Message-Id: <20200720172348.23465-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When realizing a Super I/O with IDE controller [*], we get:

  qom/object.c:1684: object_property_try_add_child: Assertion `!child->parent' failed.
  Aborted (core dumped)

This is because the device is already realized when we try to
add the QOM property to the parent. Fix by realizing *after*
adding the QOM relationship.

[*] Set ISASuperIOClass::ide.count = N with N not zero

Fixes: e508430619 ("hw/isa/superio: Make the components QOM children")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/isa/isa-superio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index e2e47d8fd9..179c185695 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -158,8 +158,8 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
         if (k->ide.get_irq) {
             qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
         }
-        isa_realize_and_unref(isa, bus, &error_fatal);
         object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa));
+        isa_realize_and_unref(isa, bus, &error_fatal);
         sio->ide = isa;
         trace_superio_create_ide(0,
                                  k->ide.get_iobase ?
-- 
2.21.3


