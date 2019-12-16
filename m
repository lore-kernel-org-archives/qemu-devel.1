Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D7C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00B3206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ar62b+qv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00B3206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoIO-0002Vq-KA
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoE7-0005Jp-1K
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoE5-0003hI-Sy
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoE5-0003gG-Mu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so6725905wru.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CjsswiYtUxVQ0NqmGtm0qPesCYMLKJ1Tdwc44fZ5BMo=;
 b=ar62b+qv2ai6tv2IKuA3KAB4T55E+rmUzzafFPVlhNfvzods/yQi2Y75WvJOmjVMHP
 W6SRtIzxHPoK2D/uZZMdEvTYhKZ6cpAcbqZ4UfwSRPYj2B2pQVWBlewLpBYXPAM4N9FL
 ZWDS7YLImTmCUdsA6HJdojFXKSq3wVNpKMOJOhL7qSyZ+JPeCCO5YFqs+EAktSRXSHud
 F9WY2LijQLzva3C1nvvhDn/MlPkCcG6OF3/k3TF7/XJsld1hejMEMucbj61VP098azVp
 sljX4zsgCJSrS3CNofsmZ6h32ABOeMHatPbFi6I3wEujC3Rofg/QywekmebJcJSsxKrl
 UAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CjsswiYtUxVQ0NqmGtm0qPesCYMLKJ1Tdwc44fZ5BMo=;
 b=PfqGuIWlrM5TnSDEsCROH4A/txcDEajYWLZlcUeokSyOC9UyH4U2XdSl6UEb6amQgi
 mv5gLXZzU4Ypv4uGtX/nCM8hz5Vc7iXGtTfnR44hr7pGrK4eWOrVzPuyuDLDhf0Q6ORJ
 rbdQIG83moVvQ+XCXj/sRca+VAF/wRx3Q2lppNpKGrSBA+zY45kpjkL1zyOaW+Eu8K6j
 pRtNnQCdOE2LkUCfPFMrAR17IMbhoWdisGGsuteNkbAjiEYgSP1xfQPB2xZ4BlnntceH
 UfHeazAp+hQ/ayI5tWp7u2EEECAyNn6LoO68w0umucehhQb2hwNvOc03seR3Pfi3sLlI
 YTAw==
X-Gm-Message-State: APjAAAWmczwYuZZgcW9sdYxyomX3LR5XPlecn0q0hevZ/eeK70XDsQW1
 4me9DrABbxJLq7nkhuPNHDHTEw==
X-Google-Smtp-Source: APXvYqyjREAu+Hk4UUINnUCSiGeTNWUFTcTzppVxnOIojeYl224UfZ9N/mWgdFOI/+sRm7N3n1h0GA==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr29824058wrv.364.1576494464685; 
 Mon, 16 Dec 2019 03:07:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s8sm20803091wrt.57.2019.12.16.03.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:07:39 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C46251FF96;
 Mon, 16 Dec 2019 11:07:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 07/16] tests/hd-geo-test: Skip test when images can not be
 created
Date: Mon, 16 Dec 2019 11:07:23 +0000
Message-Id: <20191216110732.24027-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: fam@euphon.net, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

In certain environments like restricted containers, we can not create
huge test images. To be able to use "make check" in such container
environments, too, let's skip the hd-geo-test instead of failing when
the test images could not be created.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191204154618.23560-5-thuth@redhat.com>
---
 tests/hd-geo-test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 7e86c5416cc..a2498005440 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -34,8 +34,13 @@ static char *create_test_img(int secs)
     fd = mkstemp(template);
     g_assert(fd >= 0);
     ret = ftruncate(fd, (off_t)secs * 512);
-    g_assert(ret == 0);
     close(fd);
+
+    if (ret) {
+        free(template);
+        template = NULL;
+    }
+
     return template;
 }
 
@@ -934,6 +939,10 @@ int main(int argc, char **argv)
     for (i = 0; i < backend_last; i++) {
         if (img_secs[i] >= 0) {
             img_file_name[i] = create_test_img(img_secs[i]);
+            if (!img_file_name[i]) {
+                g_test_message("Could not create test images.");
+                goto test_add_done;
+            }
         } else {
             img_file_name[i] = NULL;
         }
@@ -965,6 +974,7 @@ int main(int argc, char **argv)
                        "skipping hd-geo/override/* tests");
     }
 
+test_add_done:
     ret = g_test_run();
 
     for (i = 0; i < backend_last; i++) {
-- 
2.20.1


