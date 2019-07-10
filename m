Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057F6C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBED20844
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsbA8+7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBED20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl7cc-0008CY-EU
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 04:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47240)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kernellwp@gmail.com>) id 1hl7Zi-0006po-ST
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kernellwp@gmail.com>) id 1hl7Zf-000056-UR
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:03:37 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1hl7Zc-0007fO-Ay
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:03:33 -0400
Received: by mail-pl1-x643.google.com with SMTP id w24so824903plp.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 01:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H5kKSEsUPQOooKEsuhd2GFcYVA9WoMZPCMVChQ4/8BY=;
 b=YsbA8+7dFdry0hQP7HH+odUFoj404DNdnptRG/rCqLgybyI4CtVtiTge2bNPgVyuq4
 5ivBeLPvO+SaRGqGtprr5+kXRBm2/ukZipkLt/Ja1Dg5beX0cyjgeCbz4Piaswcy8Jhb
 M47Mf/QGHjG4mRJo0FblMeQFp2a7wIEzbKt1bqr28vOsrWXDKOOLEpABtoZ/Fagb4ilH
 FOvSeOldWDme1ntKVKCsh91FWtUDsTpHi7YXUQF38yaz3FBy5wE4PljOiDkY2h/5deZH
 IRtOE9Kbmrwt2scqEGm0vrp2AmCL8Z1A/dvKvVO8LPVMIYCNgiG1JasvGBp4K6ImBQc/
 3wSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H5kKSEsUPQOooKEsuhd2GFcYVA9WoMZPCMVChQ4/8BY=;
 b=fkrzHoEv9VJKC3qucOvpFhya3sURQXjcKxjLc22G7IbylXW6TfWZ2JjLnzNhGorDGr
 +LkKXFjt+6BrpFji7PcDQv03xACPKkan/XOzZYnUkiUCOy5gwhwqRhTgfHz6vhMCLVNy
 ibXEY8pGVNL0nFYes8Z5v+MCtmjE4m30ifJ4c47QHiIxfmDQIqkJrmnpFRkJT0qMSx24
 RdLYrJg9SHdA3X4PpPKZE+KEnW2s7jLgn2d3a36jaZ0L/1r4heSTDaMcv6zS5N1rblZu
 RlK7EDEGxxsw39f9tLsRSE2rwPlIclC/MHOcKC6kMFEAla9NOyHohmSa6t2mhlWeerd1
 NSZw==
X-Gm-Message-State: APjAAAWGvmptubPWdxsQpWDMYEEQFBaqHQlqhJqwSmXwuS6saI3OsLJt
 xIhPp/0foXR8ra1/WvP0I18idmScN+M=
X-Google-Smtp-Source: APXvYqyTovXtpx7Ig98M4UFVhZRe6M4Ue5fe4n/V0XhH99l5Hx/ZcHGSFCGYVz/gBYUHg6CUD26Dbw==
X-Received: by 2002:a17:902:6ac6:: with SMTP id
 i6mr37638348plt.233.1562745776133; 
 Wed, 10 Jul 2019 01:02:56 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
 by smtp.googlemail.com with ESMTPSA id g9sm1058551pgs.78.2019.07.10.01.02.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 10 Jul 2019 01:02:55 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Date: Wed, 10 Jul 2019 16:02:51 +0800
Message-Id: <1562745771-8414-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH RESEND v2] target-i386: adds PV_SCHED_YIELD
 CPUID feature bit
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
+            NULL, "kvm-pv-sched-yield", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             "kvmclock-stable-bit", NULL, NULL, NULL,
-- 
2.7.4


