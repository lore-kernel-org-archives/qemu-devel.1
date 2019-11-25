Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF29C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19A320740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5LLO8D0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19A320740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZIs8-0003W7-0N
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 13:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZIqz-0002zP-9P
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZIqr-0007sV-GM
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:12:48 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iZIqq-0007p1-SP
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:12:45 -0500
Received: by mail-wm1-x342.google.com with SMTP id f129so323177wmf.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 10:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k82VDTnAEYMmIBZ+BnV4YO4lxA/bzhPXX8X1cn/DjME=;
 b=L5LLO8D0ZIXD9VJgKCeLS5GTKSXMt7gR7kqMX4lKkxl1upDCGF6G5hoxm7C9jsGYt1
 zpLsq/THglWHS981rvaD2DpxEb7CIfGJCP8IJRl2zAaCwNDbKa8BqqU8VAkMOWhnTddf
 p9hDQoZ/c5JpkRnd48Y+vgTrGQLqtK0Mbh3EIHTCoonF+nXhvIPFD5jQOFty5x1w88HB
 z/LLhkgNNpJiVFVWty5x/R8mGvA6QoSRw8Uo+vpqCtwaSfrhUaRl+hXi4Eys58Nx/n93
 Qm8TK6WfoMchGmGd3Noj6ssDJzQPNRrVxzJHFZOujYGgVbf9rLXCioYhfSnNYYM7TF1t
 e0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=k82VDTnAEYMmIBZ+BnV4YO4lxA/bzhPXX8X1cn/DjME=;
 b=pluJqB3px191AaPVqxsSc7BO64yc89uwy+H4lHvpMpwxm2+6zIFVffsMYLsCHHBOt1
 LrN0I9XCroFDNepM9F85ZmKBxhCGoG/0ckIN0pAq0PwAYJRr3350D1u01qTopZFhQw0S
 zl/8qiapDQLo73nG0eZ6CvNjSmYZhjDLr2Sa7cm/j20eHnZE/MQ4SMprEAK8dUe1X0Vl
 ro8taUmhMMP2c9Zo1FE2wtzI9XKZ06U6s/AFAIFQbZ4TZ9BqdrQaInE70B1jTRZ/imgD
 h4dDmzLhJh/uuWc4ujHx/3tvXzkUVcOiFOAlts5YduEurZBgBKf1B7Kh6K5erTRd9qua
 pF9A==
X-Gm-Message-State: APjAAAUgp/jkemlZgACiEkBiWudAJoZDfekTWRCFNDB46IH0x4bqhdR8
 hKgRNjuDEVvE76Yo8vn3BYFhrqNo
X-Google-Smtp-Source: APXvYqxGHtJ0Gz0EShYjFIn1TIRUuZXCcOH3vyWvwNNa5rF8z7BbC+CuQPBdOR1rQ9EIt1tY/yhijQ==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr194212wmb.38.1574705556859;
 Mon, 25 Nov 2019 10:12:36 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:5454:a592:5a0a:75c])
 by smtp.gmail.com with ESMTPSA id
 d7sm11649717wrx.11.2019.11.25.10.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 10:12:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: add two missing VMX features for Skylake and
 CascadeLake Server
Date: Mon, 25 Nov 2019 19:12:35 +0100
Message-Id: <20191125181235.29204-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: ehabkost@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They are present in client (Core) Skylake but pasted wrong into the server
SKUs.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0f38c82903..3361fe0563 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2969,7 +2969,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
              VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
              VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
              VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
-             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Skylake)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -3085,7 +3086,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
              VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
              VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
              VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
-             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Cascadelake)",
         .versions = (X86CPUVersionDefinition[]) {
-- 
2.21.0


