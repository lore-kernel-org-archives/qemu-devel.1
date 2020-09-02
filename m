Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C286C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C6220758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ChyhqkCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C6220758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYlN-0006u0-KA
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXY-00063s-K9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:57501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXK-0002nj-C1
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599075300;
 bh=37Qg0M6Cgn8RIf6R4DNY3eDMd1YwBtJmIys2nkMm5vA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ChyhqkCZ2aeUHxteYPEeU6+YbD9OjhEaAy/f6SeTsD0HSxQq9mVFBqEAj5CV12LIM
 GBhJ77bq0H76ZwSrqV2blwHOon963XCSfgK0liv/Az8+CRl45y8JBfr/p2gXtCa740
 PjiLbU6UmbKREGWlWdl6FyAF2/XIDgP1UYfaB5rk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.155.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7iCW-1khXk62fkw-014hua; Wed, 02
 Sep 2020 21:35:00 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/8] hw/hppa: Make number of TLB and BTLB entries
 configurable
Date: Wed,  2 Sep 2020 21:34:50 +0200
Message-Id: <20200902193456.29844-3-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200902193456.29844-1-deller@gmx.de>
References: <20200902193456.29844-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eq+qlrFqou3tTLt0tQvecHekV1/8xrWs1MYz7//WVH/aw3St+T3
 fbGEHyY5vLhA+M9MbxYTdjFd/7pon4ImUw+iCD31OB86WxmsUxj0irSbQong3pzPr7D/R0N
 GeU71/x051olHdUwSUx3MU1os0Xs8sNmyMexH5obDfi2jOzEuyCBqjOSYTPxCbHiYYWB//n
 PpxK1cTZqKD/MejkWz+MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4DHgr65x744=:rOA0LBgHUVhu/rDeCVIEUz
 9AG0+Del8VaYOMpldWYGrK8s/tbroCxfSuXzxYPfNsHM9S0XSK1ELJSSBdo7e+0GBHvLphsM/
 +gIRNlLcpaJ7YgupAcxwPCtBIZZOhHJv07kcCSuin3KyObHtgT+eSvFqGTPBCGjb012beSVYO
 c/RcH9z7+Kg70giJtCDMs9NbbLcyX2NmEz7/CZOICkYPDFelNxoDspwqbFGpUgRRc1c6ugyE1
 MtrquHHCq4AgDGb/IBMN9KcfKfVu8efUoFxpocRxf17cb4c/xUWSjB/uwIthNoDLqdUMDAN54
 wV+jPLEyLEmhsGMusGFBsbYrEowuMG8OTU0+TF5VDxF9IZsk2ncn5bxIiqRrrAC/UpOQtZors
 3by9R2jpPdulm4PdUvjdZX2Xos3fbUmM8rq9XaLEqkcb2bR0hHMtvcJ1B+dA3kHYdEU5jWs/c
 V52n7RFbvUUxeVqeD+/ZrcOhhIJrVd36tkggprOXIa7eALyYj7wMEIoOuNSIG978uyxtFO1AL
 wVE5SqAbaTXhRIhUBVwrSD63lT6nTgVx32O3+Jh0IMEcs4u8KjitW/oJUye3LyZIhh5CbzKxf
 o2ppCUin5p2HNj1kgGu7yJkHB65xrLijKjHpgfcFfYbfemw3VwifOi7rSAkMEvba0d5Lngs2q
 Zu4k0BWAL7SlZWlPYB91C7es9sYvyGlrRoVUlPLAwmRHj5uEMQpeztPkJuoTSnVE/g6VDMov5
 n8Bq09UnK+PY5a45HGgRD2bFFSK5g0LPu3NkZ+jYOsih8oSJAb1Yih8WYKius/hL6mUGlogNq
 jzYo7uJEEH99LZMwFpkTZEW2U/6lFFzQfi/VxSVnjg4G3DWP7yU7sPFYno090JVkC+XZMTzGN
 NJO/GBS0NDLw2P5jKCNwuaRqZ7MwxKmNM3eKB3M2s+9NEzo0rFcdbJj+e+r9TLY28C1f6DuE1
 3vJTJMFB3Rb8cMzy+oNE/9zlUWisSeOGrydlRTDgsN8WWeiickdZvHHpECJ5nA1c+1RTeNqUA
 beUwXwNOzAu7Qr5HHanDuoubXWei9MJXC0tK/qfW+9S38afIErBp+T5m5KY2uuNj1Nk4k233g
 5bQcl9OU5mQl3mQzmID3PJgGfXWQKdSrJA0ZIdKBvDmbMB+/ZEJ+eZJEIEadLyAqRonTtxsx8
 V856UadEQd1A5d/zwXt5liE3JG+HVJVI8Ex97iMxAZ8Cbueqf3L3pAz2CuGmS79CL262oP3Io
 QevUCnYsWbShPLY5c
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 15:35:12
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
index 801a4fb1ba..fb6c59d075 100644
=2D-- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -196,9 +196,12 @@ struct CPUHPPAState {
     target_ureg shadow[7];   /* shadow registers */

     /* ??? The number of entries isn't specified by the architecture.  */
+#define HPPA_TLB_ENTRIES        256
+#define HPPA_BTLB_ENTRIES       0
+
     /* ??? Implement a unified itlb/dtlb for the moment.  */
     /* ??? We should use a more intelligent data structure.  */
-    hppa_tlb_entry tlb[256];
+    hppa_tlb_entry tlb[HPPA_TLB_ENTRIES];
     uint32_t tlb_last;
 };

=2D-
2.21.3


