Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EFBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0705208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9TfjT+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0705208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolKh-0005T9-Uq
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jolHA-0000no-F9; Fri, 26 Jun 2020 06:08:04 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jolH8-0005tf-Sx; Fri, 26 Jun 2020 06:08:04 -0400
Received: by mail-ej1-x644.google.com with SMTP id mb16so8813026ejb.4;
 Fri, 26 Jun 2020 03:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=zwOhb5W3n8EF+279WipD9/D4F9y/pqe0fiyLrS8XTwc=;
 b=E9TfjT+FB9c48l0KAh1aoVsgXA8hHyu42E0MjpXNsfQMe40p5YBn8TFPB15z+nQk9h
 t+wLlbXbmnMS3dsNRPgFDEYcK1BR/qplOgB8Z0fIVWobtj45bTlgUPez8/cnknmUMmPD
 E2B8wi2+FVTHQg8jCcfucJnBnppbWeNEOtZpIA0ZhwnO3v7h0s9j86c8UkHd0C/fpJhE
 /Z01pjtYJzajn3b+1rmX0+YlFAPGwq3Dx9Upro0eIqgPlNLHvZ5V0UOMjYlJ3/WHIkKM
 JPp+Egv/cCZoEQk3rYIXCSEs3avAGSlTU11AdY9vDnjFwPL25+g0GfZIvoFHEzTbUiT6
 Rg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=zwOhb5W3n8EF+279WipD9/D4F9y/pqe0fiyLrS8XTwc=;
 b=avipaTNWaSCcMhUGhB1qqrfuPJDDbhn0mV2pqCdLR53CWwoo36vTP/dDBkBqVo7dkT
 fkx/FIoC0unVA7MKQRHt+eF1yxM6TnCB5WCSvXmAflPeiDqRnmgP8gBs3abbbv1EhLI8
 CAWM/Abwl4MWVasXR6WYvXFXO2DkkvW1QerQRryLOvLGRJJE9o4Neb5Q5Yzw5Jj9bZT6
 Qg1mkCtXEn1FemBvWE6dQwdQejyD0QTWshQU1abDwTGDRXXTAFbd1yBuWNqE//+2Kw3f
 FcHYE7tl6qyz1f3aXZJ3k01lEGYG6wn5eILBt6v/Znz8IAtLOWlzVh/flFr/KHHMaUbr
 PqlQ==
X-Gm-Message-State: AOAM532y6NDvqF3WwLlgMdW+py+AHLSm5ocbYGveIKgyj3CIAJiKmRfM
 jA7y2ISUdmN/q/sZo5WmIydoa5jWMmt59w7YWux+Gtao
X-Google-Smtp-Source: ABdhPJz3kN2ptLEJWjJfNJss/1PxmTCRKimugvmEOWc0NORKV4BqZf9qhb+pKxAjRofGF5OlXLA+HS7O/fc1iKeuxls=
X-Received: by 2002:a17:906:5203:: with SMTP id
 g3mr1822576ejm.58.1593166081089; 
 Fri, 26 Jun 2020 03:08:01 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 11:07:50 +0100
Message-ID: <CA+XhMqzxVaM2UHMjpOiwL-bM2GZb8KwSrXf1=+LTUy53mZGRWw@mail.gmail.com>
Subject: [PATCH 3/5] haiku build fix
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x644.google.com
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

From 56890fa5728d11c72232348b3f3273e2df31c197 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 10:40:58 +0000
Subject: [PATCH 3/5] Checking mlockall symbol presence

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure  | 15 +++++++++++++++
 os-posix.c |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/configure b/configure
index f040b07463..34b0f0f036 100755
--- a/configure
+++ b/configure
@@ -2379,6 +2379,18 @@ else
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

@@ -7767,6 +7779,9 @@ fi
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

