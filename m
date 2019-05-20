Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A713C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10ADC20863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10ADC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43565 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrgz-0004IK-93
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:27:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRH-0007od-Bi
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRG-0008KX-6M
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:27 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:44966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrRG-0008KG-2D
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:26 -0400
Received: by mail-qt1-f175.google.com with SMTP id f24so18319319qtk.11
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=TqEyVktznYJ7P+ZeySCJaFo5Dw05r/YzBTh1BaibXtY=;
	b=FYnMXmdXanbKT5Qo+p70CJrsu297RwjoIBMWlYamL7EnlTkHrODU/02hCgtn/+fBju
	NB4TYbGu3bUstY6vjvfbNiz/IQxwjunejXI4EpuHlaDTkKZjIqb1Cx+EXPs7QaVbSdhe
	+DYJjoEv4ZBCz2DORAEq85SjUYbNvfG4MnmvEQd5N8mmP9It0lFuARV+jS5VQfgDGeYU
	UPTTe3eRNNt2s8IAPT+EbANZhGPM3BAfjbfbdIgBK3C37pVLCuS+7k2GYeZKUQTA4eNA
	gW6ww377DKQEDTNuIvHKlCNqIout/C4Rvu8F3GyaEgGy+V8p1Fx0QhUAviy40pwV3WEs
	1TYw==
X-Gm-Message-State: APjAAAU5scVPR3iAwvSAVZRMuYFa4wMCWFzhTwO+wo2SMroRjcyVcj19
	6m7FU7JLATTRQBTVwPJ5Ldq6Q5WDyaM=
X-Google-Smtp-Source: APXvYqzfPzNL8U6y7zshMj1BhNWaTf1upJgpyihgbqrqJruD9kDiYDcXwjr2wZnxesE6sENvn4wfGQ==
X-Received: by 2002:ac8:6c4d:: with SMTP id z13mr36537502qtu.366.1558393884870;
	Mon, 20 May 2019 16:11:24 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	f67sm2222366qtb.68.2019.05.20.16.11.23
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:24 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-8-git-send-email-imammedo@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.175
Subject: [Qemu-devel] [PULL v2 28/36] tests: acpi: move boot_sector_init()
 into x86 tests branch
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231123.sJIJ5OzsF9oRIyX3ooXXsxWDxRpvyIE6il4CP5x6UYE@z>

From: Igor Mammedov <imammedo@redhat.com>

boot_sector_init() won't be used by arm/virt board, so move it from
global scope to x86 branch that uses it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1556808723-226478-8-git-send-email-imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index e2fc34143d..4d13a3cce6 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -788,13 +788,14 @@ int main(int argc, char *argv[])
     const char *arch = qtest_get_arch();
     int ret;
 
-    ret = boot_sector_init(disk);
-    if(ret)
-        return ret;
-
     g_test_init(&argc, &argv, NULL);
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        ret = boot_sector_init(disk);
+        if (ret) {
+            return ret;
+        }
+
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
-- 
MST


