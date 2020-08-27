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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84EEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89FA20825
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g4OY8V7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89FA20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBOlT-0004PJ-Ns
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 16:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBOcV-0007p4-PV
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:35:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:59535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBOcR-0001Wp-3M
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598560521;
 bh=xGoJxgZ7IVup4dbsseRwpe8Ye66tYZj9bPxD1FAfhqQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g4OY8V7Rz6ldWd17ZLLHtmm+nWVF0lYCWnTXxvl/mk/kUO+R+0AYGpvCxW9SnGZI5
 IbAe1Rjos6er7RWoV8fidE6FpJWx/iypMPhi9lP+vNFmw0JoM0LNTkeOMH8CRnc1Ri
 uWogKTLLVSOq8/pGsWxvXYTNuHX3onbPDuYcrers=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.181.35]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1juPzm3emQ-00IGiQ; Thu, 27
 Aug 2020 22:35:20 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/hppa: Make number of TLB and BTLB entries configurable
Date: Thu, 27 Aug 2020 22:35:14 +0200
Message-Id: <20200827203517.29404-3-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200827203517.29404-1-deller@gmx.de>
References: <20200827203517.29404-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SSesNdgd1VaeG+r8fHaitRYIWSzZvR4MREF7LlJI4EzQcAvkt6+
 Yynz9QCIfSKvcTkpZraVFqNKBr+YLe5DYVAIoE8611OivYDSgKIIVnUuk9P7y59JuDjrXif
 kJLL1uUJNQyZGBAMbP6iCRUazKbAezCJxs8OvCRZ76kjzeaSZyegkNLjkl4lTWxchvC6IE3
 41NIkvrSUCc896WENn8xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:riCtzN8e5+4=:TU/FlD8jiuc23GdZRENDXl
 JRVZjVJIfgOp6GABMwAdVNWMH0bTpLmgt2Jjne9mf+ta5WZfD/N/JqX7wyExf14Up2LTERP3M
 JG9WVB0BUhR5hQAjntUMK94afNwts2biW12tCngB70ivEzFNQ4fVWN0iJstY61BRYA/QksPpm
 G13Rz2V1ac8FcDZJfk6tg6RJaX9zWcss9idTzBognfhF+1ZL0gg3lNQCUhTjvhGe+X4GBH3hR
 4vcRycyj22bjY+15XlAiCDuKeVvBV7M6awdpiNW9Vqt/R1MwzJqEykwFMWgU9r7Q7GVPG5Mtp
 MMWbGLZaEGRfAWFfQiP0zYW4nvSeI2sry1yBhWUCEMwVlOeZYEztJcOFotPCF2/3LhlK/Z7QK
 iD6wNz5W7Tpc10aj2GIGLPeukgMA/nwDf1Xn2YPxtLmjxVCHwBCaOUVJcivQ3sb7v8/o8lScM
 /lecQWzhlBAqpSgO3s4CELwr4B4hD2muTZcBTqxlhv75ETH3lTYy3SKRxdiaxPlgmhjoycOiZ
 IZa3kxdf4FbhNnWmIwuaLaAnbQiHjzAdxwWyDA6RCZah23kgwjVZqtlVbYvHk6QsETDBby4JJ
 IElQkvw+LF/WIfO9uFWPrRmjddkBr9mMa8+HOkTULDYqkeif3zCIAkAVkBJyKEWQqYvpsrlO+
 fGp9BLN+1EHB2BxlcGCI9IWFGERRu7+w3+HCnegJqx4A+k4g4D5IOsF77Iue5OP2JeFU71Uo3
 k9VCEWvBAM3IsW/uIPS6NMX4K1KjMhdTDHMj+7geEvQOG0XjNfsJS2Bty1/W9NEzjUFNcNcfW
 a4oaRDmpH+5JXtOSEerl686wLRZNKpEsKBovUy4NjfhhFWppCrX3tF5dQuhctfl/wB/JG4/IG
 XhcfrV/SO4bUQ6tE30Y+68v9HuUTmk23f26AhHfQABwLNtmC4mfU+doXDM4gZ+MMlWqALWPdd
 jpCM9vRUb+6VAXsCXBd1DxPMNa4dcQEvBiKHB5+OcEU42LRirPYQgEf/iNl6sFAtv3GiCXn8Y
 90dL4jxB+hYd50dnm0bfulsvNf6ErqAAHRml+w+Enpg+qGl+zW4Z9Vogo+54w11okCUhTjO/8
 spprPrer899pJiN+2j9Ycy9Mrr0PzpJSnI007Q/e5uXDrLlPtsEhygV+MK+pcD+GhwdV9veXD
 Hl+FRHlPEegW4z3oWf/WtW7oMLKz0l1v0hIApVubg8kumvZ3i1tfQ9vS1FfWPz0MjIVTmCLUo
 PQ7G1WEEF0+WsW+Bm
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


