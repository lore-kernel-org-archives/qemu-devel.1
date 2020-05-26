Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C61CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36117204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQYkABkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36117204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddOa-0007vC-Bn
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJk-0006pY-9I; Tue, 26 May 2020 13:24:44 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:45450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJj-0004Rw-Cw; Tue, 26 May 2020 13:24:43 -0400
Received: by mail-ed1-x544.google.com with SMTP id s19so18295103edt.12;
 Tue, 26 May 2020 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4W21aaZREdkuSM60kf8a80KRCL1+S7E7CeXJsG1JSx8=;
 b=BQYkABkJjEjV9C98u2Zf6f/JUND+40YzYHmJ4Z6TOW6foPmOSiYspzoaX9NkhlIhvR
 ljQhrfhe5myXFpJXo4YNmI4WQtjLZnjVbq3/xOini5RsaW+DF+vniktw7qZ5V9/d+oVK
 P+TgO9CxxNQILh20KerSfgGgpQc1+YQjgBSZzIbZTIDWYD9YW7gnUJ5f1LmJ9/YctfWm
 0zka3w1FOy6uBlBp0WFAI0l2x67XLS9hxoh/IYkgQN6y1cRajf6HW5gPWngp+2vVeH5e
 S5hoIbGRTnMbg0g37fa+4EOMNwK72AYvLeIzkBv/yicQKfwEtnlwreupnae31yKm7m+H
 87lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4W21aaZREdkuSM60kf8a80KRCL1+S7E7CeXJsG1JSx8=;
 b=rQ+YxxhkBjXEzTpIPJQui93nEwhEh1UKafCVOMP8PkYAyTkktAHpUS4faLruNYMGDB
 lIkBSdPE2xF31EY1j2ZGF8aTRKEn7z+zx65YCHcezeYO/+wwR3mLrL3S8RX0DnQVbjGU
 5kxeiQOBiip9J7oAlKFG2IpfOxaTSjlouqTZmqdb0Ow/q/T5jnHFODflTQLllmriPBIn
 4iUmPGzjBdIIdYdtAPWxnRLeCGylW9QznLxqCllR5Q/oFjwfDLBsaJyH+SwUGLwj5uVX
 m+diBEOoxJJnsqmI+nZidV2m3ERaycz/wG+yT5pIEmyp69ybuAbn3OTjrZN7pMedJ6B/
 d+VA==
X-Gm-Message-State: AOAM530d/H0qOzy37TGq8j0zQ+S9nqty0RGzvqhN3Z3BpdZgjpcN+LX9
 qqwHeCpe5GyuSEY/ULIQKDp1JmEJ+go=
X-Google-Smtp-Source: ABdhPJzvR5avvOpOZQYK/x/0WJuE4wXAy+JUPQr34XQMnXrAZtyvoLm89VkUPFxSol1G33VslGBLgw==
X-Received: by 2002:a50:d1d3:: with SMTP id i19mr20425145edg.35.1590513881079; 
 Tue, 26 May 2020 10:24:41 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id bf15sm421357edb.46.2020.05.26.10.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 10:24:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] target/s390x/helper: Clean ifdef'ry
Date: Tue, 26 May 2020 19:24:26 +0200
Message-Id: <20200526172427.17460-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526172427.17460-1-f4bug@amsat.org>
References: <20200526172427.17460-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All this code is guarded checking CONFIG_USER_ONLY definition.
Drop the duplicated checks.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/s390x/helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 09f60406aa..9257d388ba 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -42,9 +42,6 @@ void s390x_cpu_timer(void *opaque)
 {
     cpu_inject_cpu_timer((S390CPU *) opaque);
 }
-#endif
-
-#ifndef CONFIG_USER_ONLY
 
 hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
 {
@@ -98,14 +95,12 @@ void s390_handle_wait(S390CPU *cpu)
     CPUState *cs = CPU(cpu);
 
     if (s390_cpu_halt(cpu) == 0) {
-#ifndef CONFIG_USER_ONLY
         if (is_special_wait_psw(cpu->env.psw.addr)) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
             cpu->env.crash_reason = S390_CRASH_REASON_DISABLED_WAIT;
             qemu_system_guest_panicked(cpu_get_crash_info(cs));
         }
-#endif
     }
 }
 
-- 
2.21.3


