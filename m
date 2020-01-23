Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB71EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B673A214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyyRQjlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B673A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuevl-0007ox-91
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucr9-0004fW-4i
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucr7-0002z4-8y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:11 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucr6-0002w9-Pu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id t23so2641969wmi.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vwlRLCLCGC2CIZun7e1zwkFYcuHIPNLiExkIa5Xe/Rk=;
 b=SyyRQjlTwKWia6hn8LB2VBZpKGgMpo9uSg5nFZP3ZCZcAF+J12ReVcEN1eBiBxUFMW
 9eYyAUzmxU4/pHs1WXG+HK6Hq9Add3PHqFfFMuokOpeqTChsmjd1/aCGjithbAvw8R/n
 yKUnIWGCXQtUyO2ik5xs3otbYbtLQC9KDj5XvotY+uh3Uf72L0EAXCYpzCd623GX1ovF
 F8Gfw5vfGN74Bk6fLzmyqOQBp7jCI49g6Z9dcnEtPrvp5TSAxVVKnawse377n86iKUAf
 kMTT6xa0T5TDPZNdLfUMq6Z9MLpGwcoBuixya4tpGiUNwBUebsM4T57hBYskkFoyH6qc
 ju2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vwlRLCLCGC2CIZun7e1zwkFYcuHIPNLiExkIa5Xe/Rk=;
 b=kaaqm62MQC6HsiU2h631u9au2jWuZ7X2p55vKyJF6pcEhiD7Dsr0NBN3tphG9BhtyY
 nh24aiSIJcnT+N2bYw8OBblwsUQMvww70fKG4brDtYueut4UF/jH6lESaWC2JyD+ypwl
 5ffe35QLKXXTq051XL58L3ZYVu/PQL7R75iXazRqL+IAh1JLZa8u2d8I9pA4/z0Ym5Qi
 vsqEU6Qg9vm8xuDms/AcJMS2qQr97l8+K45xwA+6Yq3JMlqf7XF+YyY8P2OU3hKw5KOB
 Np/fLqfhV+RLJse0qLxmHkCsPD7xzFhcB1/9Bdgt3kFWeiiohBe6K1WpiLWNc/gwsRe6
 tQKw==
X-Gm-Message-State: APjAAAUtGg3iIpJ8Q9Kq6t41020jW0DsH8bd9lAAY53SeyxHwaBY6xPU
 9KSbj29p6ESqZi0O7cTOCUslBabx
X-Google-Smtp-Source: APXvYqyKX2aqlGGjmgzD57D7bFkDg3dWN4X8byHAKy1Qm9T7/nHCk2kOjxWeQfGi51TvroH+FVTRjA==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr4381121wma.139.1579787346691; 
 Thu, 23 Jan 2020 05:49:06 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/59] cpu: Introduce cpu_class_set_parent_reset()
Date: Thu, 23 Jan 2020 14:48:04 +0100
Message-Id: <1579787342-27146-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Similarly to what we already do with qdev, use a helper to overload the
reset QOM methods of the parent in children classes, for clarity.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <157650847239.354886.2782881118916307978.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/cpu.c         | 8 ++++++++
 include/hw/core/cpu.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index db1a03c..fde5fd3 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -239,6 +239,14 @@ void cpu_dump_statistics(CPUState *cpu, int flags)
     }
 }
 
+void cpu_class_set_parent_reset(CPUClass *cc,
+                                void (*child_reset)(CPUState *cpu),
+                                void (**parent_reset)(CPUState *cpu))
+{
+    *parent_reset = cc->reset;
+    cc->reset = child_reset;
+}
+
 void cpu_reset(CPUState *cpu)
 {
     CPUClass *klass = CPU_GET_CLASS(cpu);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 77c6f05..73e9a86 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1135,6 +1135,10 @@ void cpu_exec_unrealizefn(CPUState *cpu);
  */
 bool target_words_bigendian(void);
 
+void cpu_class_set_parent_reset(CPUClass *cc,
+                                void (*child_reset)(CPUState *cpu),
+                                void (**parent_reset)(CPUState *cpu));
+
 #ifdef NEED_CPU_H
 
 #ifdef CONFIG_SOFTMMU
-- 
1.8.3.1



