Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D83C55191
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A4F21569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDkfR8fh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A4F21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRWQq-0001cY-3d
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 03:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWNT-0005De-La
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWNT-000779-6S
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28605
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRWNS-00076k-Pm
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587627270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aaBo3MCsTgkEJPnSWwDmRxTt35ljRTn5VOHhxb4safQ=;
 b=XDkfR8fhQrCg0Y+C+8PrV1OyMUrbAH4j85uPuoQZnwMGmxO/mBXNZFIfRod3t74xRepn5g
 bGH2Zf2QZ0XInby9TTz6H7dsByOEB2LISUYZzMTnjsNkLI5zsarmjuxrgdk6hMl5DjPtMJ
 TiIo91tEwAyYHQXCkanpYFcyXEiSx94=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-oE4xxVK8MHm1Wkx92KbqlQ-1; Thu, 23 Apr 2020 03:34:26 -0400
X-MC-Unique: oE4xxVK8MHm1Wkx92KbqlQ-1
Received: by mail-wr1-f71.google.com with SMTP id u4so2427175wrm.13
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 00:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HRr+Ptr5gqXJ2YHP+feMmdWvwBjwrFcYgrx6heAyn8E=;
 b=Yus5k5b83DSCOAtI+A+oEaQpOj7fFUOkGjgvdFLopETE0u6z8YAC9Tuxf03SmSnXwE
 I2Bl4EVnJxbxqmTdlNGqr/yMqJs3PbvVefVBMS9eI09PBbkhVmknGUEriUzV5HZO0PtJ
 ZoKQIyTFAqOMXmYZwa84n8k/b5DVM623jgMzlTlih57cpQ0PTH/C+Ss7LreMnsDzF12y
 EuYNpksvQTeZHqM70z8ZZdf7jzBvzy8ECmZFqceFwawiHagzei7a1sk7/mdYUQ4R2Iwz
 8rkKupFKc8XboyDbYZp/Sh9lmoMuvIK0GTf5n3l5c3+E9YXaayyMFtuFwWfjNnoC2Nfq
 oHGw==
X-Gm-Message-State: AGi0Pub0GBzZZ4zzxIdo03bFyR01L0CSalzTXRTjTExdcBdBAJEYTL31
 KvVpArKd8Q6ShPm3XN1MUazcWpOoCyoRfQ39lDvJBTDpaMYQ/3/vfuw1cd3t51UKfInzuwxhk2O
 pfZKa0MBtVzPiqSc=
X-Received: by 2002:adf:97d0:: with SMTP id t16mr3135741wrb.138.1587627264985; 
 Thu, 23 Apr 2020 00:34:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypJKbtgWXLU8QHvQ+5M9DwG6Tk50AGo2Bq9rCvQ5JoP2eZ8WLCZiHWwIa46gAeulXDcBGlGGeQ==
X-Received: by 2002:adf:97d0:: with SMTP id t16mr3135726wrb.138.1587627264792; 
 Thu, 23 Apr 2020 00:34:24 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f8sm2442784wrm.14.2020.04.23.00.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 00:34:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] target/arm/cpu: Update coding style to make
 checkpatch.pl happy
Date: Thu, 23 Apr 2020 09:33:57 +0200
Message-Id: <20200423073358.27155-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200423073358.27155-1-philmd@redhat.com>
References: <20200423073358.27155-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will move this code in the next commit. Clean it up
first to avoid checkpatch.pl errors.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 30e961f775..a1e38b38ba 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -582,7 +582,8 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, in=
t interrupt_request)
     CPUARMState *env =3D &cpu->env;
     bool ret =3D false;
=20
-    /* ARMv7-M interrupt masking works differently than -A or -R.
+    /*
+     * ARMv7-M interrupt masking works differently than -A or -R.
      * There is no FIQ/IRQ distinction. Instead of I and F bits
      * masking FIQ and IRQ interrupts, an exception is taken only
      * if it is higher priority than the current execution priority
@@ -1912,7 +1913,8 @@ static void arm1026_initfn(Object *obj)
 static void arm1136_r2_initfn(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
-    /* What qemu calls "arm1136_r2" is actually the 1136 r0p2, ie an
+    /*
+     * What qemu calls "arm1136_r2" is actually the 1136 r0p2, ie an
      * older core than plain "arm1136". In particular this does not
      * have the v6K features.
      * These ID register values are correct for 1136 but may be wrong
@@ -2698,7 +2700,8 @@ static const ARMCPUInfo arm_cpus[] =3D {
     { .name =3D "arm926",      .initfn =3D arm926_initfn },
     { .name =3D "arm946",      .initfn =3D arm946_initfn },
     { .name =3D "arm1026",     .initfn =3D arm1026_initfn },
-    /* What QEMU calls "arm1136-r2" is actually the 1136 r0p2, i.e. an
+    /*
+     * What QEMU calls "arm1136-r2" is actually the 1136 r0p2, i.e. an
      * older core than plain "arm1136". In particular this does not
      * have the v6K features.
      */
--=20
2.21.1


