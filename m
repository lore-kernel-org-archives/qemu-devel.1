Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3411AC433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE8720707
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRPM103u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE8720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2m6-0006r2-6P
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2d0-00018t-Kl; Sat, 29 Aug 2020 11:18:51 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2cz-0005E1-32; Sat, 29 Aug 2020 11:18:50 -0400
Received: by mail-ot1-x342.google.com with SMTP id j3so1758504otk.13;
 Sat, 29 Aug 2020 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XSd6UA9oGJXgO/Kcn28mrye1Vbs4EU3WILT/MQkdqmw=;
 b=iRPM103u4ZZKHaEFmDRJvt+VAJIsRj9fNeEZGzCBpYoBz+d4HF+5AThuaNOf2Jcfqn
 EzkCbCUjw8Kb+XEWJ0j3+xF2jnYUlxMQpxzh2hFy9nBOehtFxWSmzRfjaXP72aijCxdl
 FcStNKlHNkOHkJ9F+OOeGodMY+rF/wwGXV9G12tdPRHstKXx2fnYSlOq1xDWIxpx3Ilf
 c137FI9SFXqX7LWBiPdoRBiu1LRx3ecKZRGXpFdfZVh2nim0GijCzXBCKKgs3KGUzVaG
 y1OjyeRrUF5SplLXGCL8B5+wFZDBM6qSj6dkeFlfVCBNeuQ5koUWhcUAXztBMI46bGIe
 ZFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XSd6UA9oGJXgO/Kcn28mrye1Vbs4EU3WILT/MQkdqmw=;
 b=qyRnVqbNhYdhumThil8DTtQI+52SgCzgeVT0aXDN5BlaX6ScUp5exGGDM1bVxN0j4z
 lKsHmc9OM+uh4nfefmtF3w9MV0wbTnaL0azoJvKcvNkGEHsdp3Fm0ELSb5LhI8lAvCTP
 3Sga9bsDfNNmxtwxYAI6r7WEBdhom1ezMGRRxWbcM/lnp9Ipk8JKC3h+LMzzObp9kFxz
 GLc+dXHMSVxCmO+WU53sA7TOlsVGFRixs+scvaygPNraYDP73TcTJsWIcZ6ITpYRKBff
 tdJ8EZj9RnZ90/gyrUo/zUW+gp9iTaMbMCn+gp/U8NCYiJKz6zimp16EWLyOOPNG2VYV
 DUqw==
X-Gm-Message-State: AOAM5333Oou7/KtZUiaPJ31tEBS8CgI92XYGYfnBg+unMKmw5ixCYXEF
 41rn3M1iYozjbqM41HgFaeg=
X-Google-Smtp-Source: ABdhPJxFJ5+5X/585nlnrqDj/BnFVtTsIdfFQCiS8zzjPqZbTrAVx+1rS/bx/xkMeNHZQVtZobCTJA==
X-Received: by 2002:a9d:4b01:: with SMTP id q1mr2311635otf.15.1598714327353;
 Sat, 29 Aug 2020 08:18:47 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id f50sm58181otf.47.2020.08.29.08.18.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:18:46 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 11/16] hw/net: cadence_gem: Add a new 'phy-addr' property
Date: Sat, 29 Aug 2020 23:17:35 +0800
Message-Id: <1598714261-8320-12-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
References: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=bmeng.cn@gmail.com; helo=mail-ot1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Jason Wang <jasowang@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

At present the PHY address of the PHY connected to GEM is hard-coded
to either 23 (BOARD_PHY_ADDRESS) or 0. This might not be the case for
all boards. Add a new 'phy-addr' property so that board can specify
the PHY address for each GEM instance.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- change "phy-addr" default value to BOARD_PHY_ADDRESS

 include/hw/net/cadence_gem.h | 2 ++
 hw/net/cadence_gem.c         | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 54e646f..01c6189 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -73,6 +73,8 @@ typedef struct CadenceGEMState {
     /* Mask of register bits which are write 1 to clear */
     uint32_t regs_w1c[CADENCE_GEM_MAXREG];
 
+    /* PHY address */
+    uint8_t phy_addr;
     /* PHY registers backing store */
     uint16_t phy_regs[32];
 
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index a93b5c0..d80096b 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1446,7 +1446,7 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
             uint32_t phy_addr, reg_num;
 
             phy_addr = (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
-            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0) {
+            if (phy_addr == s->phy_addr || phy_addr == 0) {
                 reg_num = (retval & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
                 retval &= 0xFFFF0000;
                 retval |= gem_phy_read(s, reg_num);
@@ -1569,7 +1569,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
             uint32_t phy_addr, reg_num;
 
             phy_addr = (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
-            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0) {
+            if (phy_addr == s->phy_addr || phy_addr == 0) {
                 reg_num = (val & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
                 gem_phy_write(s, reg_num, val);
             }
@@ -1682,6 +1682,7 @@ static Property gem_properties[] = {
     DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
     DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
                        GEM_MODID_VALUE),
+    DEFINE_PROP_UINT8("phy-addr", CadenceGEMState, phy_addr, BOARD_PHY_ADDRESS),
     DEFINE_PROP_UINT8("num-priority-queues", CadenceGEMState,
                       num_priority_queues, 1),
     DEFINE_PROP_UINT8("num-type1-screeners", CadenceGEMState,
-- 
2.7.4


