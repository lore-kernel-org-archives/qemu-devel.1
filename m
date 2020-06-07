Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFFBC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 05:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D755F20659
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 05:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyZc7Wms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D755F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhnkC-0006Ry-0b
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 01:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jhnjW-0005rw-PR
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 01:20:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30544
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jhnjU-0002bI-WB
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 01:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591507231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=/UdE3J2pIrzieTPi4pZhyBxCm0WRD+KBs7JIaKKXWKM=;
 b=OyZc7WmseDXm3QhRc924IN70BgEpcPLJODrJCKyL82nZY5AskgfH/veXltOuwehlGr82DA
 nKH3Dsv5zPhDOKyrYZ06ng8ore5zqhVu2lT6QdMdaw2bFJ3zFKd+GeRUCOSpDk0bk0Bjr7
 tAd6dBtVZdFhM4+ORSlwYWcMDLPUZLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-Htk4CUTWOEGjW7pgINbgJQ-1; Sun, 07 Jun 2020 01:20:29 -0400
X-MC-Unique: Htk4CUTWOEGjW7pgINbgJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA1CE8015CE
 for <qemu-devel@nongnu.org>; Sun,  7 Jun 2020 05:20:28 +0000 (UTC)
Received: from thuth.com (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A41F41C950;
 Sun,  7 Jun 2020 05:20:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH] MAINTAINERS: Fix the classification of
 bios-tables-test-allowed-diff.h
Date: Sun,  7 Jun 2020 07:20:22 +0200
Message-Id: <20200607052022.12222-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 01:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The file tests/qtest/bios-tables-test-allowed-diff.h is currently only
assigned to the qtest section according MAINTAINERS. However, this file
normally only gets updated when the ACPI tables changed - something the
qtest maintainers don't have much clue of. Thus this file should rather
be assigned to the ACPI maintainers instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7890ce82..0c5ed09ad5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1531,7 +1531,7 @@ F: hw/acpi/*
 F: hw/smbios/*
 F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
-F: tests/qtest/bios-tables-test.c
+F: tests/qtest/bios-tables-test*
 F: tests/qtest/acpi-utils.[hc]
 F: tests/data/acpi/
 
@@ -2321,6 +2321,7 @@ S: Maintained
 F: qtest.c
 F: accel/qtest.c
 F: tests/qtest/
+X: tests/qtest/bios-tables-test-allowed-diff.h
 
 Device Fuzzing
 M: Alexander Bulekov <alxndr@bu.edu>
-- 
2.18.1


