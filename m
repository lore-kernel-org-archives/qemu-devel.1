Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49733C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A738E2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/P3YYzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A738E2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAGu-0000wn-O8
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qf-0000px-Lc; Tue, 15 Sep 2020 08:14:13 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qc-0008Bm-LJ; Tue, 15 Sep 2020 08:14:13 -0400
Received: by mail-pj1-x1044.google.com with SMTP id jw11so1628426pjb.0;
 Tue, 15 Sep 2020 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7zvfu2AU8jmrgTOs2oC3Qnm1T8TZc9G/7u0+CpqNJic=;
 b=F/P3YYzR0YuSzBEdsJviIwBK2niP82FmxoDAU4tfieBU18a8Dx4laMQo3wDQy1MpXk
 83EqUv6Bt/NQFVJhVFBpeDhQ6SLYY8HWHf7lLvsyd/aIeNmzaGTupDedAP28Dv21DF9/
 T3ogRMOMnbMOW2TSeUZqyLscsMAsUCgxs8qjIAZU86XeNkiQ85RH9EbDW5sSsV6flLT6
 0qmPja7JUs7Rio3YPO4t4Sq3f3PHeY/76l3ki/EXLBaOwPNZZ9MkcyPVDKhDSydhHvxq
 glgdPFiciqfPurTyyY65xltp+gQaF4GUJ5+de0B9nxH1zB/oL3/no3VboKDcJ1zaUfLt
 yJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7zvfu2AU8jmrgTOs2oC3Qnm1T8TZc9G/7u0+CpqNJic=;
 b=gYZWnT/Mya2gft3gThUrZEYEBhwLcI0JHNjd6YFaytYCgDkO+2++Y0AWvb0uyHVmZD
 /3rR6+udMlZPXx1TP8d6sXB9vLnCi7+zBRn3QAVSGDhBpVlOdVo+am1DphYGidU/s54y
 /YkKBwy9wHf+uWnQw+2dQ99Prn2j/5uemEKx+7ISclPdCEHmyB0dzXP3DvjZYccdiXR6
 35+VQn2k+HM+gOf6OtGraxaebH8f6i/tPighc7n9R5GLlaq5ZHBZOAt1OMCvYxUHqlCA
 184maczV1i32scu0iWUSzxdBvMkuYGn7CdPikTxiURzVXrcpyiA+VJ1rVOki7O/tIvHh
 W0fg==
X-Gm-Message-State: AOAM530xYQI+zdi4wvFBbxrHs7fSWCMkZOwWC557aL5RD6xKo8VcoMlt
 t4MxG/YBBVJol0B5IVM8oYZg/jxJ7iffBNKKdd4=
X-Google-Smtp-Source: ABdhPJxAJ3Q7byMBM1HV/edK0uLNbE0H4MLcNVMHoshKrEDVyrSu4I29uEnQ9PfyKsVM2BLofJjdvw==
X-Received: by 2002:a17:902:7d95:b029:d1:c91f:5675 with SMTP id
 a21-20020a1709027d95b02900d1c91f5675mr9052078plm.34.1600172048586; 
 Tue, 15 Sep 2020 05:14:08 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:14:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 07/26] tests: Fixes test-replication.c on msys2/mingw.
Date: Tue, 15 Sep 2020 20:12:59 +0800
Message-Id: <20200915121318.247-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Windows there is no path like /tmp/s_local_disk.XXXXXX
Use g_get_tmp_dir instead of /tmp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-replication.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index 9ab3666a90..e7cbd6b144 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -23,14 +23,14 @@
 
 /* primary */
 #define P_ID "primary-id"
-static char p_local_disk[] = "/tmp/p_local_disk.XXXXXX";
+static char *p_local_disk;
 
 /* secondary */
 #define S_ID "secondary-id"
 #define S_LOCAL_DISK_ID "secondary-local-disk-id"
-static char s_local_disk[] = "/tmp/s_local_disk.XXXXXX";
-static char s_active_disk[] = "/tmp/s_active_disk.XXXXXX";
-static char s_hidden_disk[] = "/tmp/s_hidden_disk.XXXXXX";
+static char *s_local_disk;
+static char *s_active_disk;
+static char *s_hidden_disk;
 
 /* FIXME: steal from blockdev.c */
 QemuOptsList qemu_drive_opts = {
@@ -571,6 +571,11 @@ static void setup_sigabrt_handler(void)
 int main(int argc, char **argv)
 {
     int ret;
+    const char *tmpdir = g_get_tmp_dir();
+    p_local_disk = g_strdup_printf("%s/p_local_disk.XXXXXX", tmpdir);
+    s_local_disk = g_strdup_printf("%s/s_local_disk.XXXXXX", tmpdir);
+    s_active_disk = g_strdup_printf("%s/s_active_disk.XXXXXX", tmpdir);
+    s_hidden_disk = g_strdup_printf("%s/s_hidden_disk.XXXXXX", tmpdir);
     qemu_init_main_loop(&error_fatal);
     bdrv_init();
 
@@ -605,5 +610,10 @@ int main(int argc, char **argv)
 
     cleanup_imgs();
 
+    g_free(p_local_disk);
+    g_free(s_local_disk);
+    g_free(s_active_disk);
+    g_free(s_hidden_disk);
+
     return ret;
 }
-- 
2.28.0.windows.1


