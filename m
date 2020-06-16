Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9367EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6596220644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuC3QgdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6596220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD6i-0008J2-It
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQy-0004A8-Ge; Tue, 16 Jun 2020 10:19:28 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQw-00071X-S1; Tue, 16 Jun 2020 10:19:28 -0400
Received: by mail-oi1-x242.google.com with SMTP id s21so19371882oic.9;
 Tue, 16 Jun 2020 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4th/1Paxx9afMaB06sbfxHi7/R5Y+YQCpXI6dbC8fig=;
 b=EuC3QgdI1032Fdah8iGAenrSBnmrTivos7ZlFA82iW61CF+n4QyRv+8AtEcsskD4Ie
 5a4hRcxzarlwYmJ1B2a4C3MXYbs7upBecsAUh7cFLJSC7a644Pix8CgEaFSf95FXVav9
 Qi4HwlBy5BOjNF8DhbT4PVeP+YlDmf0jgGAcFLg5+kcmGfIrTynpjwvJEms/+S2ZUSCf
 lXI6gLtVc8ILeF/zrpnTYrIRZ/p70V0UPUs7X3inJzYM+Wkr4bfjBQ44J8wHaJMrVTsU
 zHZPPeWP8R1HmVAs5N2M8X3E0G/w6sqYLWoXEyAI2UuRhzLudQQY6vnJnkUIEV2iWGP2
 z/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4th/1Paxx9afMaB06sbfxHi7/R5Y+YQCpXI6dbC8fig=;
 b=VyEv9gNTT1u3WXnzfYTAe+ee5UNa72/chUVEKk2PnLC6VM9+c7KBgLDBrgqtMcqff3
 ZyCCXMbbyrOgH+MO8mHipykX4SsOqYDSa1jNGr3TC0cHu5EgTHM8PMZV0pVpJAOTFH8p
 Pg4VseXmXPNAetLWlS63DM9GW8g55tTVmGwo9n8Klteam/+/gPOGnbLv3NVzI+ejDcoN
 7tMyVKPd2L326PBUavD2ooi6ROBvMWzg1vQVT3BJykt6+so52Q/+PdZ9pEBRXQQni1mO
 7nQQ5FQkofNzkwJYKHvcfIxVZqw6fkFPAH4CqMRnvnToR5OQ0T+KJtM/aq91PrX3hM/O
 ZAxA==
X-Gm-Message-State: AOAM533njVHJmmaLM6DjR7lP3dBbR9wZDm8wmZ7d4CDcgGhj8bd2doO8
 YzZA8s17UGqW6UA7vb7byxioTMq+/9o=
X-Google-Smtp-Source: ABdhPJyJ9i3fD/IYbNRvWq7d49O7DpYeRbTyTeiILXBPO5wbubRhwAUKmJJEjvpYQqUtQlzjn7ImLQ==
X-Received: by 2002:a54:4d96:: with SMTP id y22mr3269197oix.55.1592317164853; 
 Tue, 16 Jun 2020 07:19:24 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id h27sm2129255otg.23.2020.06.16.07.19.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:23 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 67/78] vhost-user-gpu: Release memory returned by
 vu_queue_pop() with free()
Date: Tue, 16 Jun 2020 09:15:36 -0500
Message-Id: <20200616141547.24664-68-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x242.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

vu_queue_pop() returns memory that must be freed with free().

Cc: qemu-stable@nongnu.org
Reported-by: Coverity (CID 1421887 ALLOC_FREE_MISMATCH)
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 4ff97121a3ee631971aadc87e3d4e7fb66f15aa8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 contrib/vhost-user-gpu/main.c  | 4 ++--
 contrib/vhost-user-gpu/virgl.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/vhost-user-gpu/main.c b/contrib/vhost-user-gpu/main.c
index b45d2019b4..a019d0a9ac 100644
--- a/contrib/vhost-user-gpu/main.c
+++ b/contrib/vhost-user-gpu/main.c
@@ -848,7 +848,7 @@ vg_handle_ctrl(VuDev *dev, int qidx)
             QTAILQ_INSERT_TAIL(&vg->fenceq, cmd, next);
             vg->inflight++;
         } else {
-            g_free(cmd);
+            free(cmd);
         }
     }
 }
@@ -939,7 +939,7 @@ vg_handle_cursor(VuDev *dev, int qidx)
         }
         vu_queue_push(dev, vq, elem, 0);
         vu_queue_notify(dev, vq);
-        g_free(elem);
+        free(elem);
     }
 }
 
diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 43413e29df..b0bc22c3c1 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -519,7 +519,7 @@ virgl_write_fence(void *opaque, uint32_t fence)
         g_debug("FENCE %" PRIu64, cmd->cmd_hdr.fence_id);
         vg_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
         QTAILQ_REMOVE(&g->fenceq, cmd, next);
-        g_free(cmd);
+        free(cmd);
         g->inflight--;
     }
 }
-- 
2.17.1


