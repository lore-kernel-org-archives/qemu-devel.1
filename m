Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688E4C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6B024813
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEw0364Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6B024813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXr2d-0001xZ-PU
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 15:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXr1e-0001M6-9s
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:22:26 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:37736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXr1c-0008N6-IY
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:22:26 -0400
Received: by mail-ej1-x642.google.com with SMTP id p9so500181eji.4
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9SFWGQzy7DoB1AdG6aiIW/5zMdxght220eg1eHdpHZg=;
 b=hEw0364YT8MS769kJhqX7csgHNHKztfhxQKgq9tyxcWwwCICKY/eoA7BSHw9nk6OsK
 IihoUkMlqmhh5mWLgdeDMdn+S2yCjn7N8SHrtrEwBgyGcR/AcK+k1v636RQZj3U1cUIb
 ianRqi8IesJCC6Y3DzScHekasBhau+KnO3dOM9AKdn8bjUUzKuSmA2OQdAZTTzhC9q1i
 L6PSP39QJSX4U2Ap8jll4S6x01ztuZrUyLJgIq/y2V9xRiZCtwwg7SglNCIHUKVr2r+1
 khXGCE5pyJ11JJ5itPWoFbRBJE9d+hJ+G7rd4/wy+z7zvDHtRvtYWU0Rm8RW21cIpDM2
 w/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=9SFWGQzy7DoB1AdG6aiIW/5zMdxght220eg1eHdpHZg=;
 b=mnPDQuhTY/DuGuMW4yYe1JpAEp4rUp0J4frHXGotMTBM40l0jhBxIlJ8Sapenwt5zD
 wcgUfACoWWsDeZcy04yK1h1exwn8x7jA2ylQGkj8bl3z/1WflniPDyCqUyRnWUA+8Ren
 94cgRKGl4fQ2/XkiLYcqV0AKZx7KKtRcEqdD933+E2AI3NIpSj4N+aySSCoZHpxXbL09
 F17seODemwATpkKqu0+xDR2f3rl+dzXTMKGyhBHmeGIJyJ6Keq5Z6qv1L2kFdflgfCcq
 Ebse5fDW9/fLR+uoIZ0U47jnWU+pweS1CVbkf8aKou4ujAJ8ByBn3ZxmDxxKkt8fcjcC
 FMkw==
X-Gm-Message-State: AOAM531B668b9h2C0tEcpMAxQb7x4hI88I1+tdDjp50Bcp0UkIfPaKVw
 L/tgyDeSmRKpjS0hwYV54jfTYK9Wias=
X-Google-Smtp-Source: ABdhPJzANS6EnXd/CrETXjKkkFmD9ebZiU5CoU49iSmrmJJqdAZ62X8y94HNczhZu9jExuwxi2lYIA==
X-Received: by 2002:a17:906:22c6:: with SMTP id
 q6mr574072eja.433.1603912941651; 
 Wed, 28 Oct 2020 12:22:21 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u18sm227058ejn.122.2020.10.28.12.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 12:22:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] hw/rx/rx-gdbsim: Fix memory leak
Date: Wed, 28 Oct 2020 20:22:19 +0100
Message-Id: <20201028192219.833329-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As load_device_tree() returns allocated memory,
we need to free it.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Fixes: bda19d7bb56 ("hw/rx: Add RX GDB simulator")
Reported-by: Coverity (CID 1432307: RESOURCE_LEAK)
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Peter mentioned this issue almost 2 months ago:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg737946.html

Having helped Yoshinori to get his code merged, I feel the
reponsibility of fixing this before the release. I know I am
wrong, but since he is not responding to the review comments
and we are in soft-freeze, I prefer to do the dirty laundry
before we release.
---
 hw/rx/rx-gdbsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 417ec0564b3..67c413f9de2 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -122,7 +122,7 @@ static void rx_gdbsim_init(MachineState *machine)
         if (dtb_filename) {
             ram_addr_t dtb_offset;
             int dtb_size;
-            void *dtb;
+            g_autofree void *dtb;
 
             dtb = load_device_tree(dtb_filename, &dtb_size);
             if (dtb == NULL) {
-- 
2.26.2


