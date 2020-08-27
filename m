Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EADC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45BA320825
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fJZyZnH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BA320825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBOgA-000163-MU
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 16:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBOcN-0007lX-IH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:35:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:57651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBOcJ-0001V6-T6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598560521;
 bh=vw8bGZyavPiuNJqGPu8Pu9oaZpooKHADWrXrJJKoI0U=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fJZyZnH1MW5uUA87T/FI9viuDipNgy+iW12yhC8v2Q1DysuQIQvKu+Sc9VD8cSCZ/
 Pm3khQVOOVpEqNVk+ZzTCqiQl9LQx2LOIkp/bSPBYGBW3ck6ehVpehkBtBuHoFzjUg
 OVLiZ5g1qWTL2e9LMLBIfvy7PNvpxjta7mlps718=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.181.35]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS5A-1kruRX09hS-00kuTa; Thu, 27
 Aug 2020 22:35:21 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/hppa: Store boot device in fw_cfg section
Date: Thu, 27 Aug 2020 22:35:15 +0200
Message-Id: <20200827203517.29404-4-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200827203517.29404-1-deller@gmx.de>
References: <20200827203517.29404-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y+BaNieFhgukXqtpKUmgv+nB7fnoH4zSRllYEicGmQmWPl+buGu
 FO0Fnx5obDUmYWkfb1zvrQwrWCth4CTQsYPQg/tU84JFcIPcTYD+RrHrPt5hOArAPgR6ChH
 MppUM/Gxmb9sRZu8x8zsOOx3LTIEJk2Vjv5BFF24ENNT0CLX6HQhcGk9jYna5TuZhq9jAGo
 vHnQk09mNzDDDWcrY2tRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5NhQpBOEF2I=:Xbijeik0xnGE9PVB3+aMyF
 51Gk2RyLYAITE5c6ORYC44nC0Eu/HyD4/Ev79g96AmokDsju0LUtA2iqVy3RISoYO4SUGOGIM
 UFHsrhBpUkuhf2LcTH64lTyx7TkhWdi9QlZz/n7xE4jZX+NasVZp0rHT3B9FQz/PXoMqqxWzh
 BffWQlwOqrBm3jY51gs9gQGxTLNbcGHp/I8lBqhkHLDJ2yMwLQF2JL2NDQck2jPQsxLW+IeZk
 8j7dAWBTBqoimy3Q1nhQisrzy4B+yNizpVPF2eXnIerAaGHstKICfYUcxCJTB2tnuNN0TVqbv
 k4gwhurAvMG2/qv9JR7fMSlQ55a8peNnnJTwH7EVoJ809WiYmAed9sMfxjDD9htdUzObC/OGt
 zPzy0SAFJF5QftxP5A5IRalZ6AkLwIjGnuZ2YG/Vi6jH6UCouiEbHxHYQ7fDDfbqBtjiWtQgQ
 pEpmZDNppopnlj8eplF06uuc0dpkQOBf1yoVSjY2RNWiOOwEZ8h6RNfygZDWwd5jLN2c1MW+4
 Iik46vGE6FBqGz7kHBZ39BrmQ3y95fpy7jK2ItD7PHflHxmdc3NjJvMl/kiWL3VWYD8Dyzh0J
 +EhBrAxW7uXOtrTGM0Pog1ThWLYduCUvejwjLOQSQRTTcAN074Xwlb1tT/Jx5FVmxhAZRkf5s
 61Os3zR4tnGSOnfoVqGWOOba/zEM0orXi3070Ejex0r964qxAYIDnM+UDwCtjWw7iZGYhxYwb
 fz73BQIsZ4HhXR/z/JiKZZZgeJi8gcoKEQIjp362zX//aA3GvQQBQBeLAUGqH136AvErmUUbi
 5W9oZgyYPzeKDDlI7tBv6TpFB2OxeGpSIzBquUfyqSrXe7YOxQTB5ocb9anWLsrFkMUv1kqwG
 Ys6GpTCDWs3whzX55vbG/lRvnVwCcFXViOfr4GfqQ31cXabrnNu6Av6gVOzp+F39/1bSnhZ7a
 bOYUzmpSZi1h6jETLmxZ9pxqW3VDNPY1cpBm7vdHUCCd9zk2GuChbgH/9r3rs+ohIp8nobbaW
 6i5QCUob9NTPud0fhROXjKrqkL6kXYXQtiAm7JcbAI+kRk5fKnaBWa4XoBAcMbc2hswt7WrLM
 /QkhmQxQMP8tmGA7lZZC2LheCKSG3mSugSIYU+vrRn09CuUALqg/XPGLKdyxPEflOa7eYooat
 7b+UYYxBPtXIVJQvi3Exfg8mY5xxz0c2NDEXPO3xwD1eAPr8GbiH8TShNk2O4K6DWZ9TpXt+h
 leRAfWKaG2mF9qSAh
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 16:35:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e9d84d0f03..4b35afc9d5 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -58,6 +58,12 @@ static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t=
 addr)
 static HPPACPU *cpu[HPPA_MAX_CPUS];
 static uint64_t firmware_entry;

+static void fw_cfg_boot_set(void *opaque, const char *boot_device,
+                            Error **errp)
+{
+    fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
+}
+
 static FWCfgState *create_fw_cfg(MachineState *ms)
 {
     FWCfgState *fw_cfg;
@@ -80,6 +86,9 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
                     g_memdup(&val, sizeof(val)), sizeof(val));

+    fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ms->boot_order[0]);
+    qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
+
     return fw_cfg;
 }

=2D-
2.21.3


