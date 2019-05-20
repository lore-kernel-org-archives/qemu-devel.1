Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8066C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97CB21479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97CB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrwb-0000Yx-VA
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:43:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRB-0007kU-QG
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRA-0008Hq-Rq
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrRA-0008H9-Mc
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id y22so18334039qtn.8
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=AA6TCSyeHGpA1YTEQq8+big2sU8sv1fUdc6SF09NwiI=;
	b=I3q6cQFyA0+1TC0Kybl72TwbCqk5qLaHYZUeyRbDBrtbNnh5YZzupMrgnsOuiVBS0r
	WLPy7YANIvHKyQarAculWLziDg1cXv4UBRpnu6juX41yt+E3F5fKaV1WQy9lzPNhqOkJ
	mCAP+FdduhrYLn0nvkedAds1lme3OI38vQ/hh00EsQZS91luaIwLe97BmQMwLW7dQa16
	wp2xlqq3fRBdIzsIhgprn/CEXbvPNLkrUqEVoz7wo26k61rAbkaPNY/JMPqV3ST47OxK
	e8PxKaCeHXwpbDvpjo2ZQ3H2LDbqH1vAuqK4MCOiAKCROQcVb/J/tBPfpQJwMdGOJytz
	93jA==
X-Gm-Message-State: APjAAAXxeqZq+EEEEnYctGFIZwxsbp6qIR6cjilFy8niQFfiZ1b7VxTb
	3fRT6u/rTYYkZLavyYqI3E8uOZ5FWT0=
X-Google-Smtp-Source: APXvYqweO2FSf0KBGfsyOLamyL6ph93dcAE15sECr94j0y8FXYuWHwb7WtfCcH4bsErdVwDCSOeXCA==
X-Received: by 2002:ac8:313d:: with SMTP id g58mr58182578qtb.289.1558393879125;
	Mon, 20 May 2019 16:11:19 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id x6sm9127190qti.88.2019.05.20.16.11.17
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:18 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-5-git-send-email-imammedo@redhat.com>
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
X-Received-From: 209.85.160.196
Subject: [Qemu-devel] [PULL v2 25/36] tests: acpi: make pointer to RSDP 64bit
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
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231117.Z4A_VKu7lY8R5nCNEq7ejZGQbUJYftPjNtOfUwElNUc@z>

From: Igor Mammedov <imammedo@redhat.com>

In case of UEFI, RSDP doesn't have to be located in lowmem,
it could be placed at any address. Make sure that test won't
break if it is placed above the first 4Gb of address space.

PS:
While at it cleanup some local variables as we don't really
need them.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1556808723-226478-5-git-send-email-imammedo@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-utils.h       |  2 +-
 tests/acpi-utils.c       |  2 +-
 tests/bios-tables-test.c | 10 ++++------
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index a4f43a18ae..0ceb499469 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -46,7 +46,7 @@ typedef struct {
 
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(QTestState *qts);
-void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
+void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);
 void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
                       const uint8_t *addr_ptr, int addr_size, const char *sig,
                       bool verify_checksum);
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index a0d49c4371..c216b9e0e9 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -51,7 +51,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
     return off;
 }
 
-void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
+void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table)
 {
     uint8_t revision;
 
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index d6ab1218da..a164d274a2 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -26,7 +26,7 @@
 typedef struct {
     const char *machine;
     const char *variant;
-    uint32_t rsdp_addr;
+    uint64_t rsdp_addr;
     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
     GArray *tables;
     uint32_t smbios_ep_addr;
@@ -86,13 +86,11 @@ static void test_acpi_rsdp_address(test_data *data)
 
 static void test_acpi_rsdp_table(test_data *data)
 {
-    uint8_t *rsdp_table = data->rsdp_table, revision;
-    uint32_t addr = data->rsdp_addr;
+    uint8_t *rsdp_table = data->rsdp_table;
 
-    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
-    revision = rsdp_table[15 /* Revision offset */];
+    acpi_fetch_rsdp_table(data->qts, data->rsdp_addr, rsdp_table);
 
-    switch (revision) {
+    switch (rsdp_table[15 /* Revision offset */]) {
     case 0: /* ACPI 1.0 RSDP */
         /* With rev 1, checksum is only for the first 20 bytes */
         g_assert(!acpi_calc_checksum(rsdp_table,  20));
-- 
MST


