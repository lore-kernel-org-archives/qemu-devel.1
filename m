Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1CCC54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58AD206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYFfWuw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58AD206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvgx-0004d8-Ax
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveK-0000oe-Dh
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveI-00049U-NT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50373
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQveI-00048k-B0
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587486084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2H+OgQwZ9zhEE73FazNnzT/qTkBaiVyceFFMEZU4064=;
 b=VYFfWuw2pFDRNumAr6ffiBj0dqZT02auMWrKQ1J7qyVynIHh5oDTjPIdm3XqIVX/xvv8J8
 IYS5ZxnNnkOcQMxzpmFEWljHpOM1AXCYbCQL+wof0XI9/uHbGtY5mrcodKUH+YBJvkhIKE
 RSZsVtQlsXzrm9pL1SWZEJbAo8dyNT4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-8khLdJz-PnKbUjBtPie0tg-1; Tue, 21 Apr 2020 12:21:23 -0400
X-MC-Unique: 8khLdJz-PnKbUjBtPie0tg-1
Received: by mail-qv1-f72.google.com with SMTP id b4so14286828qvt.15
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 09:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fpjhpsaQQavZP0ghK24+JAch3X5MLywrjyWB4EFaOlI=;
 b=nnEA5R8NTTxzYz+umJ1vDaIbXFXdJke9xvuCkK/vdGnP3tobDS0FHuhbhJdOWZXkEp
 JK8whT4tbo0HYHjLw+lm5CxP5DdMKEQT6jzpR1esay6Xtbu1YNnbvtafXZ5hevuJ06lw
 ltedjZOG8PESo3ogHy/b5doqfpImEbrRNDQI82q4AcbFuqdPEMlyZWMkiRjoCuloTtYS
 X26eqHFUVzXmVxJvzAJyKOUcQOKaq2G7vQAza5ivy1pbvLCv+ez+4pN7iIiQEhhGQfWr
 imBlM8uPL5JzsBxVSGIhuamPpkLu5J88y6UjWTgu1UCbmOcdkVQZi7oo3xUNwuAaOKNo
 dJwg==
X-Gm-Message-State: AGi0PuaBQDRM95mYuOABjvHsr3sljOPmI+QmPAu+eI1krysJz8dtridZ
 wzit/5QEDI20KPgDVY+UbJCSUjPiaEQWSHS7VNnakpK2w3anqgBvhk0HuBYOkeccnJ6I60FhxZK
 hWeZcHucxTZzg+Qc=
X-Received: by 2002:a37:b1c6:: with SMTP id a189mr6410919qkf.26.1587486081405; 
 Tue, 21 Apr 2020 09:21:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJG0ZnaQW+4qLEUi/pIe4a8e0cOZs8o9iKVUeXHPVefP/RG9yitb3JSU42cQomONHKXU0IAag==
X-Received: by 2002:a37:b1c6:: with SMTP id a189mr6410897qkf.26.1587486081179; 
 Tue, 21 Apr 2020 09:21:21 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id s15sm2110604qtc.31.2020.04.21.09.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 09:21:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] cpus: Use qemu_cond_wait_iothread() where proper
Date: Tue, 21 Apr 2020 12:21:03 -0400
Message-Id: <20200421162108.594796-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421162108.594796-1-peterx@redhat.com>
References: <20200421162108.594796-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The helper is introduced but we've still got plenty of places that are dire=
ctly
referencing the qemu_global_mutex itself.  Spread the usage.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 cpus.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/cpus.c b/cpus.c
index ef441bdf62..00f6e361af 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1181,7 +1181,7 @@ static void qemu_tcg_rr_wait_io_event(void)
=20
     while (all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait_iothread(first_cpu->halt_cond);
     }
=20
     start_tcg_kick_timer();
@@ -1200,7 +1200,7 @@ static void qemu_wait_io_event(CPUState *cpu)
             slept =3D true;
             qemu_plugin_vcpu_idle_cb(cpu);
         }
-        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait_iothread(cpu->halt_cond);
     }
     if (slept) {
         qemu_plugin_vcpu_resume_cb(cpu);
@@ -1456,7 +1456,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
=20
     /* wait for initial kick-off after machine start */
     while (first_cpu->stopped) {
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait_iothread(first_cpu->halt_cond);
=20
         /* process any pending work */
         CPU_FOREACH(cpu) {
@@ -1657,7 +1657,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
             }
         }
         while (cpu_thread_is_idle(cpu)) {
-            qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+            qemu_cond_wait_iothread(cpu->halt_cond);
         }
         qemu_wait_io_event_common(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
@@ -1877,7 +1877,7 @@ void pause_all_vcpus(void)
     replay_mutex_unlock();
=20
     while (!all_vcpus_paused()) {
-        qemu_cond_wait(&qemu_pause_cond, &qemu_global_mutex);
+        qemu_cond_wait_iothread(&qemu_pause_cond);
         CPU_FOREACH(cpu) {
             qemu_cpu_kick(cpu);
         }
@@ -2087,7 +2087,7 @@ void qemu_init_vcpu(CPUState *cpu)
     }
=20
     while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+        qemu_cond_wait_iothread(&qemu_cpu_cond);
     }
 }
=20
--=20
2.24.1


