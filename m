Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C7AC388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AAA2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6DC8TlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AAA2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXMY-0003Bk-C0
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZXLS-0002lc-PI; Mon, 02 Nov 2020 05:45:50 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZXLQ-00026N-Sm; Mon, 02 Nov 2020 05:45:50 -0500
Received: by mail-wr1-x433.google.com with SMTP id n18so13984845wrs.5;
 Mon, 02 Nov 2020 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bHvvPZ7OD8wLFp1gVlSt6ebk0jZS9TrWsAvI0LY+SFc=;
 b=f6DC8TlHqeCUdQuDLTZZjTNOwZYc3wpmjPwy8XYR3KCuMhh/H0K9+BEOJoa3AAgv0O
 66l/stRY1WLqshXCui6zz5rHV9OBF+h4KTMYqXO+5kPmBBaJLGePaouFFseiji6h7Pdv
 ntx0XnZFhRkFHPkKMkvkuTGX8+do5ay26Rhzj/uTCSJmEbol4fbijRKXUiom19oZ1yzu
 8khxf0b8hBjX0VzYRJ+XLBQLSyNa5FZpkUllDKJcy5TGcrm8ejGWAisQ0MA0wm/mZOKF
 xDNWpkREZ2u2BSmrjuvbA/1MtlIzn06umV1CbOMtxQtOGE6GNR3WCzocvmb18fezixsG
 QWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=bHvvPZ7OD8wLFp1gVlSt6ebk0jZS9TrWsAvI0LY+SFc=;
 b=g8ur7qWcj6Sp3hGMmbK2qV+VGZB6JE8IcL4/u2PbcTRJekFM/C1CSKTOvV/L1wr36e
 h6mZHNXgcnb5qEYHKxqatWMQU2khEwB9i0nOh3DaDrln8aFLfT7nGybHOMYwfnWegB6T
 mjosp/Azzq8m/GMahHAjaZoednDPRSgDgUNgmmmhy9qUNdstIkhQ6vQsVojKZi81Cuat
 lRcIvsiD1qwdE67kIQREI4/juQ8P3Erj7sVDW+Bw6gUbVZvNjz7f9aFuC4GZIxZDT21H
 ec07thruqApXBfphnstXJNG1hGKsg5badBPEjy+9l3Pfdlg9JMPB2kYRHt42LRubigGI
 0qbg==
X-Gm-Message-State: AOAM530e8rQEtUgmMhFY3k3RLW16kQ+kf/t31t8Dlm9rqUZNCMd39dDh
 k6WgSPAzPC2GAmrlz2WGmByUnIiV+Ys=
X-Google-Smtp-Source: ABdhPJyqWN7zNza45G1srCC3ozVw0EDG2fmYljxAg5xpo5m9UjtlsL141sefMeUXtQb7H8NQGJxgzA==
X-Received: by 2002:adf:a557:: with SMTP id j23mr20321683wrb.95.1604313945124; 
 Mon, 02 Nov 2020 02:45:45 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b5sm21118940wrs.97.2020.11.02.02.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 02:45:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3] hw/rx/rx-gdbsim: Fix memory leak
Date: Mon,  2 Nov 2020 11:45:42 +0100
Message-Id: <20201102104542.2064745-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As load_device_tree() returns allocated memory,
we need to free it.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Fixes: bda19d7bb56 ("hw/rx: Add RX GDB simulator")
Reported-by: Coverity (CID 1432307: RESOURCE_LEAK)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Directly initialize the variable on declaration (Richard)
---
 hw/rx/rx-gdbsim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 417ec0564b3..285549c79b5 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -122,9 +122,8 @@ static void rx_gdbsim_init(MachineState *machine)
         if (dtb_filename) {
             ram_addr_t dtb_offset;
             int dtb_size;
-            void *dtb;
+            g_autofree void *dtb = load_device_tree(dtb_filename, &dtb_size);
 
-            dtb = load_device_tree(dtb_filename, &dtb_size);
             if (dtb == NULL) {
                 error_report("Couldn't open dtb file %s", dtb_filename);
                 exit(1);
-- 
2.26.2


