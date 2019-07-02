Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18C5C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F01E2146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVan6HDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F01E2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKPe-00006v-OY
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57072)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKIR-0001mM-TX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKIA-0004kM-FW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hiKI9-0004SP-0R
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:01:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id z23so1387011wma.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=R5Ip1smoKNj4Gz4foH6P5aZ/tvv+i40TRFAfsUt7aH4=;
 b=YVan6HDvs+2CBnv/TOb/GRnlznvZ3yXqmULxKB1kCYukZjE+vC9A3wbbN2vacaoeBG
 lurs/emz0SJtyAII/NXf5sfRj9483kNO1zk0PPhRTYqAYpyP4+xps7veHXZkI44LTtmC
 msLnxXxonTeHitA8Py18VnMV5wr13D2dkINtoyUXwSg7WclcjusG82RiejYijPYCXRjJ
 U9AuE32xtfgcNxK8AJ7uNip248b/92SM4OOL6C9o4xS1vN7ewZg5/4HeV2hV7IxZPtXm
 wCqDxT77hMQW5wW7/FWBpIk+t+meXUrUFrvvNvwUz1LbRWzm55t60VpTUNp/890CWOVy
 QNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=R5Ip1smoKNj4Gz4foH6P5aZ/tvv+i40TRFAfsUt7aH4=;
 b=EsBIWmdRn0jHrNUbR/A+4JAyUwmg0/JMx4ev3trf+tu+gO9zFl4dqoXl98SyMooa2g
 +73Ma/Q7+GD7CxtBOW86e1M+6qw40IgAil9++yefmBxrxtFiVoUxN/pXV/ofI+4jBTEa
 Q9F0lCEjG1oQWV+I89v6wLEvIUBXtUMiidfhhP5CH4lBsD89ypOVmc7KrawS9KnyhRSL
 vT1HwGUCa6YAl7+sfJkPAqdAdWqUQpqgvGg4EITtlUyDPHspcHNlSGqLfLmmPPgV/T8u
 U7j2HNifpSU0/uvTsXhG9VvhLt3A87v3Wvi3t7WIcdrcgMZ7oGnsKw3TgyWywdMlilPS
 vdkw==
X-Gm-Message-State: APjAAAXzKF3FoPDDBzSValz3qwRYntbsx/NYioGu8jZqRHylmHWahLlQ
 neuuADS5xUK9Fzd90NOyGFBA1T1CfvQ=
X-Google-Smtp-Source: APXvYqxH9mTUCeZBldOGasTiqmcsQ456sPL7g6mvx0L+areTvmRcAtsqblk3/1JIUo+dy1HBOu0sAg==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr3593148wmb.32.1562079689940;
 Tue, 02 Jul 2019 08:01:29 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id m24sm3006262wmi.39.2019.07.02.08.01.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 08:01:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:01:19 +0200
Message-Id: <1562079681-19204-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Liran Alon <liran.alon@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>
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
index 99a8146..2db6832 100755
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



