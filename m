Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4BBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1374620882
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2Wyi+Wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1374620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCTu-0000VU-AM
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPG-0001Dn-Hk; Tue, 16 Jun 2020 10:17:42 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPF-0006Xl-1F; Tue, 16 Jun 2020 10:17:42 -0400
Received: by mail-oi1-x244.google.com with SMTP id c194so19393110oig.5;
 Tue, 16 Jun 2020 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KqhqPuFMDL4mUgpQ50K5I58H+FHgkQzqbUQkl0uEKsM=;
 b=s2Wyi+WnL/7Lyhbv3mTGD6zBu+dEySqCGJvwWviwomJswetrt6plaqOqz94rV6k9jS
 gLMmT/07jJP5wdhrqFH9xadtqxWWIDl38xfLgYwfYfSaKSLQ6Ab5eQjH9nIhd1mYoZgm
 bNWqhqNJY2cZJhATU6W0iCYWfGruxjt9HwcWF6qGwr8oI/3ljANm4AHoz6uvo7APhb5c
 rC3sAVJ05n+xHlGwuE7mOxoCeG9/N0Wa33+fQI55Qwt3muhEZuxyWNnK/+wm2VXXwNnW
 AqMJN9Nivjq122YF6KfMpufuAT4214qqMxwTkQu2FXVTrc2gqAbf/ibWsBFwQ6/HBMT/
 cXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=KqhqPuFMDL4mUgpQ50K5I58H+FHgkQzqbUQkl0uEKsM=;
 b=bwc+EntRkiTkLKQyeTipThU/Ha4jt1xfNLp3/EJdPZJiI6Jywos/V3oVfE/EQXlnlr
 oXA2CpcD1bnZjhtaQwEQDXh6HJrQP/lcakqvRA+l2CP4AUwsCRJ9R4/Q3nclvjgsxlbW
 LPkCrW7z+Zk93IgwRIVD616JHHs0YZgiEUR5mPIjKyeaN/e+QBtVXz2pQfsddW8uKN7w
 tTGWLsdialFtbWSeeaALYPjWcJdAoBZmq0O0xW9bpa52B0sFmmX4d70+D4vtii2xAB1y
 qloH8zfaAON53H48JCqP4aWjombvfG8+F3ryZqzbsfw57zDvuOv3znU4CCwcEGMwt2KO
 dwdg==
X-Gm-Message-State: AOAM531s/yyaBzmhcG/pBMv6IwA6o8ZDDNJDwkdfBiJ3mYBcbnGVQkdf
 AKlZMhHgbcmdSn1hs5hs+UHo/EDz
X-Google-Smtp-Source: ABdhPJzWhPNIoYIBM3YwltT0TTfJLR/Y4BcCwdIi5LGieQum7sOfEV0iTaj/S1nzhllClS+RGZmLYQ==
X-Received: by 2002:aca:2b0d:: with SMTP id i13mr3665510oik.39.1592317059203; 
 Tue, 16 Jun 2020 07:17:39 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id m20sm4061387ots.13.2020.06.16.07.17.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:38 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/78] hw/i386/pc: fix regression in parsing vga cmdline
 parameter
Date: Tue, 16 Jun 2020 09:14:42 -0500
Message-Id: <20200616141547.24664-14-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Sergio Lopez <slp@redhat.com>, Peter Wu <peter@lekensteyn.nl>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Wu <peter@lekensteyn.nl>

When the 'vga=' parameter is succeeded by another parameter, QEMU 4.2.0
would refuse to start with a rather cryptic message:

    $ qemu-system-x86_64 -kernel /boot/vmlinuz-linux -append 'vga=792 quiet'
    qemu: can't parse 'vga' parameter: Invalid argument

It was not clear whether this applied to the '-vga std' parameter or the
'-append' one. Fix the parsing regression and clarify the error.

Fixes: 133ef074bd ("hw/i386/pc: replace use of strtol with qemu_strtoui in x86_load_linux()")
Cc: Sergio Lopez <slp@redhat.com>
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
Message-Id: <20191221162124.1159291-1-peter@lekensteyn.nl>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit a88c40f02ace88f09b2a85a64831b277b2ebc88c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/x86.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 394edc2f72..121650ae51 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -508,6 +508,7 @@ void x86_load_linux(X86MachineState *x86ms,
     vmode = strstr(kernel_cmdline, "vga=");
     if (vmode) {
         unsigned int video_mode;
+        const char *end;
         int ret;
         /* skip "vga=" */
         vmode += 4;
@@ -518,10 +519,9 @@ void x86_load_linux(X86MachineState *x86ms,
         } else if (!strncmp(vmode, "ask", 3)) {
             video_mode = 0xfffd;
         } else {
-            ret = qemu_strtoui(vmode, NULL, 0, &video_mode);
-            if (ret != 0) {
-                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s\n",
-                        strerror(-ret));
+            ret = qemu_strtoui(vmode, &end, 0, &video_mode);
+            if (ret != 0 || (*end && *end != ' ')) {
+                fprintf(stderr, "qemu: invalid 'vga=' kernel parameter.\n");
                 exit(1);
             }
         }
-- 
2.17.1


