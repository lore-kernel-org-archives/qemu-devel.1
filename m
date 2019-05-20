Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EAAC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C7A21479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C7A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43852 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSs01-0002XH-5F
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:47:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRY-0008AQ-UY
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRR-0008Og-IE
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrRN-0008Mc-MV
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id d4so9898068qkc.9
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=O6n0khQFEgae8Zf5gTf32VcUPNdO94dtxMG+VrGCx/0=;
	b=V3Thkzrtod4U08vcnHOjxc4I5ajtQCiDCQtKKsrnhANnTypiumLCkvRO716PxaVOH1
	k6aFbqRBI7Jm+kGobuV4WbjbtD7tXfVdQK+KEVLvVCxuiJEv3yi28R6l9MhpQ4PG/Gmt
	gZ0+l/wwsCygbF69a1e7eLlUziamJAOJnPnvsPlIn2jPMXCEfudshu0Uh0P0sNJvs3fz
	6JmdBT/TMwBLj7AmU5x2EVpD9+MusNajPlAOyOveuPn2GDsP7NjBvrAHSwIz4B1d32gv
	irkrcnjoCqFxYlethlkmY2N123voo/PgHJjWKmWLLnOefpUhR5116kmfoF8G0tB5fx3B
	xqlw==
X-Gm-Message-State: APjAAAXPnEMTPbS2jizXPZAU9tVlu31XdmtJbVZjSymGfnywXKLTv0e/
	T2Rq15f25/jgb3q0VhrC2+Pbny1Pv9c=
X-Google-Smtp-Source: APXvYqwVa6ENFueyW98YWb0rRgThjxJXZvwZu/FPi0w4UGHoIpKTG3lbSQrlG9Ic761VVCgFO+AExA==
X-Received: by 2002:a37:dcc4:: with SMTP id
	v187mr27360335qki.290.1558393891002; 
	Mon, 20 May 2019 16:11:31 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	f21sm8286074qkl.72.2019.05.20.16.11.29
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:30 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-11-git-send-email-imammedo@redhat.com>
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
X-Received-From: 209.85.222.195
Subject: [Qemu-devel] [PULL v2 31/36] tests: acpi: ignore SMBIOS tests when
 UEFI firmware is used
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
	Peter Maydell <peter.maydell@linaro.org>,
	Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231129.oPaBiUVWn_TlKHbV-d5t_C8hc4ys7suqr4TOJ0ag3-c@z>

From: Igor Mammedov <imammedo@redhat.com>

once FW provides a pointer to SMBIOS entry point like it does for
RSDP it should be possible to enable this one the same way.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <1556808723-226478-11-git-send-email-imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 84e1ce2972..8302ffc2cd 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -569,8 +569,15 @@ static void test_acpi_one(const char *params, test_data *data)
         }
     }
 
-    test_smbios_entry_point(data);
-    test_smbios_structs(data);
+    /*
+     * TODO: make SMBIOS tests work with UEFI firmware,
+     * Bug on uefi-test-tools to provide entry point:
+     * https://bugs.launchpad.net/qemu/+bug/1821884
+     */
+    if (!use_uefi) {
+        test_smbios_entry_point(data);
+        test_smbios_structs(data);
+    }
 
     assert(!global_qtest);
     qtest_quit(data->qts);
-- 
MST


