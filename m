Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232F9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 00:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D686B20679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 00:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwL2KtqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D686B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd1Ew-0001aw-2A
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 20:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1jcyqx-0004Di-1O
 for qemu-devel@nongnu.org; Sun, 24 May 2020 18:12:19 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1jcyqv-0001uJ-Ew
 for qemu-devel@nongnu.org; Sun, 24 May 2020 18:12:18 -0400
Received: by mail-ej1-x641.google.com with SMTP id s21so18745972ejd.2
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 15:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P8RrrDncw9cLMOwbVe2eVW0WWaz4iq9FuWQ879jZAg8=;
 b=NwL2KtqJIefZhbEV3HtWyR2wVJXEbCvNXz8j/k6o67LFo19tvSjx6xIBb6+69HXI8/
 X8DtrR9WQzWaayxtOS0A3KekWEE1O6jLJolWqifdcXW/hZxZtYQl4DwtIHNux7swr49i
 cREGUyEq/voQIiBSp9rtDawJIc9UPxVXKDuo8vISt+twLPxSUBTP27eyOssw63Wlujao
 Q6UXx8LFL+LBrakGdbcKkQcjZR0szP/EpOGXSdVEgcQtZX0YaS0vUrWmkopY3ZQIdIcb
 6XJN0yA+c0nLlRxiyfIepdbkBeTi/FOgs764o/6S36mk0LPk/MSsyQnmIU2UPiyBosRO
 bjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P8RrrDncw9cLMOwbVe2eVW0WWaz4iq9FuWQ879jZAg8=;
 b=diovlpcdx1xe9yJqw/XMsGrvBxtC6+hIt88kmeOEORPA8ab0V1rnq8N9esmJIjimGi
 01l46C1aS25N7FAo3RsEfDbqr0tEYAsUMX62KvrEO9mbvfPzhxY6a3ZAAu24Ovhy70vd
 YEkOF61s1z/vbAIlDGS7xhLiPuvT69D06lD/mhnzLxaKjmAhNW82dctIl219mjtAvXcO
 uaUHZDdc86ze92RFw1KaZSVBaUlG2fOpl/c0pSpATEb78usg5N4iyKhJ5owpyXPzAG3/
 6O9qkCUzBeXCRHK2IwRQ3ZIm/pHJl/E+Fxv9sAWqfujxFCKf+z7gOK/vGPm4upFkPKcM
 XbLw==
X-Gm-Message-State: AOAM532Iw7qLr7uNqsaRDydRnR8ufok7yx7Wjxea2AbSByW/EhvrsVHH
 UhbPFKCiY/GfwaY1OdcD47Iq0/uUJ1QWqg==
X-Google-Smtp-Source: ABdhPJwCIsqHxNV/942dEfGYjRXrYhskGeZ/aD+tkG3FUjlXw6mQoR7jrdt9NNAc2VTv0iek2ZESeA==
X-Received: by 2002:a17:906:63c9:: with SMTP id
 u9mr17351196ejk.487.1590358333889; 
 Sun, 24 May 2020 15:12:13 -0700 (PDT)
Received: from leo-lap.lan ([176.230.212.100])
 by smtp.gmail.com with ESMTPSA id o18sm2749808eje.40.2020.05.24.15.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 15:12:13 -0700 (PDT)
From: Leonid Bloch <lb.workbox@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Do not ignore malloc value
Date: Mon, 25 May 2020 01:12:04 +0300
Message-Id: <20200524221204.9791-1-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=lb.workbox@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 24 May 2020 20:44:34 -0400
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
Cc: Leonid Bloch <lb.workbox@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Leonid Bloch <lbloch@janustech.com>

Not checking the value of malloc will cause a warning with GCC 10.1,
which may result in configuration failure, with the following line in
config.log:

config-temp/qemu-conf.c:2:18: error: ignoring return value of ‘malloc’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
    2 | int main(void) { malloc(1); return 0; }
      |                  ^~~~~~~~~

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
---
 configure | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 2fc05c4465..d0220b2944 100755
--- a/configure
+++ b/configure
@@ -4567,7 +4567,13 @@ fi
 if test "$tcmalloc" = "yes" ; then
   cat > $TMPC << EOF
 #include <stdlib.h>
-int main(void) { malloc(1); return 0; }
+int main(void) {
+    void *tmp = malloc(1);
+    if (tmp != NULL) {
+        return 0;
+    }
+    return 1;
+}
 EOF
 
   if compile_prog "" "-ltcmalloc" ; then
@@ -4583,7 +4589,13 @@ fi
 if test "$jemalloc" = "yes" ; then
   cat > $TMPC << EOF
 #include <stdlib.h>
-int main(void) { malloc(1); return 0; }
+int main(void) {
+    void *tmp = malloc(1);
+    if (tmp != NULL) {
+        return 0;
+    }
+    return 1;
+}
 EOF
 
   if compile_prog "" "-ljemalloc" ; then
@@ -6144,7 +6156,9 @@ if test "$sanitizers" = "yes" ; then
 #include <stdlib.h>
 int main(void) {
     void *tmp = malloc(10);
-    return *(int *)(tmp + 2);
+    if (tmp != NULL) {
+        return *(int *)(tmp + 2);
+    }
 }
 EOF
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=undefined" ""; then
-- 
2.26.2


