Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F2C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA0F214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA0F214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwHJ-0006al-S3
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iIwG2-0004uk-KD
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iIwG1-0007Ec-Nf
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iIwFz-0007Bm-Hl; Fri, 11 Oct 2019 10:51:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C03A07E421;
 Fri, 11 Oct 2019 14:51:02 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4903601AF;
 Fri, 11 Oct 2019 14:51:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH 3/5] iotests: Test 183 does not work on macOS and OpenBSD
Date: Fri, 11 Oct 2019 16:50:45 +0200
Message-Id: <20191011145047.19051-4-thuth@redhat.com>
In-Reply-To: <20191011145047.19051-1-thuth@redhat.com>
References: <20191011145047.19051-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 11 Oct 2019 14:51:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running 183 in Cirrus-CI on macOS, or with our vm-build-openbsd
target, it fails with an "Timeout waiting for return on handle 0" error.

Let's mark it as supported only on systems where the test is working
fine (i.e. Linux and FreeBSD).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/183 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index bced83fae0..feeadb74c8 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.qemu
 
+_supported_os Linux FreeBSD
 _supported_fmt qcow2 raw qed quorum
 _supported_proto file
 
-- 
2.18.1


