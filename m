Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95733C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547962072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbjDn1Yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547962072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihY7K-0003n0-VO
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2q-00066J-1c
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2o-0008PP-Na
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:11 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2o-0008N6-C4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:10 -0500
Received: by mail-wm1-x343.google.com with SMTP id d73so1561039wmd.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wpdalmmTK/FCoQs/NtWe2+gF7RTn+BqZ+IAbD5CsqGs=;
 b=AbjDn1YpIIy8iVVP2uw7d3EDL20dZoUDPuC9yuO1mcLnzerfQ/pFd5NyxOcxFbxe6K
 Kx0YotAPebeuSgwP9j1Ur3gWkVYzX5hhJnD3/aFAIjIVIDdxSz4ZcV0s4XsoGZHkHDB8
 sC/ASss97Tp4GRs6B8KJX7q4AbJ7E7tTfaax3txUKkN46McCZAR3C7dUMXlPwzgyIL/p
 xJFkOpIu0pzOm22dbOhn+O4vTNg4BPOe+ORkDd4qOE33BICKZYN032udiBMN80/rwco/
 fdcD/xochb3ruCqfuq71DYDQY5u7MC6f1R+GCY3Xbt9v4WzkJ/jzRUueVND/DiuGiun6
 Vo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wpdalmmTK/FCoQs/NtWe2+gF7RTn+BqZ+IAbD5CsqGs=;
 b=dkz0KS5F7egkSg5fCj7z8VPqGrgBAn6a978t1v6sCnI1vbxhS9+3lm77ljPc12Ht7e
 L/1Rlc2a0S8Zlf/GOeKJzwO2NuYCUuwCtmiC4sLPndaB8PoubrRXNZPr7uw7GvrXfuQD
 XQFSVcmpDF0xNehx8qil6vTfuZZcSoRpVqHmUm4r/NDfSe+VsW8TBR0YgQkWo+HyD6h5
 PFOc/KJpbhyiLfyn0X4P9bS7ktRSuYyASIgEikWywDeayVGStCsfSSUDWesIWNUtDUYf
 5iUO9ezR60A2r4FlfaJuIpzAl33dAqEejOxagy4YkeHFPk/GcDu0Brh7lTQ4UPV3hlM/
 lH0w==
X-Gm-Message-State: APjAAAU3qDOc7YipPpKfJn+FXadU1ZaUlCdz4bveRGLTvL5YSJUujf1R
 WTgLiy8eB1htpcPj3kRFHEmFVpfe
X-Google-Smtp-Source: APXvYqz1XrF5BAb3px2qnqxZgD89d5G1SgdY/95FQrg9vuKQz7la+FigzgKmJJZfSUWAIAPHJQzgIw==
X-Received: by 2002:a7b:c317:: with SMTP id k23mr2884998wmj.75.1576670588532; 
 Wed, 18 Dec 2019 04:03:08 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/87] vl: move icount configuration earlier
Date: Wed, 18 Dec 2019 13:01:39 +0100
Message-Id: <1576670573-48048-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

Once qemu_tcg_configure is turned into a QOM property setter, it will not
be able to set a default value for mttcg_enabled.  Setting the default will
move to the TCG instance_init function, which currently runs before "-icount"
is processed.

However, it is harmless to do configure_icount for all accelerators; we will
just fail later if a non-TCG accelerator is selected.  So do that.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/vl.c b/vl.c
index 9450830..6e58c1d 100644
--- a/vl.c
+++ b/vl.c
@@ -2700,6 +2700,12 @@ static void user_register_global_props(void)
                       global_init_func, NULL, NULL);
 }
 
+static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
+{
+    configure_icount(opts, errp);
+    return 0;
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -4010,6 +4016,8 @@ int main(int argc, char **argv, char **envp)
      * Note: uses machine properties such as kernel-irqchip, must run
      * after machine_set_property().
      */
+    qemu_opts_foreach(qemu_find_opts("icount"),
+                      do_configure_icount, NULL, &error_fatal);
     configure_accelerator(current_machine, argv[0]);
 
     /*
@@ -4095,13 +4103,9 @@ int main(int argc, char **argv, char **envp)
     qemu_spice_init();
 
     cpu_ticks_init();
-    if (icount_opts) {
-        if (!tcg_enabled()) {
-            error_report("-icount is not allowed with hardware virtualization");
-            exit(1);
-        }
-        configure_icount(icount_opts, &error_abort);
-        qemu_opts_del(icount_opts);
+    if (use_icount && !(tcg_enabled() || qtest_enabled())) {
+        error_report("-icount is not allowed with hardware virtualization");
+        exit(1);
     }
 
     if (tcg_enabled()) {
-- 
1.8.3.1



