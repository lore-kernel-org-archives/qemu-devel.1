Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB9BC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B80F20781
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKPrl9Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B80F20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4Mx-0008TP-9a
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 20:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dh-0007MY-3A; Mon, 29 Jun 2020 17:48:33 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:41237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dc-000854-Ts; Mon, 29 Jun 2020 17:48:32 -0400
Received: by mail-ed1-x542.google.com with SMTP id e22so14297854edq.8;
 Mon, 29 Jun 2020 14:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=O++SecfjGgP0FVmkVuIgRRw4l8+URq7SlnZnl9/xoSE=;
 b=eKPrl9FdtW/4zEJsY8c9E5+z7T86IhhMOtEVLMFcRNn7XGkWMdoyQgxZ4CH0IwY6Au
 qsYSEZBslUx/W3u9z2c3SlQUGaw8ftYHa3vMONuvV6XbkgEpH4v2fZp418SzferHgyCZ
 vkQUywaV9VNziXucPjct6zBsNKE3CxvXN2FHQB0mt8DrslkatLV7+yUqLFroZ/2Fs3py
 b/tXtCuAH59Depq9hQCvaf/CPtWSl0LdKKxfug8XL7OnVhqOT307WLsD4+QmtMIYoqpD
 tFT4j3HOc9ck+woNI6w1INZmhLkPl7xAriivcU2ROECfn8dlwooDWlpiLWp9H3DTtN+I
 EBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=O++SecfjGgP0FVmkVuIgRRw4l8+URq7SlnZnl9/xoSE=;
 b=DN2VNt/lO+zBKWbQg5e9/gag8BXMUUubnrpvv6EsJiontQIPUGYpK2i9C9uEeJUzWb
 9yjO8H/ad96valCqw3gPlquj1JxftGMRI61chPdrr6ahDHaJ6DsOGzTuH9rFm3shkCVz
 /PO3gkZrxX4q6462Aals6tLG9anMV/DZqun8Xso/O4DptsldS25/4sBhdoL22Bv75W4d
 rIzlTmQYgaQ/N9IhYlZo92Fibh+N+8/wklvinWmVGduZaEMs+q72rJMDqOe1NZNEd0Tw
 5GpfIdaZSR+PfMXL1NAu9GS3HWox1f4/3KwQotW43Ah+AmmglXx4FE2hQD2yHBH2cyfK
 mQdA==
X-Gm-Message-State: AOAM533sJtyariq1838YKYHXmiknc7EeF37NezjU989tkKzGvU/4wA+d
 wlQj+S36dwGaxr68f8acQ+ZRtUGDvKFYUgr6ObbZD2JZKH0=
X-Google-Smtp-Source: ABdhPJx7oEFhUHiJAXHzke6le3FXwH20oBHk0lnmQpenLELY6DL8X4xSK6NgXZhGyNueJForn2CmzqfLrerjAEz4IE4=
X-Received: by 2002:a05:6402:3049:: with SMTP id
 bu9mr5818559edb.232.1593467307086; 
 Mon, 29 Jun 2020 14:48:27 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:48:16 +0100
Message-ID: <CA+XhMqxOuWKDangdOwhe3PbKa=411_BRC7WS6dvfJ+HMPw7j0w@mail.gmail.com>
Subject: [PATCH 3/9] Checking mlockall symbol presence
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Jun 2020 20:42:18 -0400
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

From ac450c4abe03e0e461fede18727500e616d9f7e2 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:15:21 +0000
Subject: [PATCH 3/9] Checking mlockall symbol presence.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure  | 15 +++++++++++++++
 os-posix.c |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/configure b/configure
index 50b559238f..0b278f1646 100755
--- a/configure
+++ b/configure
@@ -2392,6 +2392,18 @@ else
   pty_h=no
 fi

+cat > $TMPC <<EOF
+#include <sys/mman.h>
+int main(int argc, char *argv[]) {
+    return mlockall(MCL_FUTURE);
+}
+EOF
+if compile_prog "" "" ; then
+  have_mlockall=yes
+else
+  have_mlockall=no
+fi
+
 #########################################
 # vhost interdependencies and host support

@@ -7865,6 +7877,9 @@ fi
 if test "$pty_h" = "yes" ; then
   echo "CONFIG_PTY=y" >> $config_host_mak
 fi
+if test "$have_mlockall" = "yes" ; then
+  echo "CONFIG_MLOCKALL=y" >> $config_host_mak
+fi
 if test "$fuzzing" = "yes" ; then
   if test "$have_fuzzer" = "yes"; then
     FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
diff --git a/os-posix.c b/os-posix.c
index 3cd52e1e70..e02b566940 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -337,6 +337,7 @@ bool is_daemonized(void)

 int os_mlock(void)
 {
+#if defined CONFIG_MLOCKALL
     int ret = 0;

     ret = mlockall(MCL_CURRENT | MCL_FUTURE);
@@ -345,4 +346,7 @@ int os_mlock(void)
     }

     return ret;
+#else
+    return -ENOSYS;
+#endif
 }
--
2.26.0

