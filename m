Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489E3C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16688206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM4bxa6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16688206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpKs-0001R9-9U
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpC5-0001Ol-HU
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpC4-00050q-Em
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:38:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36626
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpC4-0004zS-Ax
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMDYkzt1lBUpYc+oo4cCc5AD+w7GESjUgDgAA86mAF8=;
 b=VM4bxa6DRv0uNq5P7wk/GXuYvq9XDuaYSHfKILQslr+GNq9SR7Qawv9pl1H1iqY6H8jQQm
 p/a3rl3ZZkTaHOCyIlzAIxEKjMrPlXyLkf9dxTjuipnkn2e18zIuULy8lcFEc0y8N1lhx/
 umexmI5HMAsi+VmvxHfMdlrvRpFLlc8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-VRkWHfuEMXekQnZrAjC58g-1; Fri, 13 Mar 2020 14:37:58 -0400
X-MC-Unique: VRkWHfuEMXekQnZrAjC58g-1
Received: by mail-wr1-f72.google.com with SMTP id b12so4758883wro.4
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IUJwu5mIghgObyHS7qfpHw05F+W1fo3IIale5ma1lsg=;
 b=VGUH3brrYyImdCzzzt0NPQ2LZt33ThXv6nAYus48ao51ZGSH8JUUPcc1CPADMIYF42
 GRYf/980taCzc3r2thvhpdpWOzzK2Hbacb7m0Twj0tfXBSslF+jImyO5Nrg8Shf/2f7j
 vzEMTFxrXotXUJTVPEhfnnVNDlxdXaIos/wu/P6bsrn3mmA0Fvv1Pr2hbZA1fZgCx9w3
 JR3ImWvy60EmaNDtYx2eyAu2h8Uz/eIeB5MhtKF/ph3yRy3byNwYX03/xulEE7RGHSmZ
 Bq7nCGRt1lwoYXmpyw3mfPrJYh4k/2LenIoxUaMR1vLp4w4ricALdQ8sY/PCVXziFy17
 aY+Q==
X-Gm-Message-State: ANhLgQ3cKJJbzojP79gWFD8iwZQPOHiDspE1qExiloAuuKsYDjqLP7nU
 WCEfzCzW8s/8/bk1jYbu8mqUuDCVOwOvHuqqftx9AvTzQvQL6Vpzo8wTNZlA+29wc0XKbBHuBCt
 v8EooiOObwF5iaw0=
X-Received: by 2002:a05:6000:12d2:: with SMTP id
 l18mr18412656wrx.240.1584124676641; 
 Fri, 13 Mar 2020 11:37:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuQgtDba68GKbgL+OtxixjWPY6YDPO3kDmuQFbZyGRp3cq7WJ2+l5hb5NCjjxv5ygLu7MTvmw==
X-Received: by 2002:a05:6000:12d2:: with SMTP id
 l18mr18412615wrx.240.1584124676447; 
 Fri, 13 Mar 2020 11:37:56 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id l18sm10978168wrr.17.2020.03.13.11.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:37:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/14] target/i386: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Fri, 13 Mar 2020 19:36:50 +0100
Message-Id: <20200313183652.10258-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313183652.10258-1-philmd@redhat.com>
References: <20200313183652.10258-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/i386/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 92fafa2659..a84553e50c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6778,6 +6778,7 @@ static void x86_cpu_register_feature_bit_props(X86CPU=
 *cpu,
     x86_cpu_register_bit_prop(cpu, name, w, bitnr);
 }
=20
+#if !defined(CONFIG_USER_ONLY)
 static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
 {
     X86CPU *cpu =3D X86_CPU(cs);
@@ -6821,6 +6822,7 @@ static void x86_cpu_get_crash_info_qom(Object *obj, V=
isitor *v,
                                      errp);
     qapi_free_GuestPanicInformation(panic_info);
 }
+#endif /* !CONFIG_USER_ONLY */
=20
 static void x86_cpu_initfn(Object *obj)
 {
@@ -6866,8 +6868,10 @@ static void x86_cpu_initfn(Object *obj)
                         x86_cpu_get_unavailable_features,
                         NULL, NULL, NULL, &error_abort);
=20
+#if !defined(CONFIG_USER_ONLY)
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         x86_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL=
);
+#endif
=20
     for (w =3D 0; w < FEATURE_WORDS; w++) {
         int bitnr;
@@ -7180,7 +7184,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc=
, void *data)
     cc->cpu_exec_interrupt =3D x86_cpu_exec_interrupt;
 #endif
     cc->dump_state =3D x86_cpu_dump_state;
-    cc->get_crash_info =3D x86_cpu_get_crash_info;
     cc->set_pc =3D x86_cpu_set_pc;
     cc->synchronize_from_tb =3D x86_cpu_synchronize_from_tb;
     cc->gdb_read_register =3D x86_cpu_gdb_read_register;
@@ -7191,6 +7194,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc=
, void *data)
     cc->asidx_from_attrs =3D x86_asidx_from_attrs;
     cc->get_memory_mapping =3D x86_cpu_get_memory_mapping;
     cc->get_phys_page_attrs_debug =3D x86_cpu_get_phys_page_attrs_debug;
+    cc->get_crash_info =3D x86_cpu_get_crash_info;
     cc->write_elf64_note =3D x86_cpu_write_elf64_note;
     cc->write_elf64_qemunote =3D x86_cpu_write_elf64_qemunote;
     cc->write_elf32_note =3D x86_cpu_write_elf32_note;
--=20
2.21.1


