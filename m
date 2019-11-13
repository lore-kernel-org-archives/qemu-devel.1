Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFFBC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDCC62245B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA/121bL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCC62245B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtpL-0007Yj-Bq
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnb-0005i5-P2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtna-0006IX-Mo
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:11 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtna-0006I4-Gg
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:10 -0500
Received: by mail-wr1-x443.google.com with SMTP id r10so2658770wrx.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wetGOwL6w9T5KqZky8gH8g8gUVnF2w1GmxQs/cFXJ4g=;
 b=JA/121bL7xwyBhWiY7Vz+uiS9W1+Qdz7XpsqwRfsuE7oH61I8EQUwuhwsKW17uNac2
 WJmDbffmVIklxgVWG6XYdSR5btBVlyRn/1FqMyPL5g6/+yneMvtewa3AtmTQNC63NO2a
 VJSpbk4wVMrhSwe8vJissyhH0IFtwMARVO8NntgqM7OL4iw0bpKWHidjy9YE8aRPpkiQ
 cV4vWjopJoUDXWyLqjkUToxJoLm93MkRiwMaJUEeVHtAVYztmU5KWpG2/c7T8W994itB
 9OhgEDsne1J0iRfFZ1uzTR40aBDWMtp5cWw7vMpeSdhpiO1p5GCTU7L0YqvtD8sAgiIa
 02KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=wetGOwL6w9T5KqZky8gH8g8gUVnF2w1GmxQs/cFXJ4g=;
 b=BwW49CUd6DK0J2itkoPEz+ieEIjDuHTIfedr8CTjayjmy1LoQLKMPX1OupU7+04jqH
 qBsI1IOZjwKPsbL2RJ4XlDoyKvOijYlgOSEMVT6aiFvImbCwGaWdVXo81E/KsJVUzQD/
 wpFVh5FA6yGJnrMKet2shVAo7YuFSUZJp9dIW5tA3BsPdeSWv0DpjIEc6oOU+qX7vjg2
 GH2A6jvI4H5F1W26MknVN5eEiw9cE3c62qlH97eKM80IahG9ohPujl6Bpp1Y0VKbe9A6
 18IHzo8OxVl/F4WT0PVsxs8fvDMe7E5gVa4u4O97CISqZnuTbO7Oz8eCyQfudkPj27N7
 8Lig==
X-Gm-Message-State: APjAAAVYUxFkKNdrcfWo+NtZ+40EpODeuwWcwSDwwo/0eWeLknEZG74Q
 EGeUgjzyIg//ICxqKlUBE28AVCE2
X-Google-Smtp-Source: APXvYqxo3kzQoLQTYvCv8BpHpYI37fs/h410Vy/RCwpcVTgwAjjJG7fhY4j+wSq9m3e8IFLmoXuy7g==
X-Received: by 2002:a5d:526f:: with SMTP id l15mr3077923wrc.169.1573655949155; 
 Wed, 13 Nov 2019 06:39:09 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/16] vl: extract accelerator option processing to a separate
 function
Date: Wed, 13 Nov 2019 15:38:51 +0100
Message-Id: <1573655945-14912-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As a first step towards supporting multiple "-accel" options, push -icount
and -accel semantics into a new function, and use qemu_opts_foreach to
retrieve the key/value lists instead of stashing them into globals.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/vl.c b/vl.c
index 841fdae..5367f23 100644
--- a/vl.c
+++ b/vl.c
@@ -2827,6 +2827,33 @@ static void user_register_global_props(void)
                       global_init_func, NULL, NULL);
 }
 
+static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
+{
+    if (tcg_enabled()) {
+        configure_icount(opts, errp);
+    } else {
+        error_setg(errp, "-icount is not allowed with hardware virtualization");
+    }
+    return 0;
+}
+
+static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
+{
+    if (tcg_enabled()) {
+        qemu_tcg_configure(opts, &error_fatal);
+    }
+    return 0;
+}
+
+static void configure_accelerators(void)
+{
+    qemu_opts_foreach(qemu_find_opts("icount"),
+                      do_configure_icount, NULL, &error_fatal);
+
+    qemu_opts_foreach(qemu_find_opts("accel"),
+                      do_configure_accelerator, NULL, &error_fatal);
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -4241,18 +4268,7 @@ int main(int argc, char **argv, char **envp)
     qemu_spice_init();
 
     cpu_ticks_init();
-    if (icount_opts) {
-        if (!tcg_enabled()) {
-            error_report("-icount is not allowed with hardware virtualization");
-            exit(1);
-        }
-        configure_icount(icount_opts, &error_abort);
-        qemu_opts_del(icount_opts);
-    }
-
-    if (tcg_enabled()) {
-        qemu_tcg_configure(accel_opts, &error_fatal);
-    }
+    configure_accelerators();
 
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
-- 
1.8.3.1



