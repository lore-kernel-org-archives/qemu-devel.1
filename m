Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B327DC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52827204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSvrD8vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52827204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBUD-0001lH-FZ
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSc-0008ML-JR
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:38 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSb-0003H2-2m
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:38 -0400
Received: by mail-pj1-x1042.google.com with SMTP id v14so2610899pjd.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R2K3zektrII7VfrfNzLt01qEnMNNGVHrgK9BV7adSRc=;
 b=KSvrD8vdYzJxWS5xzhBF0drtgM0OPz+BC/KpRGNq96z/t7QyiYXPFaND8Oh+kCkL1R
 /m693pd2qxRAJh5HVwTlvgIA4tqXDGEI6KFX9OoBOGODy+2CKs8HujAdaXRIPiXs3uGw
 XnNnYJqUY1EL2m9Z9EkoXSDZrv42FKJP3+bsEIqDiOf2FnjkBqyH+qcFGuPfPqJuS501
 lw+yUZgBU7azu+QNQgOiwwgxUVCNuFOK/tbyNXBhFc1v6bVX90NUTkGjYfS/YPNvQgTY
 VX8cPVmY9gPuthwOEDnl6LZUllU/qIbyKhj2s5PdRn6Z0QAmoX9j4y+t8FIDTnUxRN3n
 p4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R2K3zektrII7VfrfNzLt01qEnMNNGVHrgK9BV7adSRc=;
 b=V956EVF0SOwWFRIFFIzVht146CC1LZs0LAGZPQNYlrrpa9WKx0QbNqeVeqpQOo6jCU
 VepX8pfBfpMarYdBbhsX/6YgvNwgwMknOra4VM21beYiZpnBeip+dcqMgw+fAoLhId1c
 LVhY7FIwUYF4Ej/4MX+I5x3YR5nS7Ov/+HWDBayWXyKmCYlBBlmUOyrE+xXcpFO0lmWa
 /Y7i4GcjhHL5SB0l0igLzqjr+py2BndGnnrs1T/KA0PVRJD6zTyP1LFwowvsZDN7Mqvr
 FmRorEcVpIOYWuU1gOZOd5YRP1lTB0lZlAFVlWYLU/qv+0Sim+kVCyql1UHdGg8UPPcF
 Vxyg==
X-Gm-Message-State: AOAM531bLhFAIXavAXz8fdjB96UI4+NgRhJQXcuYjxX+5uecLcboqKCJ
 X8zfWiHmYoXzdl9D10eh+6TuI1IgrKFm5g==
X-Google-Smtp-Source: ABdhPJxGaYR6NkiO1ld0vL/Dc5DO7E7tZuvcN+oud0qHyLVZR2rT2Kabc03hb0s/Z6TqE0d4NQ+JIA==
X-Received: by 2002:a17:90a:8588:: with SMTP id
 m8mr11403776pjn.91.1600416575196; 
 Fri, 18 Sep 2020 01:09:35 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id j4sm2308784pfd.101.2020.09.18.01.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:09:34 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 2/7] libvhost-user: remove watch for kick_fd when
 de-initialize vu-dev
Date: Fri, 18 Sep 2020 16:09:07 +0800
Message-Id: <20200918080912.321299-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918080912.321299-1-coiby.xu@gmail.com>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=coiby.xu@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the client is running in gdb and quit command is run in gdb,
QEMU will still dispatch the event which will cause segment fault in
the callback function.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 contrib/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 73732b928f..5fdfa64294 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1909,6 +1909,7 @@ vu_deinit(VuDev *dev)
         }
 
         if (vq->kick_fd != -1) {
+            dev->remove_watch(dev, vq->kick_fd);
             close(vq->kick_fd);
             vq->kick_fd = -1;
         }
-- 
2.28.0


