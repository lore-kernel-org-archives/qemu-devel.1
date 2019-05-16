Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29BBC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B816620815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B816620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54105 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFeL-0008HN-0r
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:38:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNg-00020r-GM
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNd-000310-EO
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFNd-00030l-BV
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id t1so3513946qtc.12
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=O6n0khQFEgae8Zf5gTf32VcUPNdO94dtxMG+VrGCx/0=;
	b=iT6HadnegvUbEGp1TvyoQhsRsUO7ZZTzOZlWtqR1Y7v5bKJp1WJn19OtW+pzO5QCdI
	eCP1tt07LVpWkYp116GN+N+T6pvDJ/cSt+5RqfmXIx+7Fk2K65GESWfInrn65h54Jty0
	tOXyj/z55K6yxFjEuy9QKorGHZqfpWGtKZsBgdggFIipn6D4bG6XQrJXUNWzh3njaSB0
	wkrfUBa5rO8JdXVm1bAkrUvVQsMP+QeTynPQkmAakmvGtSAY8HxS/kqs/wg+9+4a5au8
	zTJV1CQnyY5KRApvkJyF1DMKFhlHFmSPnFLEYQ0x8NN3zTLLcyOMC1KMQCuR6GAmm+rd
	5tIQ==
X-Gm-Message-State: APjAAAXHovQ4f+UEADom3DaxpoDs870yDUid/k9RBRVQZrT0h+QRbZmv
	ULlVeWUCaBJxZhBiWuF1Ehb8HNp7/9w=
X-Google-Smtp-Source: APXvYqyLch0baUZCR76c4Q/F+Nz4Dts5TiAFP47+rkYXqdQx5bNr9nPBBWpmY2gA6KVqP/se90J8bg==
X-Received: by 2002:a0c:814d:: with SMTP id 71mr39809452qvc.47.1558009260688; 
	Thu, 16 May 2019 05:21:00 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	b27sm3156376qtb.53.2019.05.16.05.20.58
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:20:59 -0700 (PDT)
Date: Thu, 16 May 2019 08:20:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-11-git-send-email-imammedo@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: [Qemu-devel] [PULL 32/37] tests: acpi: ignore SMBIOS tests when
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
Message-ID: <20190516122052.6dsFhNS3gJfH5D_5gkwuNmJSox_YmdoYf2CRotRcxXs@z>

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


