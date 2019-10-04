Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B3C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 23:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4357A217F5
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 23:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="gUZS3j8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4357A217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGXP3-0004tv-C4
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 19:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msmarduch@digitalocean.com>) id 1iGXOL-0004Sd-Dm
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 19:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msmarduch@digitalocean.com>) id 1iGXOI-0003Ay-31
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 19:53:43 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:35575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msmarduch@digitalocean.com>)
 id 1iGXOH-0003Aj-UT
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 19:53:42 -0400
Received: by mail-qk1-x743.google.com with SMTP id w2so7456664qkf.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 16:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digitalocean.com; s=google;
 h=from:subject:to:cc:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=074KI9eC6RnbCasB/To9XenkV7yh1rzl25oDZvf7GYI=;
 b=gUZS3j8BT7bMiOOP7+R+gWfb4Dtur2d6+6c73kausQHMB6hdlHggcHbOLinh0lFXQT
 z3qjgbRgOmeF2YD6gKdP8Q53CfZh5uKUU8msKacFV515ZMTYrFylmrkgdEqOrkHW63gl
 1xvB7QqHugfNE/BqcizbSwjz+H/iUljPmajNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=074KI9eC6RnbCasB/To9XenkV7yh1rzl25oDZvf7GYI=;
 b=e6A1Vrw+YrfuphHGdYh9MzaXR8WwKH9FCyud9EfvW7HmWB+9ha5Far5TCvcTASF1bL
 Cqo4inT4dNM/5SHREtd96dO4aXWd4Nx84DvcURHz6FHWGdKOMmBhZ9FBIOtlyj1i8afx
 v7pNj1h83WjIHeYbuxA1K0Tp/gsg7cJJTL82U1mT441DfJ2kRVMVn99AVsIur74mg09s
 4+WKzPMoshe8OY0s/uuKzdsjT5mRbEiW3K5tHuve4WVEjmPb/Le7aOZU1YiBaVINSgEp
 7xfgMm7q5HhLrQEXck+GT+vnksv76ajI7uj1vgsEoDNJRBVyYmuZZtpQqeGdnfIGOLw8
 AyuQ==
X-Gm-Message-State: APjAAAV99KDk4JwRnb5a02Q6l+WJcl8AYnZQXFZ1SNAoJktOPrUL30Eh
 XX1jq16E2xxoX6Dtbebw1zW8TA==
X-Google-Smtp-Source: APXvYqwPTzRtHA0gAQRFG3RI7mYPF1GUeIJ+DwhpyVV5obQhCokYNHDntSTJ0V+ve8RgbhTYwyXA6g==
X-Received: by 2002:a05:620a:16c4:: with SMTP id
 a4mr13386847qkn.389.1570233220856; 
 Fri, 04 Oct 2019 16:53:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:4a30:84c0:f52d:a7dc:c1:54d?
 ([2600:1700:4a30:84c0:f52d:a7dc:c1:54d])
 by smtp.gmail.com with ESMTPSA id c25sm3104635qtv.71.2019.10.04.16.53.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 16:53:40 -0700 (PDT)
From: Mario Smarduch <msmarduch@digitalocean.com>
Subject: [PATCH] target/i386: log guest name and memory error type AO, AR for
 MCEs
To: mtosatti@redhat.com, armbru@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com,
 qemu-trivial@nongnu.org
Message-ID: <ceb4d639-842a-30bd-5d54-bfacb07b5cc4@digitalocean.com>
Date: Fri, 4 Oct 2019 16:53:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In a large VPC environment we want to log memory error occurrences
and log them with guest name and type - there are few use cases


- if VM crashes on AR mce inform the user about the reason and
  resolve the case
- if VM hangs notify the user to reboot and resume processing
- if VM continues to run let the user know, he/she maybe able to
  correlate to vm internal outage
- Rawhammer attacks - isolate/determine the attacker possible
  migrating it off the hypervisor
- In general track memory errors on a hyperviosr over time to determine
  trends

