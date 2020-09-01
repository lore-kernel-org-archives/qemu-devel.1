Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68417C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A60C20767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HOQkd0er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A60C20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDBPH-0000cC-7B
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 14:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7n-0001kc-AZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:60711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7l-0008EE-4x
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598985296;
 bh=xGoJxgZ7IVup4dbsseRwpe8Ye66tYZj9bPxD1FAfhqQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HOQkd0erSw8VBmKnXABcEPkj4pQQrwtIqy9iovNMqL9r8JVioiQnJTBRHB7RXj99u
 Vg2A01WWnUNR15haoMk3UUldzmBnFeqYxAk3YrWNNs+/oBA82jj8TpXVIh4MT2Zb13
 vh+rav53i5jMlGblJww8b89J9yr4iafnGlG2PgAU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.187.2]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1js54J1KCV-00Lr0m; Tue, 01
 Sep 2020 20:34:56 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] hw/hppa: Make number of TLB and BTLB entries configurable
Date: Tue,  1 Sep 2020 20:34:47 +0200
Message-Id: <20200901183452.24967-3-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200901183452.24967-1-deller@gmx.de>
References: <20200901183452.24967-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pteqhbaMD7DUevAykGOKfs1BkkRbjJoPfRxjkCi1Mff1gaDXWbo
 iHR2URy4SqKBBLY+gR5MBJWg9sTyiNJHjOqZXyH78sFDzPGzs+zfIieoqaajPHFRWP0lc2F
 rvoi9oxcKKqplrN60IjE8f4Hk48esDtqf/PAMP0ua1tqiFaa+rFr/MVxBAZ/gpAtUbm5K9Y
 OIijiH7k7eZYHNt8LpaPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QiRxsTqFS0A=:pBuNa4bwmc4Oh4wEoyDVqW
 D0bXjMht8uwrIMm8TECgOk0+LSBCp4yeWKK1RsNX8sn+4dbj4wxsKeDE1YRxR1j8CV2GVic4E
 luqXt08tCHLidSlYB2KC5FbFpKesnfcotk2HEwtNDj1GRPRsWqaKni6x9sKhqojw4xGzmHOdY
 /G06zTZ2IeaDHc3yJ7vA/PvTiPNk6rpL8z4CHOrtAPSACztsYZPTBw7ha6p6oVwa6GmS/Th8g
 Zn7Ye+81fliB8XMHaM6v1TQyc7Nvr688l6JNSMAH+IFqP+zzqAeTf/addP9rrEN0H2QgTNcHQ
 gQCWoerN36XM3lSgU3w/t+xyjIQrErm7wsD60xVEWcuM5mY2Pod8e2Q9XoEMWCHAhsxGbuD0F
 1qYg7qJn4DX3Wo+VDzehLuoTAK+mq0vzNupcknPzGoVjIq40CGdUzxfaCr+Bs7oW877m+ghwZ
 P7Augujuyx/oXrpWll4GUwcauhERVXFFiiRLfA/5k42fzOcevzSpzO33P105ZNXNeB6gEzJTc
 os7SjWR4GXFsYvod4kjEXJRvWJAJz7iycE1OhCVGcRk75807Hji5k4SidSkYeFn5IP3Q/Ea8T
 ew0MVNtcdrCg31igPGxoqixaSurMyIxPjABWH+z5fbJ0DecvY9npPtrRhPIXeG7sOh009wCzg
 F7lA/BXkf/2a3QO9/qY/Fu9sHVOz/ILpXhDwMAkrJgEEErDCu8zUwqBIrKGFlRmHgNazNPiac
 rbeWF5p/eWbZox6zFMytyU3kOnwsMv+ETufG2cY2FRIwqIM15FLXNP88mNkOdlIEpVWrSZY0u
 r/o/lD3vs6eOQDrcDIyVT1ltcxPcYybmRGwNwaqQkNWE4EufFEtffgZgGJoaCR+4IIfvRXlcd
 yvWfmC5PJmSKR9XvfcclqMsP1Njs48G8OY4zPN1EDHglcxAXYFVq0q5LoUWy7yuVdG5J1aXfg
 oODdwvtFbDHgqdnV9Btc9yDspsGXH5LEOpVg8gdLhQKJSo2ZKRMPYMLTgopUGZ2/eHa/kDght
 rN/fISlJzB7MEAFtLhGMvVa+mHIvrth1pcmNn1P3Ou+Y8HJht9DdjWAOg5ZaxDSZC3frp6LAt
 iJqbbPau+/vbyaim3d/ea01RpmtuVZ4xaXS4d7ffwll5vaq9HJ0Y80QiJ2296Vb8blQJa6pII
 vzD8jiVj+5pFrWNWWbalvjxsqvj4dgRSjGV1byTeALMGg1lX5BIQxyaf34KHCoUaavxIT9pWo
 ahHclfSaftC0nIJqq
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 14:35:04
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Until now the TLB size was fixed at 256 entries. To allow operating
systems to utilize more TLB entries in the future, we need to tell
firmware how many TLB entries we actually support in the emulation.
Firmware then reports this to the operating system via the
PDC_CACHE_INFO call.

This patch simply does the preparation to allow more TLB entries.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 8 ++++++++
 target/hppa/cpu.h | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 90aeefe2a4..e9d84d0f03 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -72,6 +72,14 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     fw_cfg_add_file(fw_cfg, "/etc/firmware-min-version",
                     g_memdup(&val, sizeof(val)), sizeof(val));

+    val =3D cpu_to_le64(HPPA_TLB_ENTRIES);
+    fw_cfg_add_file(fw_cfg, "/etc/cpu/tlb_entries",
+                    g_memdup(&val, sizeof(val)), sizeof(val));
+
+    val =3D cpu_to_le64(HPPA_BTLB_ENTRIES);
+    fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
+                    g_memdup(&val, sizeof(val)), sizeof(val));
+
     return fw_cfg;
 }

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 801a4fb1ba..440104dc3c 100644
=2D-- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -196,9 +196,12 @@ struct CPUHPPAState {
     target_ureg shadow[7];   /* shadow registers */

     /* ??? The number of entries isn't specified by the architecture.  */
+    #define HPPA_TLB_ENTRIES        256
+    #define HPPA_BTLB_ENTRIES       0
+
     /* ??? Implement a unified itlb/dtlb for the moment.  */
     /* ??? We should use a more intelligent data structure.  */
-    hppa_tlb_entry tlb[256];
+    hppa_tlb_entry tlb[HPPA_TLB_ENTRIES];
     uint32_t tlb_last;
 };

=2D-
2.21.3


