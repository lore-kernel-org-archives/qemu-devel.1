Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28A6C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA6020726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXC87Tmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA6020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01kR-00005s-TO
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j01jq-0007xq-3d
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j01jn-0006Qt-F9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:23:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33418
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j01jn-0006Pm-2L
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581074634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzCBcv70QrPNpw3LOQg+guLkJNX8BcMWHuMbsoK7sP8=;
 b=cXC87TmgPzDpWBm13bdBhHG+o9nEutARPxlJqcue2Gzwej4PInAd9hNhosNK2kBwJuh58Y
 SH834yhEYPrSIrywg22HDYFQM4+DkLj7w7Q7YIlbue7KDcniXruu6jsQkbi7ONyo0X82C0
 vyvIWs6tuvrZl0ftXGe0u98T9EAlUQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-yYSKT1UVPTqAPvFLKu9tOA-1; Fri, 07 Feb 2020 06:23:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20733800E21;
 Fri,  7 Feb 2020 11:23:45 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30DE419756;
 Fri,  7 Feb 2020 11:23:39 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, qemu-devel@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH] !fixup "target/avr: Add defintions of AVR core types"
Date: Fri,  7 Feb 2020 12:23:38 +0100
Message-Id: <20200207112338.27754-1-philmd@redhat.com>
In-Reply-To: <1581040680-308-9-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581040680-308-9-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: yYSKT1UVPTqAPvFLKu9tOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These cores have unresolved review comment:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg674105.html
https://www.mail-archive.com/qemu-devel@nongnu.org/msg674259.html
and:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg676046.html

As we don't want a bad start with this architecture, remove them.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Based-on: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>

Side note: typo in the subject "definitions"
---
 target/avr/cpu.c | 96 ------------------------------------------------
 1 file changed, 96 deletions(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8a084c750f..b3d661142d 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -216,77 +216,6 @@ static void avr_cpu_class_init(ObjectClass *oc, void *=
data)
     cc->gdb_core_xml_file =3D "avr-cpu.xml";
 }
=20
-/*
- * Setting features of AVR core type avr1
- * --------------------------------------
- *
- * This type of AVR core is present in the following AVR MCUs:
- *
- * at90s1200, attiny11, attiny12, attiny15, attiny28
- */
-static void avr_avr1_initfn(Object *obj)
-{
-    AVRCPU *cpu =3D AVR_CPU(obj);
-    CPUAVRState *env =3D &cpu->env;
-
-    set_avr_feature(env, AVR_FEATURE_LPM);
-    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
-    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
-}
-
-/*
- * Setting features of AVR core type avr2
- * --------------------------------------
- *
- * This type of AVR core is present in the following AVR MCUs:
- *
- * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26, at90s44=
14,
- * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
- */
-static void avr_avr2_initfn(Object *obj)
-{
-    AVRCPU *cpu =3D AVR_CPU(obj);
-    CPUAVRState *env =3D &cpu->env;
-
-    set_avr_feature(env, AVR_FEATURE_LPM);
-    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
-    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
-    set_avr_feature(env, AVR_FEATURE_SRAM);
-    set_avr_feature(env, AVR_FEATURE_BREAK);
-
-    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
-    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
-}
-
-/*
- * Setting features of AVR core type avr25
- * --------------------------------------
- *
- * This type of AVR core is present in the following AVR MCUs:
- *
- * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a, attiny=
24,
- * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84, attiny=
84a,
- * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461, attiny4=
61a,
- * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88, attiny8=
28,
- * attiny841, at86rf401
- */
-static void avr_avr25_initfn(Object *obj)
-{
-    AVRCPU *cpu =3D AVR_CPU(obj);
-    CPUAVRState *env =3D &cpu->env;
-
-    set_avr_feature(env, AVR_FEATURE_LPM);
-    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
-    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
-    set_avr_feature(env, AVR_FEATURE_SRAM);
-    set_avr_feature(env, AVR_FEATURE_BREAK);
-
-    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
-    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
-    set_avr_feature(env, AVR_FEATURE_LPMX);
-    set_avr_feature(env, AVR_FEATURE_MOVW);
-}
-
 /*
  * Setting features of AVR core type avr3
  * --------------------------------------
@@ -499,27 +428,6 @@ static void avr_avr6_initfn(Object *obj)
     set_avr_feature(env, AVR_FEATURE_MUL);
 }
=20
-/*
- * Setting features of AVR core type avrtiny
- * --------------------------------------
- *
- * This type of AVR core is present in the following AVR MCUs:
- *
- * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
- */
-static void avr_avrtiny_initfn(Object *obj)
-{
-    AVRCPU *cpu =3D AVR_CPU(obj);
-    CPUAVRState *env =3D &cpu->env;
-
-    set_avr_feature(env, AVR_FEATURE_LPM);
-    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
-    set_avr_feature(env, AVR_FEATURE_BREAK);
-
-    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
-    set_avr_feature(env, AVR_FEATURE_1_BYTE_SP);
-}
-
 /*
  * Setting features of AVR core type xmega2
  * --------------------------------------
@@ -754,10 +662,6 @@ static const TypeInfo avr_cpu_type_info[] =3D {
         .class_init =3D avr_cpu_class_init,
         .abstract =3D true,
     },
-    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
-    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
-    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
-    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
     DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
     DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
     DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
--=20
2.21.1