Monitoring our fleet we come across quite a few of these and been
able to take action where before there were no clues to the causes.

When memory error occurs we get a log entry in qemu log:

Guest [Droplet-12345678] 2019-08-02T05:00:11.940270Z qemu-system-x86_64:
Guest MCE Memory Error at qemu addr 0x7f3c7622f000 and guest 78e42f000
addr of type BUS_MCEERR_AR injected

with enterprise logging environment we can to take further actions.

Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>
---
 target/i386/kvm.c | 27 ++++++++++++++++++++++-----
 util/qemu-error.c | 24 ++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 92069099ab..79ebccc684 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -555,9 +555,9 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr
paddr, int code)
                        (MCM_ADDR_PHYS << 6) | 0xc, flags);
 }

-static void hardware_memory_error(void)
+static void hardware_memory_error(void *addr)
 {
-    fprintf(stderr, "Hardware memory error!\n");
+    error_report("QEMU got Hardware memory error at addr %p", addr);
     exit(1);
 }

@@ -581,15 +581,32 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int
code, void *addr)
             kvm_physical_memory_addr_from_host(c->kvm_state, addr,
&paddr)) {
             kvm_hwpoison_page_add(ram_addr);
             kvm_mce_inject(cpu, paddr, code);
+            /*
+             * Use different logging severity based on error type.
+             * If mcelog is running qemu va addr will help debug via
mcelog.
+             */
+            if (code == BUS_MCEERR_AR) {
+                error_report("Guest MCE Memory Error at qemu addr %p and "
+                    "guest %lx addr of type %s injected", addr, paddr,
+                     "BUS_MCEERR_AR");
+            } else {
+                 warn_report("Guest MCE Memory Error at qemu addr %p and "
+                     "guest %lx addr of type %s injected", addr,
+                     paddr, "BUS_MCEERR_AO");
+            }
+
             return;
         }

-        fprintf(stderr, "Hardware memory error for memory used by "
-                "QEMU itself instead of guest system!\n");
+        if (code == BUS_MCEERR_AO) {
+            warn_report("Hardware memory error at addr %p of type %s "
+                "for memory used by QEMU itself instead of guest system!",
+                addr, "BUS_MCEERR_AO");
+        }
     }

     if (code == BUS_MCEERR_AR) {
-        hardware_memory_error();
+        hardware_memory_error(addr);
     }

     /* Hope we are lucky for AO MCE */
diff --git a/util/qemu-error.c b/util/qemu-error.c
index f373f3b3b0..2ebafd4405 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -11,6 +11,8 @@
  */

 #include "qemu/osdep.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"

@@ -35,11 +37,31 @@ int error_printf(const char *fmt, ...)
     return ret;
 }

+static const char *error_get_guestname(void)
+{
+    QemuOpts *opts = qemu_opts_find(qemu_find_opts("name"), NULL);
+    return qemu_opt_get(opts, "guest");
+}
+
+/*
+ * Print guest name associated with error, to aid debugging errors from
+ * multiple guests in centralized logging environment.
+ */
+static void error_print_guestname(void)
+{
+    const char *name;
+    name = error_get_guestname();
+    if (name != NULL && !cur_mon) {
+        error_printf("Guest [%s] ", name);
+    }
+}
+
 int error_printf_unless_qmp(const char *fmt, ...)
 {
     va_list ap;
     int ret;

+    error_print_guestname();
     va_start(ap, fmt);
     ret = error_vprintf_unless_qmp(fmt, ap);
     va_end(ap);
@@ -274,6 +296,7 @@ void error_report(const char *fmt, ...)
 {
     va_list ap;

+    error_print_guestname();
     va_start(ap, fmt);
     vreport(REPORT_TYPE_ERROR, fmt, ap);
     va_end(ap);
@@ -289,6 +312,7 @@ void warn_report(const char *fmt, ...)
 {
     va_list ap;

+    error_print_guestname();
     va_start(ap, fmt);
     vreport(REPORT_TYPE_WARNING, fmt, ap);
     va_end(ap);
--
2.17.1

