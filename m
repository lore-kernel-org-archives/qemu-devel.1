Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B488CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F37C2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2JMuFBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F37C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8puQ-0003dc-KX
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 15:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k8pti-0002xX-El; Thu, 20 Aug 2020 15:06:50 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:42301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k8ptg-0006kz-PT; Thu, 20 Aug 2020 15:06:50 -0400
Received: by mail-qk1-x741.google.com with SMTP id b79so2477342qkg.9;
 Thu, 20 Aug 2020 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W/E8Dbu9GZVPqALWNZAgKCjqUpHU2YYSckRUHq8GROU=;
 b=s2JMuFBrt4QbyXhER11/NM0QMt+ryosW7HElsawIpAsEMLOE12fRP4IRbq+KeHT9W7
 lOegzUenZbYkojK3PU3fHWqA+5aPuD1gjwq3OkYVS8l7grcGJ3NKOcTuMmXM5IJ6dkaG
 P1zB99AinpjePDqVQtbMfnaG7/8QJrU5x6oFz8Y7i8VQN18pahgpmDPqAGzSF+kSrgDO
 ekrGqJr2KBBmL7mTk5z/GJeGLdNsopnOOEPo99tLYa9CtgsXpFFED/t1x11IjEPgSe70
 Um1Gse9apaj6qrMdNPNLlyU8voZrwJxrNaSx05tZlBZpTto+C0Kk/WwHlpg2oHGAEQS6
 PyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W/E8Dbu9GZVPqALWNZAgKCjqUpHU2YYSckRUHq8GROU=;
 b=L728UPs56JZ4dpw158Ig3RX5aEtCKE++R8YKDVNa6pE7zUYTT52HTzlu7mXaKUN0E5
 isFHJCDyrqPgPhPPLp4uXIwVik7W71GUQIleaVmcLU5YTXJfwiRLA6m4zstKy/VZfOi9
 vjBM3ZwBpVqKluFLeSSx0djjZ7tMxj8hkP5L2PlV2MlDhJUZBTjtoK24YHpIdmnPmFau
 tsipa2Jni0cBk0qRJkj7i/dt6oJ9FNVGh1zxMmTNhFnbU/D6OZnoqbsGWgpvtsJonGzd
 nhxNLoxKQRyasszHb7NvinTN0DWYq3hZkDN6rw2Q3Le2q8DljxPMmGcF03B8qNhLFZGU
 TmZQ==
X-Gm-Message-State: AOAM532f3lgLe/RNspLYcdxSg04FFTRMgzuxAkDz429YrnSIEMCCTnCL
 dTt0X+ZfXmZAPbUZsm1YvefV10zBy9Q=
X-Google-Smtp-Source: ABdhPJzIey1BxaF28SWOFTjnVrk1oQbHRbGWKWIJuDjs9ptvDBIjM61WF59+xFRgaRq1lT+odLGkfw==
X-Received: by 2002:a05:620a:4c2:: with SMTP id 2mr3813660qks.80.1597950407123; 
 Thu, 20 Aug 2020 12:06:47 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c152:6ea6:a44d:671e:88f])
 by smtp.gmail.com with ESMTPSA id v28sm4178352qtk.28.2020.08.20.12.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 12:06:46 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] spapr_vscsi: do not allow device hotplug
Date: Thu, 20 Aug 2020 16:06:35 -0300
Message-Id: <20200820190635.379657-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x741.google.com
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not implement hotplug in the vscsi bus, but we forgot to
tell qdev about it. The result is that users are able to hotplug
devices in the vscsi bus, the devices appear in qdev, but they
aren't usable by the guest OS unless the user reboots it first.

Setting qbus hotplug_handler to NULL will tell qdev-monitor, via
qbus_is_hotpluggable(), that we do not support hotplug operations
in spapr_vscsi.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1862059

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/scsi/spapr_vscsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index d17dc03c73..57f0a1336f 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1219,6 +1219,9 @@ static void spapr_vscsi_realize(SpaprVioDevice *dev, Error **errp)
 
     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
                  &vscsi_scsi_info, NULL);
+
+    /* ibmvscsi SCSI bus does not allow hotplug. */
+    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
 }
 
 void spapr_vscsi_create(SpaprVioBus *bus)
-- 
2.26.2


