Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEB0C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D204720658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpV1jA0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D204720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpNp-0005pe-0T
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpCH-0001jl-B7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpCG-0005MO-7C
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:38:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59590
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpCG-0005Li-3s
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jc8uJI+fsWVnbFhna2J0NMxSMRDSs2zyN/X211eVidg=;
 b=SpV1jA0tXgvUa77PO6hYPhCjWVtlRLPl5Wm6Xs0ZaWl2JyJrpxioEPEXWg+wPXsKrzacv2
 dUb7a0QvyR8Z5uJgCNMJ6bHpIJzzN8x/bFIOx8qMHHkDNad5wSvcLZSpZ/xJqM59LfAU0B
 a/ITmn5CLHzJufI2yMNjs7a4hr42N8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-mlC3S_BPOHuHagFc_wpHuA-1; Fri, 13 Mar 2020 14:38:08 -0400
X-MC-Unique: mlC3S_BPOHuHagFc_wpHuA-1
Received: by mail-wm1-f69.google.com with SMTP id a11so1368835wmm.9
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oL9lM1TjQ9zbVx8kM0/Y3ow0t+KGUtP0TdO5NgiCTHI=;
 b=mrDSz/yyKJ+1g2wO+8s0H/K3mzjnsDVhLUimpM8xJS1L/cImJhlmqhpw8m6x3f97ix
 fJfEh4f+eeMoSFi1WHfmP/qa1wEIAXWbI62sWolG1jfXYSkoSJ+gX5aU/UAxpkIxn4H7
 ou0qNOkf8BhCVY3wX7qv/96LqsirC3RuY1IKkRdeh4v4hjdvqHTOVXGmVkt4GS7ITkLS
 aNaki2W04Em4yZyjPCQmKtE6A7GB3IEGC/kcrQRf26gslrwhhSs7H7pP8rj3Gx3YiYCv
 nKLd5fmO++Ak61lvN+5qges8UuKBavuxhgnMEG8nyjj9MSyLLyBg7fJrE67Sehz24abG
 XhPw==
X-Gm-Message-State: ANhLgQ3t9eUy/f9HmGjKQz01cNxKMkq5tS7q70XE7FiJzPsBc06HL4J4
 3blwk/E55atIoEMWQCO21n075GlM/mqu0s5+0PfeSxbvWpaNYqd3E8Nsr8o+fQ67SslQa8UFnkx
 uI34lRhLEo2i8NQY=
X-Received: by 2002:a05:600c:22d9:: with SMTP id
 25mr12481664wmg.41.1584124686791; 
 Fri, 13 Mar 2020 11:38:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvkUiNDT12hS5ZR4JFRBhywm9lydrk/287pcgsHZIDKqKgIi1sD3FdgAsAeou1Hy1iXt4HYMQ==
X-Received: by 2002:a05:600c:22d9:: with SMTP id
 25mr12481624wmg.41.1584124686545; 
 Fri, 13 Mar 2020 11:38:06 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f17sm59325628wrm.3.2020.03.13.11.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:38:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/14] hw/core: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Fri, 13 Mar 2020 19:36:52 +0100
Message-Id: <20200313183652.10258-15-philmd@redhat.com>
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
 [fuzzy]
X-Received-From: 207.211.31.81
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
 include/hw/core/cpu.h | 7 ++++++-
 hw/core/cpu.c         | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 73e9a869a4..48ab5ec3ed 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -492,6 +492,8 @@ bool cpu_paging_enabled(const CPUState *cpu);
 void cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp);
=20
+#if !defined(CONFIG_USER_ONLY)
+
 /**
  * cpu_write_elf64_note:
  * @f: pointer to a function that writes memory to a file
@@ -541,6 +543,8 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, C=
PUState *cpu,
  */
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
=20
+#endif /* !CONFIG_USER_ONLY */
+
 /**
  * CPUDumpFlags:
  * @CPU_DUMP_CODE:
@@ -634,7 +638,8 @@ static inline int cpu_asidx_from_attrs(CPUState *cpu, M=
emTxAttrs attrs)
     }
     return ret;
 }
-#endif
+
+#endif /* CONFIG_USER_ONLY */
=20
 /**
  * cpu_list_add:
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index fe65ca62ac..debdd7e670 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -209,6 +209,7 @@ static bool cpu_common_exec_interrupt(CPUState *cpu, in=
t int_req)
     return false;
 }
=20
+#if !defined(CONFIG_USER_ONLY)
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
 {
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
@@ -219,6 +220,7 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu=
)
     }
     return res;
 }
+#endif
=20
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
 {
--=20
2.21.1


