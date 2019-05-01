Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5FAC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC272081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPLfDP8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC272081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhv4-0002gl-VN
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:36:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hLhuF-00021v-Rk
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hLhuC-0002a5-Qj
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:35:47 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hLhuC-0002ZW-GQ; Wed, 01 May 2019 01:35:44 -0400
Received: by mail-pg1-x544.google.com with SMTP id e6so7894518pgc.4;
	Tue, 30 Apr 2019 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=kcdLkptqsXnGiIfVd9TJMpZGO5slhgnKysBBCc/BCbg=;
	b=rPLfDP8nw9w2N8asD7RBnWXAvVdqXWoGub7YfMeFGBvRu9dM/goss+z/G+WXeo4Q6K
	MkslWAUL75UEou1RTtwQsQBlZxgRZMhoUfY+9+4/pXdMf5lku25mrZgqJAiv8H6g7WIk
	P4RaRuvhcC2qs3fTbdEtQV26PhLWNLtkQxL5AVhKzj5yXTA7Bra8QVaGTiP+73rlyMye
	tGBHgpo65EiBRXgG7RxXksad7OEkMpgzaGH6luPMqGUlNyvb1u+g7NN4UJmO+0R3sHPu
	rJsNpK6AxQOYHowEir4VYypQ51l4yak4qmdalOPjkUNwcTwEsnS3p+0K1Na+980AnQyN
	Ttug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=kcdLkptqsXnGiIfVd9TJMpZGO5slhgnKysBBCc/BCbg=;
	b=MOh/WmqbTP2XLrfYqdAtbobBQoxwZnSySOLIxkNd10FXH7gdfR1HliI/IHdm/LpVA8
	BA236ePVF1Vam8ZlLv4DMv7NYRk6yMtC5oYL1tPQfbbEX2ZjkH3FG2LmgA0t16xEOAzd
	p57Nk5VooJHl5LhS8taf+fudYjiiI5HZ9ug/8vqqapk2/eE7eqUUvPVcA4NNLjEA5yXU
	VBVT5MezjmB4/5ru44gZxkyWGi6NXextIK29IVel5QA+JLPuL4PfGF3tXIHqdzUf5h0T
	ad2ir7FMZSmtVIXsO7PyofL7+xOnFuQ2nCcEEzHJbvOuY9AUToc290f7gDFWbe8qVSIp
	mivw==
X-Gm-Message-State: APjAAAWEtMGTMHjnodMFiS6lWuVFfHhypD/rY/5X8gUqn1rXCFdQ3exa
	LQ3p4ws6EAwa0z5juquImWZ479Mg
X-Google-Smtp-Source: APXvYqzeVKiBhhylXajAba3FMmwgiWAfz4kdXrY78cFwEcPvcn6Jg29JoUjW0kOofEYlkXeOOxl6DQ==
X-Received: by 2002:a62:4595:: with SMTP id n21mr77767087pfi.79.1556688942295; 
	Tue, 30 Apr 2019 22:35:42 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
	by smtp.gmail.com with ESMTPSA id
	h19sm62932986pfd.130.2019.04.30.22.35.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 22:35:41 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 15:35:21 +1000
Message-Id: <20190501053522.10967-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 1/2] monitor: Add dump-stack command
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, dgilbert@redhat.com,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501053521.zUVUouXTdd5-uc33zKWsygoelKmhYR7dkwqT14LSTV4@z>

Add a monitor command "dump-stack" to be used to dump the stack for the
current cpu.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hmp-commands.hx   | 13 +++++++++++++
 hmp.h             |  1 +
 include/qom/cpu.h | 10 ++++++++++
 monitor.c         | 12 ++++++++++++
 qom/cpu.c         | 10 ++++++++++
 5 files changed, 46 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 9b4035965c..965ccdea28 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -862,6 +862,19 @@ ETEXI
     },
 
 STEXI
+@item dump-stack
+@findex dump-stack
+dump stack of the cpu
+ETEXI
+    {
+        .name           = "dump-stack",
+        .args_type      = "",
+        .params         = "",
+        .help           = "dump stack",
+        .cmd            = hmp_dumpstack,
+    },
+
+STEXI
 @item pmemsave @var{addr} @var{size} @var{file}
 @findex pmemsave
 save to disk physical memory dump starting at @var{addr} of size @var{size}.
diff --git a/hmp.h b/hmp.h
index 43617f2646..e6edf1215c 100644
--- a/hmp.h
+++ b/hmp.h
@@ -51,6 +51,7 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict);
 void hmp_cpu(Monitor *mon, const QDict *qdict);
 void hmp_memsave(Monitor *mon, const QDict *qdict);
 void hmp_pmemsave(Monitor *mon, const QDict *qdict);
+void hmp_dumpstack(Monitor *mon, const QDict *qdict);
 void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
 void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
 void hmp_cont(Monitor *mon, const QDict *qdict);
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 08abcbd3fe..f2e83e9918 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -181,6 +181,7 @@ typedef struct CPUClass {
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
+    void (*dump_stack)(CPUState *cpu, FILE *f);
     GuestPanicInformation* (*get_crash_info)(CPUState *cpu);
     void (*dump_statistics)(CPUState *cpu, int flags);
     int64_t (*get_arch_id)(CPUState *cpu);
@@ -568,6 +569,15 @@ enum CPUDumpFlags {
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
 /**
+ * cpu_dump_stack:
+ * @cpu: The CPU whose stack is to be dumped.
+ * @f: If non-null, dump to this stream, else to current print sink.
+ *
+ * Dumps CPU stack.
+ */
+void cpu_dump_stack(CPUState *cpu, FILE *f);
+
+/**
  * cpu_dump_statistics:
  * @cpu: The CPU whose state is to be dumped.
  * @flags: Flags what to dump.
diff --git a/monitor.c b/monitor.c
index 9b5f10b475..dbec2e4376 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1299,6 +1299,18 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
     }
 }
 
+void hmp_dumpstack(Monitor *mon, const QDict *qdict)
+{
+    CPUState *cs = mon_get_cpu();
+
+    if (!cs) {
+        monitor_printf(mon, "No CPU available\n");
+        return;
+    }
+
+    cpu_dump_stack(cs, NULL);
+}
+
 #ifdef CONFIG_TCG
 static void hmp_info_jit(Monitor *mon, const QDict *qdict)
 {
diff --git a/qom/cpu.c b/qom/cpu.c
index 3c5493c96c..0dc10004f4 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -230,6 +230,16 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
     }
 }
 
+void cpu_dump_stack(CPUState *cpu, FILE *f)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->dump_stack) {
+        cpu_synchronize_state(cpu);
+        cc->dump_stack(cpu, f);
+    }
+}
+
 void cpu_dump_statistics(CPUState *cpu, int flags)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-- 
2.13.6


