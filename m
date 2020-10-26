Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B691C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E43A22400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hni.uni-paderborn.de header.i=@hni.uni-paderborn.de header.b="Ewm4ZLGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E43A22400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hni.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX32D-0006iY-Cm
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peer.adelt@hni.uni-paderborn.de>)
 id 1kWtjh-0003Bz-03
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 00:03:57 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19]:59924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peer.adelt@hni.uni-paderborn.de>)
 id 1kWtjc-0007Si-3q
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 00:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=hni.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z7HpJB4AR+Ce+6NuYNWu8cOHXkqB59L9e6aPGGx44Ng=; b=Ewm4ZLGhGd3sBZcKckfnD7o+uD
 5E/pswWQIs+TORYvERXk0Y5S3g1wirWocE5wMQ8TPfKTlFpDfZgDZk02eY25QSJvwVtlgdlfnBTcH
 S6L43LlTZByOdN1iWYORTLL0SxK09GwIxUugXZ/3+uiDdIabfMMstCg4/XQrXySCqid4=;
X-Envelope-From: <peer.adelt@hni.uni-paderborn.de>
From: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] plugin: Fixes compiling errors on OSX
Date: Mon, 26 Oct 2020 05:03:01 +0100
Message-Id: <20201026040301.72054-1-peer.adelt@hni.uni-paderborn.de>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.10.26.35418, AntiVirus-Engine: 5.77.0,
 AntiVirus-Data: 2020.10.26.5770000
X-Sophos-SenderHistory: ip=37.24.125.142, fs=44179600, da=91294088, mc=249,
 sc=2, hc=247, sp=0, fso=44179600, re=0, sd=0, hd=0
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=adelt,ou=People,o=upb,c=de
Received-SPF: neutral client-ip=2001:638:502:c003::19;
 envelope-from=peer.adelt@hni.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2020 09:54:52 -0400
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
Cc: Peer Adelt <peer.adelt@hni.uni-paderborn.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Removed the following entries
 - "qemu_plugin_register_vcpu_mem_haddr_cb"
 - "qemu_plugin_ram_addr_from_host"
 - "qemu_plugin_hwaddr_to_raddr"
from file "plugins/qemu-plugins.symbols".

The exported symbols do not seem to be defined anywhere and cause
errors when linking under OSX Mojave and Big Sur.

Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 plugins/qemu-plugins.symbols | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 4bdb381f48..40b4ff3821 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -8,9 +8,7 @@
   qemu_plugin_register_vcpu_insn_exec_cb;
   qemu_plugin_register_vcpu_insn_exec_inline;
   qemu_plugin_register_vcpu_mem_cb;
-  qemu_plugin_register_vcpu_mem_haddr_cb;
   qemu_plugin_register_vcpu_mem_inline;
-  qemu_plugin_ram_addr_from_host;
   qemu_plugin_register_vcpu_tb_trans_cb;
   qemu_plugin_register_vcpu_tb_exec_cb;
   qemu_plugin_register_vcpu_tb_exec_inline;
@@ -32,7 +30,6 @@
   qemu_plugin_mem_is_store;
   qemu_plugin_get_hwaddr;
   qemu_plugin_hwaddr_is_io;
-  qemu_plugin_hwaddr_to_raddr;
   qemu_plugin_vcpu_for_each;
   qemu_plugin_n_vcpus;
   qemu_plugin_n_max_vcpus;
-- 
2.29.1


