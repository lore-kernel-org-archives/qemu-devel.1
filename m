Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AC7C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DA6206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFhdUo7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DA6206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35181 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpEL-0004z1-6O
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpBi-0000Py-9I
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpBh-0003pn-7c
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpBh-0003ol-3W
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pry6+pV8fUl3y5exktsH4W1Uxi8wrIUzy2x3T/v2sI4=;
 b=TFhdUo7jXxwE5RJBEZavz5j5k4w3O62mzUP7sI+L2WVZANUvPeCygGF5aoW976TbTw7ovp
 vGP1ugJnScUlyRcFg4SUusfNQNZIHQ8WfJ93f9Nvit5526v2ewsY0GnEIDuz2Lbbgbs8j0
 mw8cJPZD4H/n9JUQTRy3fjMZBAhbUuc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-Cxawn8MnP3u-l34Xj_xAew-1; Fri, 13 Mar 2020 14:37:33 -0400
X-MC-Unique: Cxawn8MnP3u-l34Xj_xAew-1
Received: by mail-wr1-f70.google.com with SMTP id b12so4758392wro.4
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GzR0VTVvQsF/hlsamkIvnRsrC8/9iy2Vlr1dz/V+KBw=;
 b=ba7nZKNyKwhFqzwt2Wc5KGN83SpnOaxKcP18MWMfuFSe9Wv6nMB3ArY7B2Z2ixEUMQ
 3RHE6IFJPdaFsE0tKnEphN9GPFm0IFLkLDfdFD1JVDbSHKTJec62yMm+g+tZAMGCW4dl
 Za8/GHWtqhQ3C+Ud2RsFJqj2XQ8lVVO0dMfZuj4W84T7P8GVrhb+DclPkyswpOvxd5tk
 MsF/oxT5TxR0D4wz9SNlDVk3x6fGu+gLyzzT4ta7/H+NWGyqW39ayC2FXGICkq7tUwxQ
 EmwPKoRf/ZIvDChh1j7KFAGB8/kkj5VKPJWfPKw141R3Hw7qkCB1Icf/grZtp3+143JI
 nPNg==
X-Gm-Message-State: ANhLgQ09xwQ1tKNmF0Qlwe1qCbXh8PFkENKqNvyijiYfksTCouTW/3j3
 CrALL7NMCxiA2B/bj6HE8OdPpkIXMfMZnxYcKwmdz5oJQSPFpPBi2L/q7mDbpNOO7fgXB8LWbPd
 tgWijRK1vrEVCxTQ=
X-Received: by 2002:a5d:660d:: with SMTP id n13mr18234112wru.383.1584124651689; 
 Fri, 13 Mar 2020 11:37:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsXUbMgZopATF5ABmIQGcTP5jpwz9bFq/9SdX9Ao7M7bfLF6/N69ygmaZANBNBGhiIuInwKsA==
X-Received: by 2002:a5d:660d:: with SMTP id n13mr18234084wru.383.1584124651541; 
 Fri, 13 Mar 2020 11:37:31 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id p10sm16966938wru.4.2020.03.13.11.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:37:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/14] target/riscv/cpu: Restrict CPU migration to system-mode
Date: Fri, 13 Mar 2020 19:36:45 +0100
Message-Id: <20200313183652.10258-8-philmd@redhat.com>
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
 target/riscv/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c0b7023100..b59e09209e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -475,10 +475,12 @@ static void riscv_cpu_init(Object *obj)
     cpu_set_cpustate_pointers(cpu);
 }
=20
+#ifndef CONFIG_USER_ONLY
 static const VMStateDescription vmstate_riscv_cpu =3D {
     .name =3D "cpu",
     .unmigratable =3D 1,
 };
+#endif
=20
 static Property riscv_cpu_properties[] =3D {
     DEFINE_PROP_BOOL("i", RISCVCPU, cfg.ext_i, true),
@@ -534,13 +536,13 @@ static void riscv_cpu_class_init(ObjectClass *c, void=
 *data)
     cc->do_transaction_failed =3D riscv_cpu_do_transaction_failed;
     cc->do_unaligned_access =3D riscv_cpu_do_unaligned_access;
     cc->get_phys_page_debug =3D riscv_cpu_get_phys_page_debug;
+    /* For now, mark unmigratable: */
+    cc->vmsd =3D &vmstate_riscv_cpu;
 #endif
 #ifdef CONFIG_TCG
     cc->tcg_initialize =3D riscv_translate_init;
     cc->tlb_fill =3D riscv_cpu_tlb_fill;
 #endif
-    /* For now, mark unmigratable: */
-    cc->vmsd =3D &vmstate_riscv_cpu;
     device_class_set_props(dc, riscv_cpu_properties);
 }
=20
--=20
2.21.1


