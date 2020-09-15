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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AF3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C44921D41
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt4A0vJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C44921D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEfx-0001bG-Eq
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWv-0008Og-Od; Tue, 15 Sep 2020 13:14:09 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWM-0002gA-NO; Tue, 15 Sep 2020 13:13:37 -0400
Received: by mail-pf1-x441.google.com with SMTP id w7so2336338pfi.4;
 Tue, 15 Sep 2020 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=18mOftWXQC3Rn89AKTi/Z7fcDnMtQzhw+fXUDjoqjy0=;
 b=Vt4A0vJXOs9wVgs/hfrA1qtZUGoXiPgwlNwb0t9KM7OSeBHOSU4JWLr66tcl4J0gQK
 oGKTXRJDCVpqWRoVV1MSNN0ZDep7AdmgdhmfbfeW2D0DhCKw+VpDtheTR0h6nvADrFQg
 mB/o6yz4wamf/Z7PJvS9Suoxp8O+nJJB3Fkh9tFXEDp3STgi0yW3hvUkWtRoEIyW/Hol
 UnoX2/3hZHXfHeD+Vp13nn8hDR7AcR6yV/96ZQBLDmV7Y9oQ1YxTIwcp+ZwBODC2pVdT
 6ysQLJp+OENtd4/Qq4FQ1/YqQZpkfl4jZ0vbGK0OmUW3Mz5rPJLHHn4x6bKrff+g/NeK
 8w5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=18mOftWXQC3Rn89AKTi/Z7fcDnMtQzhw+fXUDjoqjy0=;
 b=GdblHjdnFHBo0oHUqO0db6lpLjffFGVcHySe/gcB6t8L3zAMCqYauMzwhM5bmmEwfd
 R/vx3RlNVd3J42Q/D9Y6Kby64YpRy1Yl03k3rTKT7idOX9Ex5dRz3UeyngjR4GiLHdlW
 pR4aAY4WLI30OdU19ZnOvdPal5yM2wRHvKAHHUD/GKzuhpFaEcp29ETHdeAjrx26Dv/7
 S8bNscoTGH/hvLhhkdQCqWc2N3IGGFmJkD+Mk6LQEkf7HeWiMptiBZmlUfTE8bkof8GG
 M0om8A3Q6nzHpzXN9JatBfQmwOD7nk4zMKKekrU8UL7chjFtL0GWwpLz7VG3zpHYQJR8
 QS0A==
X-Gm-Message-State: AOAM532Q12RbRJL4UTbrK/jPh9LcpeQhNX/6Vdxy5lhPBb8RGjvwdWcx
 6tf7RaO+Fy6edZDv4wdY3dY7LoDxacNPkRNgLS4=
X-Google-Smtp-Source: ABdhPJyT6p9ZG4kmS7bjol52ErEy4+rp6+DPF2FpV9p3odCbZcxRGoSwmaumxGiCLDwXydtWUVzbCA==
X-Received: by 2002:aa7:9f4e:0:b029:142:2501:39f1 with SMTP id
 h14-20020aa79f4e0000b0290142250139f1mr2816705pfr.64.1600190008769; 
 Tue, 15 Sep 2020 10:13:28 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:13:27 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 08/26] tests: test-replication disable
 /replication/secondary/* on msys2/mingw.
Date: Wed, 16 Sep 2020 01:12:16 +0800
Message-Id: <20200915171234.236-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They caused failure on msys2/mingw, that's because file-win32.c not implement
.bdrv_reopen_prepare/commit/abort yet.

This is the error message:
> $ ./tests/test-replication.exe
> # random seed: R02S3f4d1c01af2b0a046990e0235c481faf
> 1..13
> # Start of replication tests
> # Start of primary tests
> ok 1 /replication/primary/read
> ok 2 /replication/primary/write
> ok 3 /replication/primary/start
> ok 4 /replication/primary/stop
> ok 5 /replication/primary/do_checkpoint
> ok 6 /replication/primary/get_error_all
> # End of primary tests
> # Start of secondary tests
> ok 7 /replication/secondary/read
> ok 8 /replication/secondary/write
> Unexpected error in bdrv_reopen_prepare() at ../block.c:4191:
> Block format 'file' used by node '#block4287' does not support reopening
> files

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-replication.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index e7cbd6b144..b067240add 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -392,6 +392,7 @@ static void test_secondary_write(void)
     teardown_secondary();
 }
 
+#ifndef _WIN32
 static void test_secondary_start(void)
 {
     BlockBackend *top_blk, *local_blk;
@@ -546,6 +547,7 @@ static void test_secondary_get_error_all(void)
 
     teardown_secondary();
 }
+#endif
 
 static void sigabrt_handler(int signo)
 {
@@ -597,6 +599,7 @@ int main(int argc, char **argv)
     /* Secondary */
     g_test_add_func("/replication/secondary/read",  test_secondary_read);
     g_test_add_func("/replication/secondary/write", test_secondary_write);
+#ifndef _WIN32
     g_test_add_func("/replication/secondary/start", test_secondary_start);
     g_test_add_func("/replication/secondary/stop",  test_secondary_stop);
     g_test_add_func("/replication/secondary/continuous_replication",
@@ -605,6 +608,7 @@ int main(int argc, char **argv)
                     test_secondary_do_checkpoint);
     g_test_add_func("/replication/secondary/get_error_all",
                     test_secondary_get_error_all);
+#endif
 
     ret = g_test_run();
 
-- 
2.28.0.windows.1


