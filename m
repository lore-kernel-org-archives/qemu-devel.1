Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8E8C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846F020767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="S9E08VBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846F020767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYq1-0008Mx-Gf
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXc-00064v-A6
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:33959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXW-0002w4-H1
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599075301;
 bh=HFMYYgXi0LtEZnRIqLZyX2/D+EQ8XXykoOKUAb4kocc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S9E08VBf5uJbTbxxBTN79npyRvFbvR9sKhc0CNbQlU1ANmkIZVcPVAk+SsadT8TcI
 klul77PNWRJCxqm0qMVcdBec9U7hIxZwbnIOGqDYMMIjLIZck7hVFsLyn7dWmvjwwb
 ZCUPBtGnhtUrk8JjkPnT04pmxSFSmxLaoyuGbjqg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.155.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1kH6uN3SRn-005Lph; Wed, 02
 Sep 2020 21:35:00 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/8] hw/hppa: Store boot device in fw_cfg section
Date: Wed,  2 Sep 2020 21:34:51 +0200
Message-Id: <20200902193456.29844-4-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200902193456.29844-1-deller@gmx.de>
References: <20200902193456.29844-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GhKzRjXf4KHQ+xr/0p5YpEOVabeqd/5OHvRt8msYWeyXIQsWp+D
 9pfdFaUwwGP72p6fHKTyEDOhPxobsSBpzNtZsMvDlsERoICNKDQbBxN+hUuTfk8JRHpX4yX
 y1tO2LPkpMoSUPnZgMaDpS838mSRAKdfDMWSGfJwEqakcKIUAr+KLIekcS19cSXdwRQJw4n
 WI3GM7Kr6RMWSxqyBw8qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b7uCLGaD6z0=:DNkEil+DPi9vfS8bdT7vZU
 wqsoNXxp8iyhBdLCWxpOwr5dN+srOjrbVehiiPix7UJuiZHxLEUkU1dNKdb8G6e63dtvBpWyV
 TDyH8YFPDc/IWbnMnURB+f0E7dpKcrhxtCEU3GXSwxIAueZFk4YjvBec9ZMXzfsJ1M89VvxCW
 7HKGBsZvEl/1TjyKUNhAaS4eslEYNHH1jG5ChRoj17dSN4xw25n/VOHxTIu9NlgzrqsDyeFjK
 D2LMxKM8NYr2xgInTa87Qrl58OXIyUU3ZlKuUA6XNnqM996yQvpd+K0dKWJrZSI/ii7xyiwCJ
 ntnqwUGi6pyElwXQ4iP+w2bfxcB15sDjuaQ9LlX5fy8tNzZZPg0J1quxwbcO0NpnWTRz4fkqv
 QJzIBdBloKo1gePfcyeISLIkID67KIWdt0Wa9bgmQJjN3x+DliQ6+jgwHJqDiDSPbKtBjjSZW
 bBH34zZmD30zXX4eMlQ9DZHQ67Bfdx0v6PMtC8bNsxz64jegO+OW2kFwtxnXVZ3AFePzApwQL
 gGv3rYqW0CzfsuUAje3DkAkkX2nkScx6yQmNLzCKz8lppzlWTnEP2tQFZEWIPR6zO1KzUnMOi
 GWRxHzjLM/+ldFzoIHrB8Ui+lkfgsU95EoXvwOjhXb2QRbY/RXGJ6Y5dVToAf0jDJwJgiWHV+
 zzyfGiQ1N+9YKslpFyy3T7GM4PuomFmGcyCtAllPFsthEiQokXXvg7wzVtpXln6MqKIWehqx1
 OnOuZx4NJWbhhX18MlrNQFZfLLxWG6OCFAl839+4zQWRsLotXqilBkQgAQ1fFWU4sBCEPzogY
 7CgUgBKdLd5xRxQpCWf9hn8gEv1AeqTrl+T4iyiHSDx/qGwoEYxrMPiSNzDzzyQJ0KKo0InZ2
 t8gOXDN2jJG9Tdmx1X96jNtGTX9EHOSXcCdPOM7iltjLPol7IITYWSnFiWzBF4lyYTl23SlVi
 C/f3J2vbiEQ56bI08CCzUaoIO3a7TWJWc7bGRMAz4L6P1jeTHN52eY4qZJI5Q94s+3c5EFCvd
 9gyg+C3fHAuNFVsb4DBpFfEYju0BpdfSEtlTnHYxEyrVI6qBaAY1cgx9FvIx5GWxhELpQew6W
 r0lLj2u2T8g7R3PnpgoMNwyR+rW9nJUv9djdKVRYSHVEMXuezxHH4x4bevmz4htOaXwJgGqAG
 He7k9oRDNkFpLE50GJfvx9rLfp9UgewyKtENiHndqRZZ828pcg5CFHQfbhhDWLcYA+4UpTEpV
 Cd892n3wXHW5wxArr
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
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


