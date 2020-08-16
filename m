Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D19C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 02:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF87F2068E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 02:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZFjpJRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF87F2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k78T5-0002AY-50
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 22:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k78SO-0001Jo-Ej
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 22:31:36 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835]:40252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k78SM-0002BM-RA
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 22:31:36 -0400
Received: by mail-qt1-x835.google.com with SMTP id s16so9936087qtn.7
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 19:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F3RWIqKqOWl438yGKydFmhV1PP/93HHyWCr6vW6Op9o=;
 b=OZFjpJRdYd17mxtpqBxOREB47E75Jqjn8tpN/WDwpXepuw9RGAHExYX/Pol9mxaEQt
 EznAF5pzP2ozpIhkaHYN3sGI2kf/vNACRVXGqOTV9As3AGaKH/J8Vkfh3gnSOmZodgKW
 g8LbdlcKXpQyWJaZoVAarEhXKXfwLzmEnLeh5TCC5lvuTtBZ2BhKD0/XXFyjAvfu8jN0
 YOtX4ZEEyOFBzG0KpW7CFkG4N9VC4lfUtx6PHNr/AzOg2ZZoQ4HZH8JgXDSG2vOM6N4x
 8lhfLY4EqzbnPD/YXne92DiVzSfZdv4LxsozpHP9h56/Yho4uW2eI5rko4OoblSSh40X
 F3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F3RWIqKqOWl438yGKydFmhV1PP/93HHyWCr6vW6Op9o=;
 b=B+02hpV5PZwLM2ZD7+mfFjysJkbARPduSH9WSF+DoevAbOJm+vjHue/wajzPO9JPc+
 TLmTWkFDZb5jSRZ1ewZZ3smghqa2yjUU1cYLOgpdjErTEGvacOeXe4kHVRLr0EwK9OSj
 wkX3SADbwrYb6jltOsb824hTS2+jU0yqoGYOWZORMSZqEdJ1aJ1YahaOzuR1S9pRT5Vb
 0ye6CdebB4JDzGBeMEUrgQijBijIVXy04ySv5KexPfYQBEMYUZLc2SquYUkWYmuP7iVo
 FaHWK5ylJdRdkolkfKBRDoj55SRkd4JAqP7AUF5jQOew/Em9XBVbPoTM28yamFY0oPpV
 9uGg==
X-Gm-Message-State: AOAM530mz7mYenDF3zdtAHyndYvHdKvUD4F6iDXYFJ/4fAT6NFhPAy40
 1cKnYExBBHhLGPn5sL0k9LYhEN4GohPfaw==
X-Google-Smtp-Source: ABdhPJywHDAxg52SADrsndD0vQcigDcXPHQBmh2cjrhufZcuI1VPuDzWYey4S3eRHya/eYNIRRyQoA==
X-Received: by 2002:ac8:5241:: with SMTP id y1mr8197690qtn.102.1597545093236; 
 Sat, 15 Aug 2020 19:31:33 -0700 (PDT)
Received: from ubuntu.localdomain (pool-108-35-56-31.nwrknj.fios.verizon.net.
 [108.35.56.31])
 by smtp.gmail.com with ESMTPSA id b131sm12960089qkc.121.2020.08.15.19.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2020 19:31:32 -0700 (PDT)
From: Rohit Shinde <rohit.shinde12194@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] qapi/opts-visitor: Fixed fallthrough compiler warning
Date: Sat, 15 Aug 2020 22:31:27 -0400
Message-Id: <20200816023127.22268-1-rohit.shinde12194@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-qt1-x835.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Rohit Shinde <rohit.shinde12194@gmail.com>, armbru@redhat.com,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added fallthrough comment on line 270 to fix compiler warning

Signed-off-by: Rohit Shinde <rohit.shinde12194@gmail.com>
---
 qapi/opts-visitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 43cf60d3a0..3422ff265e 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -266,7 +266,7 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
         }
         ov->list_mode = LM_IN_PROGRESS;
         /* range has been completed, fall through in order to pop option */
-        __attribute__((fallthrough));
+        /* fallthrough */
 
     case LM_IN_PROGRESS: {
         const QemuOpt *opt;
-- 
2.25.1


