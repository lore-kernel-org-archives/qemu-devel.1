Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2868DC35666
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 13:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEE520836
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 13:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHxHXUxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEE520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5reY-0004u4-1e
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 08:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rajnesh.kanwal49@gmail.com>) id 1j5oVV-0004Rv-Ub
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 05:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rajnesh.kanwal49@gmail.com>) id 1j5oVV-0008UH-1q
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 05:29:05 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rajnesh.kanwal49@gmail.com>)
 id 1j5oVS-0008Ph-Qn; Sun, 23 Feb 2020 05:29:03 -0500
Received: by mail-wr1-x442.google.com with SMTP id n10so6971231wrm.1;
 Sun, 23 Feb 2020 02:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=TM0po14P+3grtw7weLJ5287+nGsBf+PNGMb9u/cakCE=;
 b=nHxHXUxotyXd+192QWPAnZS9EktplofVyDTTmiAlpiTdTbo45ksNCiJC6nUpIMvsVw
 +psdlSF27kgzBZ7HZbquSnj8TX5vF3y4uzDkP5pc7vAtDCuY9tRhWXYDPrJYWTvQCXLL
 5mvKNQPsTAPxrag6YrnXbatT9h4oHni4pAQZPRP+t9NzbBJEOXpMjrotajecV4FgI9kT
 5hstby1g4nhrg7H9aVZqNdAjxoEu41Zs7EKRoq/xGSQ+hlXSVb6BgOfCh/VV7dG/zD8E
 xScZMq5MazBsF4rQbV0tUTy2h9msbHcNHj3ostPDmyi0JXnas2DLRTE23eLNdgVbE35Z
 TrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TM0po14P+3grtw7weLJ5287+nGsBf+PNGMb9u/cakCE=;
 b=GK71eLskGtSOUMFXiVCPBathiqLRNVBWgMrR8s8IPOup+iT6cT42e0As8oVM0e4Cix
 yXfcdADKbOQjm6mrOtaf+do/IrwEeGHqfnF9dqJXsOjIzXOfim20kXulw4P0rLtq0hEC
 pchbfJupWEg6ywdJYTg6gk2n4YjUzHbl8/bqOf24YG0mFt1bdDrsDaaCHnx9l72LCosm
 TqV3GB/Ck/TL1f0ixyLTiBngIrDFpkgn11cvM78Nq/HCdRS6CA6T8akWCniiSzXHeUK1
 pVWHPdh5tBsygaznYUBZGMemtZbpYS8C3Rebki8SmPeprIuC7NPw96A6wwqCqq6FprWl
 fY0g==
X-Gm-Message-State: APjAAAWa0okD1iQVcSJP+O8j+Eyid09VIXeasktRf4CTLENMBouCbscX
 YmL2FaOEUpRScsq6kTE4+Ta5Yu9b0PI=
X-Google-Smtp-Source: APXvYqx82OMtIH8ebi7iXTWq6xGNGAlF2DH3KrdLfVHwQCozJKklh9Nttz25zeUStmzqS+sLTq1qfw==
X-Received: by 2002:adf:f406:: with SMTP id g6mr60750328wro.189.1582453740307; 
 Sun, 23 Feb 2020 02:29:00 -0800 (PST)
Received: from PKL-RAJNESH-UBUNTU.pkl.mentorg.com ([110.93.212.98])
 by smtp.gmail.com with ESMTPSA id j11sm12723017wmi.3.2020.02.23.02.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 02:28:59 -0800 (PST)
From: rajnesh.kanwal49@gmail.com
To: qemu-riscv@nongnu.org
Subject: [PATCH 1/1] target/riscv: Fix VS mode interrupts forwarding.
Date: Sun, 23 Feb 2020 15:28:06 +0500
Message-Id: <0c4859f90948ba392da456c9e1daf8fde8f5b22e.1582453384.git.rajnesh.kanwal49@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
X-Mailman-Approved-At: Sun, 23 Feb 2020 08:49:50 -0500
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
Cc: palmerdabbelt@google.com, alistair.francis@wdc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>

Currently riscv_cpu_local_irq_pending is used to find out pending
interrupt and VS mode interrupts are being shifted to represent
S mode interrupts in this function. So when the cause returned by
this function is passed to riscv_cpu_do_interrupt to actually
forward the interrupt, the VS mode forwarding check does not work
as intended and interrupt is actually forwarded to hypervisor. This
patch fixes this issue.

Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
---
 target/riscv/cpu_helper.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b9e90dfd9a..59535ecba6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -46,7 +46,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
     target_ulong pending = env->mip & env->mie &
                                ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
     target_ulong vspending = (env->mip & env->mie &
-                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)) >> 1;
+                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP));
 
     target_ulong mie    = env->priv < PRV_M ||
                           (env->priv == PRV_M && mstatus_mie);
@@ -900,6 +900,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
             if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
                 !force_hs_execp) {
+                /*
+                 * See if we need to adjust cause. Yes if its VS mode interrupt
+                 * no if hypervisor has delegated one of hs mode's interrupt
+                 */
+                if (cause == IRQ_VS_TIMER || cause == IRQ_VS_SOFT ||
+                    cause == IRQ_VS_EXT)
+                    cause = cause - 1;
                 /* Trap to VS mode */
             } else if (riscv_cpu_virt_enabled(env)) {
                 /* Trap into HS mode, from virt */
-- 
2.17.1


