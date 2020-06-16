Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F6FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8051B20644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXSUv45K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8051B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCkS-0005hK-Pa
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQ8-0002md-1H; Tue, 16 Jun 2020 10:18:36 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:32774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQ5-0006mp-UW; Tue, 16 Jun 2020 10:18:35 -0400
Received: by mail-ot1-x342.google.com with SMTP id n6so16067170otl.0;
 Tue, 16 Jun 2020 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XMRHd9is/niWgVXUxgxGG8bEESpSidVHIXtDD8rfBdE=;
 b=ZXSUv45KNcFTSSEvId9kiq7Q58R4FQCX57m8wemJkY2TTOUxsz3enX3m2AIl231F3S
 POP/r0JcPmoJCDK4/pUdTNpcQ59U69+ruM/IxvIgT7xP2xtc4UQq7OneMqPYZzb4VI2C
 M8dJ9kQ3BuCzh7hzp1AEH9ZkXIS+0N1ikvV6yXixxuYuXL3zjuNVbEJ9DaXGnACe6qXU
 C7TWPHpwxRAMnb1mah8pIor4xKGQfBTeCgrM/1UbxVA1PNzuGwf8tp7v4wX0TRRP36aq
 7FRy+apY/JuE8jarVfqMtcy2tSQ1gFmJYiV36wYy+2JZSncVI9E7x3V6psV4eM6fNDwa
 59NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=XMRHd9is/niWgVXUxgxGG8bEESpSidVHIXtDD8rfBdE=;
 b=bSqiWUirs3bnWf5U10tmueLPKs+Zol+lYqUauyZe0u1qg7ZKq+/AOZ6J1i9VkLvFCA
 FQy24LMWr0hwMWJT5D9Rqyva6haP7yazctSluYpzm1DfjEtHwPbXukF8ZBYCWIxR1HYm
 A0gKVr6kvMPEMFf3D21g5YCnMlLPeviKay3L2zZ+8Q7tzPjczC4p7zeiJdhMyXe6JZ92
 6YpKWAE7MO2S0PV/AiYXClZ4NzyVzR/PugvUHEKmp9AY/L2o/tzjHl/BQYpGDO0+Y8ls
 81M/W9mQoy/iML01Bu2oC4EFT4I+EaE+k1mRj+WXyMfipKysav/aitw4ax2jXuePcmAy
 +N+Q==
X-Gm-Message-State: AOAM531kos1txxBIZl4eOtHQowpb9+Shkirw2TYQO8Dkf1zDTPNYMM8/
 LqolJI2SXZ3o0ghgZ6hlgBq6fXjo
X-Google-Smtp-Source: ABdhPJxN7gOk7YMQ31/g/VoqRcwUllt9eM3MWvlQ7QLC/BD8vsKsn+zCf9Lr+0UPMTFJFnX8MNBLmg==
X-Received: by 2002:a05:6830:1df6:: with SMTP id
 b22mr2615207otj.98.1592317108698; 
 Tue, 16 Jun 2020 07:18:28 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id p205sm4156686oih.48.2020.06.16.07.18.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:27 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/78] i386: Resolve CPU models to v1 by default
Date: Tue, 16 Jun 2020 09:14:32 -0500
Message-Id: <20200616141547.24664-4-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-stable@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

When using `query-cpu-definitions` using `-machine none`,
QEMU is resolving all CPU models to their latest versions.  The
actual CPU model version being used by another machine type (e.g.
`pc-q35-4.0`) might be different.

In theory, this was OK because the correct CPU model
version is returned when using the correct `-machine` argument.

Except that in practice, this breaks libvirt expectations:
libvirt always use `-machine none` when checking if a CPU model
is runnable, because runnability is not expected to be affected
when the machine type is changed.

For example, when running on a Haswell host without TSX,
Haswell-v4 is runnable, but Haswell-v1 is not.  On those hosts,
`query-cpu-definitions` says Haswell is runnable if using
`-machine none`, but Haswell is actually not runnable using any
of the `pc-*` machine types (because they resolve Haswell to
Haswell-v1).  In other words, we're breaking the "runnability
guarantee" we promised to not break for a few releases (see
qemu-deprecated.texi).

To address this issue, change the default CPU model version to v1
on all machine types, so we make `query-cpu-definitions` output
when using `-machine none` match the results when using `pc-*`.
This will change in the future (the plan is to always return the
latest CPU model version if using `-machine none`), but only
after giving libvirt the opportunity to adapt.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1779078
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20191205223339.764534-1-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit ad18392892c04637fb56956d997f4bc600224356)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-deprecated.texi | 8 ++++++++
 target/i386/cpu.c    | 8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 4b4b7425ac..b42d8b3c5f 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -374,6 +374,14 @@ guarantees must resolve the CPU model aliases using te
 ``alias-of'' field returned by the ``query-cpu-definitions'' QMP
 command.
 
+While those guarantees are kept, the return value of
+``query-cpu-definitions'' will have existing CPU model aliases
+point to a version that doesn't break runnability guarantees
+(specifically, version 1 of those CPU models).  In future QEMU
+versions, aliases will point to newer CPU model versions
+depending on the machine type, so management software must
+resolve CPU model aliases before starting a virtual machine.
+
 
 @node Recently removed features
 @appendix Recently removed features
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69f518a21a..54e7f18a09 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3924,7 +3924,13 @@ static PropValue tcg_default_props[] = {
 };
 
 
-X86CPUVersion default_cpu_version = CPU_VERSION_LATEST;
+/*
+ * We resolve CPU model aliases using -v1 when using "-machine
+ * none", but this is just for compatibility while libvirt isn't
+ * adapted to resolve CPU model versions before creating VMs.
+ * See "Runnability guarantee of CPU models" at * qemu-deprecated.texi.
+ */
+X86CPUVersion default_cpu_version = 1;
 
 void x86_cpu_set_default_version(X86CPUVersion version)
 {
-- 
2.17.1


