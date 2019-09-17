Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC42C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7627D21852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2oXNcRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7627D21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAwe-0000HB-Pl
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAAou-0001pK-UT
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAAot-00050A-2n
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iAAor-0004yp-8l
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id y135so2106976wmc.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3dvmDFlr0gurTBYD4r1hBqQhpgoTuiAsAyqm2OCYvPs=;
 b=s2oXNcRXs4zRm+Cg64jZiziq8miIDbQjK8Zgk1ibcADRGU/q5QBeApUuIQQSSqPUvD
 Fk0pr79y+dLrFkh+oiu+WpyCJeoenRSOmeSLqpxi8L4d0kc4rjUL5QbwmVSi+//QHB8G
 +y9+FWryVaZmB7RygOGJKhLfFNxYNxVpNN8vr0lXCSxDS0VgUCn/waQL19EjM1dJuFN8
 zZbFZYrf/trpVGEG2oGE8zKhlIRIM/zqCgdrt7byl8S6ktsirOtaM7Re+ET0keYY5qvN
 dOselpv0W/kTkqQoM1HaMWHm8QPWcxgD5mJwvT72vgBtFcFzR279D7ZatLPFCqnyyosR
 /Ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=3dvmDFlr0gurTBYD4r1hBqQhpgoTuiAsAyqm2OCYvPs=;
 b=NRoj7us2G3azrYTKO/CBWnvJW5QhCF/7d2ltwnh/zJ6h6Y1A3YbnfIdXcuu2c8T1X/
 DoDquP3CUICrtqFRz9YXY7U1ofbtS5upZ/oM0tsrqcQzT9AIkd0TD1kJlWfoB3Ze7hIl
 kjkz2pGg27rR4zVSJvwLZD8BZY6UKsaShBgjxynfVjv8peCaMOjfTXqdDOnHHA1Ubu1O
 kizdl9XvasNdSrbLPoCX3ZZkP3wOfk+FZmI9+vjhBowXGkrTjieRijh/QSjLb/2p9ofR
 aDN7x5cVoqmvYDa8xgB5bGCaRnkOOQ5qXJuPS7h5pl/tGlZyCOIekmu2NH7OchHhSITh
 ZfBg==
X-Gm-Message-State: APjAAAXHa8wGHvNDo9xQg0zDWMoemTw/mTqxX+fJXyjopP2saZO8wE7q
 H2SeyNS9Q6+hTx7/tVPyE5WMhFNT
X-Google-Smtp-Source: APXvYqyz/BWNyZgODxIXEpd034pMPbRh0Ny6gy5XkYYEY9juXVxtVwJtkPAxFDOXqINEP5C71nNHWQ==
X-Received: by 2002:a1c:4102:: with SMTP id o2mr2844823wma.66.1568716487563;
 Tue, 17 Sep 2019 03:34:47 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q3sm1985415wrm.86.2019.09.17.03.34.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 03:34:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 12:34:38 +0200
Message-Id: <1568716480-9973-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
References: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 5/7] vmxcap: correct the name of the variables
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
Cc: liran.alon@oracle.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The low bits are 1 if the control must be one, the high bits
are 1 if the control can be one.  Correct the variable names
as they are very confusing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kvm/vmxcap | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index d8c7d6d..5dfeb2e 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -51,15 +51,15 @@ class Control(object):
         return (val & 0xffffffff, val >> 32)
     def show(self):
         print(self.name)
-        mbz, mb1 = self.read2(self.cap_msr)
-        tmbz, tmb1 = 0, 0
+        mb1, cb1 = self.read2(self.cap_msr)
+        tmb1, tcb1 = 0, 0
         if self.true_cap_msr:
-            tmbz, tmb1 = self.read2(self.true_cap_msr)
+            tmb1, tcb1 = self.read2(self.true_cap_msr)
         for bit in sorted(self.bits.keys()):
-            zero = not (mbz & (1 << bit))
-            one = mb1 & (1 << bit)
-            true_zero = not (tmbz & (1 << bit))
-            true_one = tmb1 & (1 << bit)
+            zero = not (mb1 & (1 << bit))
+            one = cb1 & (1 << bit)
+            true_zero = not (tmb1 & (1 << bit))
+            true_one = tcb1 & (1 << bit)
             s= '?'
             if (self.true_cap_msr and true_zero and true_one
                 and one and not zero):
-- 
1.8.3.1



