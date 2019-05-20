Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9A4C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0544120863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0544120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrm4-0000f3-7r
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:32:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRc-0008Er-Ox
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRa-0008Sz-TJ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:48 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:46812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrRa-0008Sm-Oh
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:46 -0400
Received: by mail-qt1-f181.google.com with SMTP id z19so18284094qtz.13
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=/L0JLOdIaBhKUSCjEGKCuHpfFulwdCMtoNoYZbrd6mk=;
	b=bEUycg0sxOKul6sk7MQPML9CeuNxfVtCgv0Tp/pxsivC+SXAV8eRAtIiUSP8VLcL+E
	aEzkqhtBXJ3EYWDIJgPRYF1WEoDO9RAWASyjyzmfwzGync1trSBL2fiQqB+aAaemv9p+
	mlKuDv2gFehDtpJ7xOuc70rzufic6pee5KZCqkcw7gmU5saGk4atRy0gUObLyULurlS5
	rR3U6SuFqGNVtqAirsNQ4BQd0Dmlc+GFOZF//kChGXvEh3leoHXZfPfSmLk7OBiY8veF
	AOuMRuP+D88vpY3v19z/CiM6VVam+DH1KFAn3SM0HoOEtJFHhwX+dsTtZgCNiDgPW4XS
	2b5A==
X-Gm-Message-State: APjAAAVNH6mQ0OPPNeH34cZblMzcLO+QwM/H8RbJaDlfy119ip7Avtav
	HybHIZEHhFboWVTQr67iP5YgjwOk6ws=
X-Google-Smtp-Source: APXvYqzyy4R+oUQKX2I9Z6MtqjDgVt55rOjChGzPRHZBroO9+VJnNt9/8PAbueyiS3KLQGiiCLUWUg==
X-Received: by 2002:a0c:b626:: with SMTP id f38mr7747163qve.223.1558393905975; 
	Mon, 20 May 2019 16:11:45 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id t3sm6648981qto.36.2019.05.20.16.11.44
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:45 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-16-git-send-email-imammedo@redhat.com>
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
X-Received-From: 209.85.160.181
Subject: [Qemu-devel] [PULL v2 36/36] tests: acpi: print error unable to
 dump ACPI table during rebuild
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
Message-ID: <20190520231144.6tSc5A4PskY8YLNILCOVCz5wqOYwZRTmnYqKpJcp-xA@z>

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


