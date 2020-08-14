Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BAEC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703742078D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw2ORdrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703742078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6csI-0002VR-NN
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cly-0007oU-QI; Fri, 14 Aug 2020 12:41:42 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6clx-0002hX-65; Fri, 14 Aug 2020 12:41:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id o13so4805404pgf.0;
 Fri, 14 Aug 2020 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lLlhx5CzsuWNvvuCgJY3iCdBxbSqBU5q/tvZAS1xP3s=;
 b=Iw2ORdrOHoYtj2DcU/YD+vdQr+l9kZi5aWxxn4XNisZjnS2Q0lJb/MIow7oZQlFHJK
 SNOOsRImVPI2uuaNvGeRWR/9TcqukL+pIqJsCY7BK65Y4cblkgBglU2eAa1QyRrZLjNV
 QOC84d1OOuuZ7QvWWsOVEiOSSDvoeaFklNujaLCeZ2sCupSB4ScaUJlu7vwLrY/Masg8
 FeByPra6l3iGGtcpYjzD7sl+++B+4lc5mhaSpItnVa0/6VAHjhTdZ1d//5WU2LvDIppR
 PpyaMmS7ecTjWbbpBd7ghNjf+n6TV3t00ztddRogjhDCnRbfKLLcuMmt0dJZiPpQ1ahR
 Sg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lLlhx5CzsuWNvvuCgJY3iCdBxbSqBU5q/tvZAS1xP3s=;
 b=aR1dQZuh/VWttQlGfWEnz5RlQZ5wHgJJTHKBmDLzmml21oLgXYvhWjS3uEb4mRKcfv
 ULYxrPuHHDGMaWIRXMGYNTcLA2/U88FTsU982+qURrrAFKl8RIOTN1RXUExub+TBOG+c
 1dbWpDLtiAin+w/ilnHKYET6f1L06EqZxgzptlxcBVs8+H8tz6Nb9YPtNPYukcbD55nY
 MkyF79Ps2160eMP72B/V1da3fLMZS0KO6fWGaWPZd9hj/gC1J0eKiHOlOvmUzqBNDBoj
 si2voxu5OsCqGAprGiTFKp7D9ldzD2XRvWtPfWVkkvloj3UsZtw294YtgtwK94YETV/g
 UrEg==
X-Gm-Message-State: AOAM53291O7Ey8gvTavXGWntRqn2clFDRq8ew6ENS9WIr3xJENkhwo1G
 NO4PQaRDAfmUd5i8okWrFMY=
X-Google-Smtp-Source: ABdhPJyfoqeRpC31wtCCW3DbDXFVAhm+TyzBnXTOW2B6QK04eOjCQ9+1Am6FBWo7VxLEBJlcaUamPw==
X-Received: by 2002:a63:1a66:: with SMTP id a38mr2246103pgm.253.1597423299188; 
 Fri, 14 Aug 2020 09:41:39 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id 16sm9836332pfi.161.2020.08.14.09.41.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:41:38 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 09/18] hw/sd: sdhci: Make sdhci_poweron_reset() internal
 visible
Date: Sat, 15 Aug 2020 00:40:47 +0800
Message-Id: <1597423256-14847-10-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x541.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

sdhci_poweron_reset() might be needed for any SDHCI compatible
device that is built on top of the generic SDHCI device.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/sd/sdhci-internal.h | 1 +
 hw/sd/sdhci.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index e8c753d..b587e8e 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -342,5 +342,6 @@ void sdhci_uninitfn(SDHCIState *s);
 void sdhci_common_realize(SDHCIState *s, Error **errp);
 void sdhci_common_unrealize(SDHCIState *s);
 void sdhci_common_class_init(ObjectClass *klass, void *data);
+void sdhci_poweron_reset(DeviceState *dev);
 
 #endif
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index deac181..20f2fe0 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -294,7 +294,7 @@ static void sdhci_reset(SDHCIState *s)
     s->pending_insert_state = false;
 }
 
-static void sdhci_poweron_reset(DeviceState *dev)
+void sdhci_poweron_reset(DeviceState *dev)
 {
     /* QOM (ie power-on) reset. This is identical to reset
      * commanded via device register apart from handling of the
-- 
2.7.4


