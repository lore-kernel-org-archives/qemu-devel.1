Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C9EC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 01:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC6820716
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 01:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kej30fI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC6820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE0cr-00054t-F7
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 21:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kE0bQ-0003m6-Ta; Thu, 03 Sep 2020 21:33:20 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:34037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kE0bP-00063O-CU; Thu, 03 Sep 2020 21:33:20 -0400
Received: by mail-pj1-x1043.google.com with SMTP id n3so4477254pjq.1;
 Thu, 03 Sep 2020 18:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=haFiIuZcpa2HR7b3wPU26vJsTkZCNX1fBT9PCrfxrgI=;
 b=kej30fI+TFjB/ZAxcFVAjiZ2pVbW2AkwM2esVyhKxt/wEPeAxpMfcLBS3lss2he04i
 89mu4m5OaOWX1OkHU3Rju0yZGegaNPvNZSmLe2sklMDYTPU/uWQLSVU3xvAdGNMz+/2w
 hZ9oRFP2xC+RYUoMkY8Fs7KGN3Ikto9YL+Qe5kJnZ8DcuIguLMirac6h4KvhaRyWyWtK
 XdzEGnY4SEnR6Zpfy3o0GKIV8WYlre1RYL69E2SPdeRZJ6fJyQ0jAp05yOwhtt1oKCeD
 Z1oafhlYmVwNeR60VLSCl7qZEXlZdmIGkQWYeZuZMp87AZ2a9bjb8op/eRNzyjnk4Tu8
 +CeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=haFiIuZcpa2HR7b3wPU26vJsTkZCNX1fBT9PCrfxrgI=;
 b=T07fH/pRk8HtBLyrFlqmANlM9QkOEw8Fzs9pRGkzl19OSqTFkoDngr/3uYD6n4hmDu
 zPLhB0cXSLcLwEKOQMtiAMYN5Ws+OyED9YiRcfaHFa8F+XwQ13mPjsKUe4RPUp/jTb+t
 OuP9xCNRtWeKhtroNdaOjTinHh6q0j5CJpshacjbwu/JLBOOG7Y6veNUcjwi38J720hc
 zCyUTULvP7GoCzdDPyDIHcAAwC9dfrOjR7/oo6Wo3iWsROiru8EV6FsDIvX3Y9BlB/k1
 62mp+dWYDsW13zqq0hLHH097f8RNstRGFgi9VBVskf0axYtwcJnXE5hsfeO/HU8GdDKr
 4hIg==
X-Gm-Message-State: AOAM5303RkmQk8cEpc0CZZX+SIPr3Srjhw1oD2ScqGBQCPn9tSFeyymG
 vcIdWe/46g73/4JCdKIZnYg1WbMUpy8=
X-Google-Smtp-Source: ABdhPJxJXCXXuYXkl7nY88SAMwHzen6bD9OkvfoYcMgfN4pOQ+FIf2xkCRnRZJIFj5RXBvxEGhw53w==
X-Received: by 2002:a17:90a:4382:: with SMTP id
 r2mr5636473pjg.144.1599183197261; 
 Thu, 03 Sep 2020 18:33:17 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
 by smtp.gmail.com with ESMTPSA id gj16sm3643158pjb.13.2020.09.03.18.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 18:33:16 -0700 (PDT)
From: Tom Yan <tom.ty89@gmail.com>
To: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 2/2] file-posix: add sg_get_max_segments that
 actually works with sg
Date: Fri,  4 Sep 2020 09:33:04 +0800
Message-Id: <20200904013304.220336-2-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904013304.220336-1-tom.ty89@gmail.com>
References: <20200904013304.220336-1-tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=tom.ty89@gmail.com; helo=mail-pj1-x1043.google.com
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
Cc: Tom Yan <tom.ty89@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

sg devices have different major/minor than their corresponding
block devices. Using sysfs to get max segments never really worked
for them.

Fortunately the sg driver provides an ioctl to get sg_tablesize,
which is apparently equivalent to max segments.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
 block/file-posix.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 0c9124c8aa..d2cd9a3362 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1178,6 +1178,21 @@ static int sg_get_max_transfer_length(int fd)
 #endif
 }
 
+static int sg_get_max_segments(int fd)
+{
+#ifdef SG_GET_SG_TABLESIZE
+    long max_segments = 0;
+
+    if (ioctl(fd, SG_GET_SG_TABLESIZE, &max_segments) == 0) {
+        return max_segments;
+    } else {
+        return -errno;
+    }
+#else
+    return -ENOSYS;
+#endif
+}
+
 static int get_max_transfer_length(int fd)
 {
 #if defined(BLKSECTGET) && defined(BLKSSZGET)
@@ -1267,7 +1282,7 @@ static void hdev_refresh_limits(BlockDriverState *bs, Error **errp)
         bs->bl.max_transfer = pow2floor(ret);
     }
 
-    ret = get_max_segments(s->fd);
+    ret = bs->sg ? sg_get_max_segments(s->fd) : get_max_segments(s->fd);
     if (ret > 0) {
         bs->bl.max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
                                            ret * qemu_real_host_page_size);
-- 
2.28.0


