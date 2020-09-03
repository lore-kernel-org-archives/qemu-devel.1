Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D55DC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DA6206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9V7cdok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DA6206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwzY-0008PC-2G
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLU-00048i-3a; Thu, 03 Sep 2020 17:00:36 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLR-0007h8-HR; Thu, 03 Sep 2020 17:00:35 -0400
Received: by mail-ot1-x344.google.com with SMTP id a65so4001163otc.8;
 Thu, 03 Sep 2020 14:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8VEH4Dp3c4FP61LHXzVX3wMEuap/BOtd0QFnCK48Al0=;
 b=q9V7cdok4+jvmBw6p74YUFba00TvHAIPCkKrjI93a7obPFS+oypdU42wf8bH0ihvta
 jUrehUO7Y9mLttKP2JAa/eNRAy62AkwFipNRbCTRst6/aSqRw0pNt5v6h5Mijr0olDnG
 C7zwt3YZ9+1P9BcU8sPGCG6J6Up6qdu3OmI+/DMqQsOMGw0R3vs0vBqaEY+PzHW2Zn9Q
 CJBs09HVRoYDSqHVJkQmwVLdx8jQOwHjoqQlc0vHq16q5cnGxrbRuR6eBY/Fcwb3Dw5+
 b6LuvfD39zkpsrjgA3JZrcNMna7NlAL7KsrlhbjBHfHJlvRVEd3xjguAD60+rLaTcdxD
 O8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8VEH4Dp3c4FP61LHXzVX3wMEuap/BOtd0QFnCK48Al0=;
 b=Weplk1e+GKFE0IiDUlSzzRq908wTjEFtQmAssSPf3I7i/agC+htT/PMKhKvotcE50k
 HS6Ewz6eE+/zaevUUlehVaQlMi39iDJ4BSW93wK5/1kZJdIXyI+xCaBN5RlASrec5nuC
 8JrChxzvVhiBX3P54U2fj7L5vKKYlPumT8SIxUp5B/+bhQ/JzG0Yulp5pEyO629iTjjy
 6F2eCcUP+WQynVolFb4ZV9k1T8oAKWB0zgNwRaj+zW7MQoyIVmqa+8cK6Tb8bu0nx/qq
 5PPU4i75S0P6Tf+Wx4yaVzFurQnlN40OUx64VUjkDQ9dzLAmACnVayWKRnFHxFOMTrs5
 6jlg==
X-Gm-Message-State: AOAM530Jf4SCpRUk7hJlZ62mGwdDp0IN1JjDfaDX5B2ipFndZidQtfaY
 wPdWsULJqHR2Sg47kksiKba0yQipyps=
X-Google-Smtp-Source: ABdhPJyhKwYIlVPhJa6OKmpPFj8E2qEVFynhQoagjVfkQIELeK3COGKLbkooDuZG9MGQfuIKG1tq6g==
X-Received: by 2002:a9d:7854:: with SMTP id c20mr3028823otm.123.1599166830005; 
 Thu, 03 Sep 2020 14:00:30 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id q15sm761135otl.65.2020.09.03.14.00.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:29 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/77] usb/dev-mtp: Fix Error double free after inotify failure
Date: Thu,  3 Sep 2020 15:58:57 -0500
Message-Id: <20200903205935.27832-40-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

error_report_err() frees its first argument.  Freeing it again is
wrong.  Don't.

Fixes: 47287c27d0c367a89f7b2851e23a7f8b2d499dd6
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200630090351.1247703-7-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 562a558647be6fe43e60f8bf3601e5b6122c0599)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/usb/dev-mtp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 168428156b..15a2243101 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -634,7 +634,6 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
             error_reportf_err(err,
                               "usb-mtp: failed to add watch for %s: ",
                               o->path);
-            error_free(err);
         } else {
             trace_usb_mtp_file_monitor_event(s->dev.addr, o->path,
                                              "Watch Added");
@@ -1279,7 +1278,6 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         if (err) {
             error_reportf_err(err,
                               "usb-mtp: file monitoring init failed: ");
-            error_free(err);
         } else {
             QTAILQ_INIT(&s->events);
         }
-- 
2.17.1


