Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E21C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FFA822209
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdzPw6UK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFA822209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWDM-0008Os-I7
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVuv-00071K-Ti
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVut-0008AY-Iz
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600256882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xl5qiRzwSRkCkfNitlG1ppcGEHzDiCZJWdHWHLlSBWk=;
 b=FdzPw6UKt3ClmKqIRhC/ZzOTmpHJ7smVFMwolFsC9zbFYk+WFhtoGPo4fb+xIuasrHPN8U
 4llM6poea1S/EJK5eXzEHeVWA9smZh04u+75Pk3qpgh9b3Fms7FapVxOYDzxNo1qYePhz+
 g31KbJ3NRJBHgQXPVLJHc1YQxHyjQqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-tYQT98DTPJ2mgFXamyktxg-1; Wed, 16 Sep 2020 07:47:55 -0400
X-MC-Unique: tYQT98DTPJ2mgFXamyktxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A56AE80EF9F;
 Wed, 16 Sep 2020 11:47:54 +0000 (UTC)
Received: from thuth.com (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AE875DEC1;
 Wed, 16 Sep 2020 11:47:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/24] tests: test-replication disable /replication/secondary/*
 on msys2/mingw.
Date: Wed, 16 Sep 2020 13:47:20 +0200
Message-Id: <20200916114731.102080-14-thuth@redhat.com>
In-Reply-To: <20200916114731.102080-1-thuth@redhat.com>
References: <20200916114731.102080-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

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
Message-Id: <20200915121318.247-9-luoyonggang@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.18.2


