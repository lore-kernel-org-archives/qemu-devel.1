Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C3BC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC15C20815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC15C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54313 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFli-00063N-Vg
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:45:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFO0-0002Eb-Cc
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNw-0003EC-NY
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:24 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:43681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFNw-0003Cz-EE
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:20 -0400
Received: by mail-qk1-f171.google.com with SMTP id z6so2058350qkl.10
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=/L0JLOdIaBhKUSCjEGKCuHpfFulwdCMtoNoYZbrd6mk=;
	b=ZXP+9bYqrcgGjNrkRKGfatK3cJWI93FX2PoKobt11isAZrQqKbJpTIWj5B2mDIJNt/
	pmv86FyCqBxYr1/NBYp4pPwSouO67U5zmFPOqCXdl4K9mvQNwXwAw3iM4AGw4DkgbPvk
	JhPlMWRhQQM8hkMxXqSgzbCx1r5Ez8waMHj5tau4/XV42OhBkMhS7ViDobXY3+I0Ouo2
	W4eOvSG+LSAztgudKwn2Ih1qZUMwjSqmOd6RFmlYsGRj29T9SZfEjhSCWTRuZUGYp5+w
	PYuRZXNzMYLo1cLakDKc+pfvHkC/5fez+Aj01ETbOin6snBV81/jV//3SXKrdwihBVGT
	6QtA==
X-Gm-Message-State: APjAAAWVU5TQnvBefLYbvjrhXEcHCb/0KRZeW38zRwHqGBAKL+kUFjgd
	Ow6o/+wwETKDlIEa5qRDwy8n3Po2y5g=
X-Google-Smtp-Source: APXvYqxjpD+Zzsl/o3hQyidOkqDu0wszKEBJd0RDA7TNbrLOofHiWMjYo1hsChhO9jH05FSFNXQ9HQ==
X-Received: by 2002:a37:8241:: with SMTP id e62mr37211935qkd.355.1558009278475;
	Thu, 16 May 2019 05:21:18 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id e3sm3366811qkn.93.2019.05.16.05.21.16
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:21:17 -0700 (PDT)
Date: Thu, 16 May 2019 08:21:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-16-git-send-email-imammedo@redhat.com>
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
X-Received-From: 209.85.222.171
Subject: [Qemu-devel] [PULL 37/37] tests: acpi: print error unable to dump
 ACPI table during rebuild
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
Message-ID: <20190516122115.f-oTBwJ1NBvWTFZVaDteTEK_Y6CTEXDAoQw6HLnngAc@z>

From: Igor Mammedov <imammedo@redhat.com>

Instead of just asserting print the error that lead to assert first.
While at it move assert into rebuild branch, which removes redundant
check done in case of !rebuild branch is taken (the later is taken
care of by g_assert_no_error).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1556808723-226478-16-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index eaa1b0cf62..6cb8b16488 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -195,11 +195,14 @@ static void dump_aml_files(test_data *data, bool rebuild)
                                        sdt->aml, ext);
             fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
+            if (fd < 0) {
+                perror(aml_file);
+            }
+            g_assert(fd >= 0);
         } else {
             fd = g_file_open_tmp("aml-XXXXXX", &sdt->aml_file, &error);
             g_assert_no_error(error);
         }
-        g_assert(fd >= 0);
 
         ret = qemu_write_full(fd, sdt->aml, sdt->aml_len);
         g_assert(ret == sdt->aml_len);
-- 
MST


