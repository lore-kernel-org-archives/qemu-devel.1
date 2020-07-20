Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB746C433ED
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B37B2065E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGHqUI3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B37B2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxY0B-0001eV-R3
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 11:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jxXu6-00066Q-Tp
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:40:34 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jxXu4-0007zx-S2
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:40:34 -0400
Received: by mail-pf1-x444.google.com with SMTP id u5so9220168pfn.7
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a9YnHrTkXiH8C44WBd636lXCMZWbzBFXi/RmIl5YPxc=;
 b=VGHqUI3ukoUYS6ltpvQraNan3BJNiBVdyW1cFP4mIARnkucXCZbfwZ6JaK/Qb7Uy2s
 hV1qx6SdchRtR3rgCdSJX1LyepF3Fet1Bb++CwftAopMA5agiFqM19GZDCCQgJlIqDPT
 Mq+FyrhFb7SEnVCFDY/mysm6J40uVFz7MXGzJGE/koDEkzs7UeEtfgYWLpoxkdrx2AC2
 DIqJDhXIabiwh4ZtyHz9SU1f96vpDae8Vd92NPylywIKst7bQ5tdPuFlb5CXXgqvfxaZ
 kzblE/iWv0lbTnNlEWSor8L2U87v4QVlJrBqjGop+YfD9Vt/ACidFnlmeyEL06sWGBoQ
 S5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a9YnHrTkXiH8C44WBd636lXCMZWbzBFXi/RmIl5YPxc=;
 b=MQmKha3M65x6u7l11TCo21BDa1fRZeCZsdJwQkKqj+sCY35N34gGS1U2bvC/jrydVw
 oPvBl5brMy/1x5LcYbjxlJe/0c5bLod9Y6twSALtUHTWZH5BIligi3qxGex2Mb62rlq/
 xuXZ7y67sjLlP891WAaYgseujV4r9iG4VrEk0Vw/9868fN2i3bCGmNBteiWA7/2+1tik
 iw3RcqYuUBV5XBB1iteHLIRrDynNjCWq9xmcwyP5g6+YECYqfAcyNpqY2itIa5LeVPko
 c2+B8/g/S88vpQ8qCk92QLCQuDGeGQYigSHLxT4nHZ+UNI2XbsLsoPmlroQOtShclc/6
 GrIg==
X-Gm-Message-State: AOAM5328gAmoRNp4EIq5HOFMnwriNJZYAr7MrRYlNB/jbwCNgXa+zvyq
 KAzDsPjb/+ofd9qYCMDUc7WJOglOEs0=
X-Google-Smtp-Source: ABdhPJzXxP++htERpxU3pyU2aeMz02X7kb/OtNAHz/0bR3kzmWcZIE06k6oq0pZc52jpXaqxSLhABw==
X-Received: by 2002:a63:fc01:: with SMTP id j1mr19580304pgi.0.1595259630394;
 Mon, 20 Jul 2020 08:40:30 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id lb11sm13044042pjb.28.2020.07.20.08.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 08:40:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1?] target/i386: Save cc_op before loop insns
Date: Mon, 20 Jul 2020 08:40:28 -0700
Message-Id: <20200720154028.477457-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We forgot to update cc_op before these branch insns,
which lead to losing track of the current eflags.

Buglink: https://bugs.launchpad.net/qemu/+bug/1888165
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a1d31f09c1..caea6f5fb1 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -7148,6 +7148,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             l1 = gen_new_label();
             l2 = gen_new_label();
             l3 = gen_new_label();
+            gen_update_cc_op(s);
             b &= 3;
             switch(b) {
             case 0: /* loopnz */
-- 
2.25.1


