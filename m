Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2A8C282DA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFC92175B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFC92175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48028 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCY2N-0004Y1-Cy
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 19:14:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0p-0003Xa-5N
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0o-0003V9-7M
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:43 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY0n-0003QV-Lg
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:42 -0400
Received: by mail-qt1-f170.google.com with SMTP id k2so9398652qtm.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=yAwnkjL068uH+yovrU/L/oje0/QyUNj3ge2/oaPBdeA=;
	b=LLH3/Ja6RcnBB28Dx2oELsoLYJJXgy4qVJT8WpStCto59ou0y4fSPilFoK8EZoqT4U
	iKcTYhozfJeM/dAGgQtbVlB/Q5yc38f7rgZon/DZTF8Gpr5QWCuoyIJpr6C3KYhJvwME
	fT9NHefiaqhCs7pp3BlKhkiU0yfzmlBtW1/02YVSeLsaWdJRj9w5YJycKMYiPMpsq/3y
	mXz6U4nMOXIM8vrStAzNVkFzKDTwNWf8mwmkbKbFzqqa/WPcgDA+cLnqb4F7pBDlWs6X
	mzTwUj1dpu76WqJXzvm8wbQ4YOk3B8MFMy71T0l6hxr7X7zb4bXx8PTw0/g2pH9W7LS8
	hAFg==
X-Gm-Message-State: APjAAAVyz9sH1C43b73ebtN0X2OJo71brMSMxYbXeCpDroWfnKYTIh4K
	AVK8MV7ErPiUJR1NAS910nMozraYgOc=
X-Google-Smtp-Source: APXvYqwsdxfUz8CCrgYRxLKZyUwgmqLUFdW/Jr45DuAX/mw7o/b+hfYJ912rUJRUwjnbhOTgMAfxeA==
X-Received: by 2002:ac8:29f1:: with SMTP id 46mr13872008qtt.126.1554505960819; 
	Fri, 05 Apr 2019 16:12:40 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	q50sm15895851qtq.34.2019.04.05.16.12.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 16:12:40 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:12:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1553199229-25318-1-git-send-email-liam.merwick@oracle.com>
References: <20190405231225.30165-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190405231225.30165-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.170
Subject: [Qemu-devel] [PULL 1/5] acpi: verify file entries in
 bios_linker_loader_add_pointer()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405231239.NLtoS6k4o3m2d8yvn1WsTB4g3e2mafH-kY7NCSBsfVM@z>

From: Liam Merwick <liam.merwick@oracle.com>

The callers to bios_linker_find_file() assert that the file entry returned
is not NULL, except for those in bios_linker_loader_add_pointer().  Add two
asserts in that case for completeness and to facilitate static code analysis.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Message-Id: <1553199229-25318-1-git-send-email-liam.merwick@oracle.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/bios-linker-loader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index d16b8bbcb1..626c04a39f 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -283,6 +283,8 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
     const BiosLinkerFileEntry *source_file =
         bios_linker_find_file(linker, src_file);
 
+    assert(dst_file);
+    assert(source_file);
     assert(dst_patched_offset < dst_file->blob->len);
     assert(dst_patched_offset + dst_patched_size <= dst_file->blob->len);
     assert(src_offset < source_file->blob->len);
-- 
MST


