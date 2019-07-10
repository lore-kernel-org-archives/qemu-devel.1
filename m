Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA8BC73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 07:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8879D20693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 07:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2hStThq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8879D20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl7Pl-00047e-QN
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 03:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43067)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kernellwp@gmail.com>) id 1hl7Nj-00033f-Am
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kernellwp@gmail.com>) id 1hl7Nf-0007XV-Bh
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:51:15 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1hl7Nd-0007LL-Qz
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:51:10 -0400
Received: by mail-pg1-x542.google.com with SMTP id p10so833551pgn.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RCpVeCE/4Pt0egKaRjLWSwkX7/NNLaFYtjzmc1Za6/E=;
 b=T2hStThq0FgYyFRRjedpmgyn5E+TZAM84iHvjsi8QvDBFk0Q8Me6QhYCPGNbWqEfdy
 u2rJ/LcoHIZ+4KxilotNFcZiL6DIhOw1A95YXKL/c2oqlyFjH7+e2on4hUq52k1hv26F
 QAlG7glS93v9GSjlMtiTSwfg5B/7bXMOKENB227CIy8MRg824FHF1zvxr3jOjEfVoq4y
 DITfnSSlvGpb0/zTX3EPhU8Gt63K/LV95bTrpD7hxQpsSCH1RxfLI7bFr6Hu48gcZQTy
 Rywp8uW1f1ivdVCtNERrKQt9pLVDfiFKDd/o50AoyApeJYqD7IrD2mF/AVacoUyY9jYm
 P9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RCpVeCE/4Pt0egKaRjLWSwkX7/NNLaFYtjzmc1Za6/E=;
 b=pYRLisL25Ss4GNqVeq1eYq8eJIQazKJLPwWiPx/yVnXHu+qf+x3mfBTIpdKS3hY1Ed
 ccOJwoo+6ax/KFOwCuXEn/eTN2IKzb01LvLnFdqqrauatY7acUZ+bRNdWR9p5rmJ3Rr+
 fRGiig2Ru1493vXWdsaxcU/Q2ZPAI8qMzj47v3Ejpq58/xZEeharF5VZmJC5Xq/53KO8
 MKbVW+YiwG526DneFt1ruMkMz6WqNLzb1BkHdKHUsDhLsLN1/hdMQ7tz7ftGQSZo59ug
 LCz1b1kB1DoCtSOl9+ZxkoVyjdlpdce0W+dBBlCE8Ib/3FDHyglpDnQqvgMG6kb1seGx
 BjTA==
X-Gm-Message-State: APjAAAXUkaAkdo8QMx4k8ekis3OwoEtbtQ2d9R1ZOtlDMbsIGOmVXd01
 no5J7xTa3RZW6WxFG5H7mDoooEGXojg=
X-Google-Smtp-Source: APXvYqyhz2MmI/imwh9JuV0s5ORV8jPe9Asmu6yP3GXced+Otgzqw9r9su1YQIRIHXIgoymkjd+eKQ==
X-Received: by 2002:a65:504c:: with SMTP id k12mr36003400pgo.252.1562745058006; 
 Wed, 10 Jul 2019 00:50:58 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
 by smtp.googlemail.com with ESMTPSA id i124sm3098615pfe.61.2019.07.10.00.50.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 10 Jul 2019 00:50:57 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Date: Wed, 10 Jul 2019 15:50:44 +0800
Message-Id: <1562745044-7838-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH] target-i386: adds PV_SCHED_YIELD CPUID feature
 bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wanpeng Li <wanpengli@tencent.com>

Adds PV_SCHED_YIELD CPUID feature bit.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
Note: kvm part is merged
v1 -> v2:
 * use bit 13 instead of bit 12 since bit 12 has user now

 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5f07d68..f4c4b6b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -902,7 +902,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
             NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
-            NULL, NULL, NULL, NULL,
+            NULL, "kvm-pv-sched-yield', NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             "kvmclock-stable-bit", NULL, NULL, NULL,
-- 
2.7.4


