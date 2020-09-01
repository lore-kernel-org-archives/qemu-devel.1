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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5A3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAE320767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JBQwzPAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAE320767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDBI6-0006nQ-5u
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 14:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7l-0001iZ-OW
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:49869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7i-0008Dg-Av
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598985296;
 bh=vw8bGZyavPiuNJqGPu8Pu9oaZpooKHADWrXrJJKoI0U=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JBQwzPAuJpJyfsEfmtyTJPi7g2POkVV4cotISU7cdrikbkVfBUm5n38moNPslSgsJ
 +x08gAWD26EKS0Dxsnm+o2dFfr4/jYpO7sr5zgx2ZkXlMz+tDQDODS4JCd4FxPr48f
 koClgYWro1qQ33tUGoggNlYPeEeaJXZr+cb4iirc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.187.2]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1kHYpc1qHg-004RFL; Tue, 01
 Sep 2020 20:34:56 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] hw/hppa: Store boot device in fw_cfg section
Date: Tue,  1 Sep 2020 20:34:48 +0200
Message-Id: <20200901183452.24967-4-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200901183452.24967-1-deller@gmx.de>
References: <20200901183452.24967-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MxtCg/LyBZXTgnO42TujnqCuaFJ19+UMg539NSzGgSEqd5cNt02
 cjCzyytQDd6BYhYDssuByGSexWOjStAgUxYPMxEtYNbQvKscFDD42MrbUDEiwNCDVgEdGLZ
 b3ain4UNDrBNjuh10DfrfLhKzaJMyb5PagVcsJnc8+wzBYlAN/GV1ugSPn0IlcH2MU7SOro
 aPPzSuYWFyd/wNAVnfJmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SBkjwtQO7y0=:BKsZWsrNhgN7mboytvvLL4
 u6OytDN0FjlvVOr5Cd5ipSG1r4PcgERwFg8lYIVHWVklVAK15B/4VVYz5UMhkubqhcrs1C33f
 zVY9OiAiQOKU6NimY1M1HlkhXtPTIxKnYvFUzhic4DnfdClFi0rGGHcHRBPUr33nRPYABKdWo
 Y3nuNEwI/dWeKQryYcvQYbFW5ZCgMjDpY+euTvXS3zxpaRbLLlRkq7TJBU5YDU9sQx8IJ+I4G
 s6nV8LF7r5l1AXcbtV/oenzjEa+WGhx9b12aiRznqwG3hb609CF0zA/yaFlhASRUA16oMNEoD
 O+w2SPssuNO9RRPl5GKkdHQjTlM/oY5wGJfm7lKxxr97yyz/hs443vAwu9Our9FdbRO4Y7vs/
 GpTFUy4sZVEGAkxEx5d1mgMzyg2yllql64VeFqJdKPltyvJ8Y5kzERblBAntaPiDZNJorKTmx
 nCoP4mnIjeYPit76I7JE+K2b333u1PfU1TtxmBBJntD1UQKc43+HgktbB+NhsAIxAwfJbIAg1
 fQE6UNzDFjg6kGKMURYmOfKktj/plvwq7dRMiGdedGrjbPx6prqe9pHvXErGHHk4ufjGu5+wq
 aMyI2L5MZO4XZiuCWZbuZ3+0Hhejj8jmytamAfIAOXcRN974FjzO/PTipiv56qekw4KX+vugJ
 Fvmrndzm1yyDDgRXa6p7M1Fe5znH/YqW6wUjfjeWKqBJrgr1nO/zDvFDs9P7uBuX2JTf0VmTI
 96Qcmedc8I3DEXZBC24dAlkpZbFBDcdv38xb+TKvUnUr8VzR7CVeLZt+KOjeQQuabDXa6eUdI
 orjxfl3JWPpisGqbB9kXcGpSqywODge2ClfSrv1Mmhy/SXS0Oh4w/TAaT+P6nvBq9T+pKcA/S
 j3zRJOCZj9l+fqSp4fs41QEankT6ch9JKw5kkuD0FwiEmoCa58vXFG9WjtFNbFXpWY+08OgqR
 DPJJfpbjEmJYJgBU+rBntRgAjPgHI63yYIGNS0Wl1z2uCXQJh3IjOM6w8JFgyZP6v2e0q2ZzW
 O7sJp2++UDthRJkD7TZnKy8rqDYwdRFcJkON0zzvopMmjIlsdspahc0UnYrqR3N1CZauXh5tk
 Tb6noAkaL7I0gGW+0AQTbUwHdUVy5UvX5YSDfrbonpbrhwaDTkFBjtHhAra+zHpYVm/mfZueh
 J0nSuSbPVV41WyHBuCkC/SfamNVQ64jg/+x9gJFHDlwbiFtnp5OyGlm2ZGh4a7RgbDtPXhBys
 IS3D0JEZs61wvMPkC
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


