Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD05C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9502075D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un1COuSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9502075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3e2r-0003JU-I1
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3dXo-0005Qs-2g
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:54:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34336
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3dXj-0000Ns-6Y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596711278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=5qakGv2SRjWkcEgBZWP7EefV+cPuJFE+yK79HsvsXaI=;
 b=Un1COuSzxK+nUTr6PwOyN990sN+j6OJ6Ft50ouELbSKqnqKUuD0gbx3hRtt0KbVLpKk7UK
 pog6ctsHseoN8R9rAkWHGwKhoppXZLuFD8uVb5IrjlXWAaAOFYrykVhCxAJdWnvn0+jNsR
 UBklWxrHrbgiLdmnMMtTpRvZ/4IzqZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-PMISKduCMiWaWw81A95dgA-1; Thu, 06 Aug 2020 06:54:37 -0400
X-MC-Unique: PMISKduCMiWaWw81A95dgA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BFEF800404;
 Thu,  6 Aug 2020 10:54:35 +0000 (UTC)
Received: from thuth.com (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 233685F202;
 Thu,  6 Aug 2020 10:54:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.2 v2 9/9] tests/qtest/cdrom: Add more s390x-related boot
 tests
Date: Thu,  6 Aug 2020 12:53:49 +0200
Message-Id: <20200806105349.632-10-thuth@redhat.com>
In-Reply-To: <20200806105349.632-1-thuth@redhat.com>
References: <20200806105349.632-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-block@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's add two new tests:

1) Booting with "bootindex" is the architected default behavior on the
s390x target, so we should have at least one test that is using the
"bootindex" property.

2) The s390-ccw bios used to fail when other unbootable devices have
been specified before the bootable device (without "bootindex"). Now
that the s390-ccw bios is a little bit smarter here, we should test
this scenario, too, to avoid regressions.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/cdrom-test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index 833a0508a1..13e22f57c1 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -163,6 +163,18 @@ static void add_s390x_tests(void)
     qtest_add_data_func("cdrom/boot/virtio-scsi",
                         "-device virtio-scsi -device scsi-cd,drive=cdr "
                         "-blockdev file,node-name=cdr,filename=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/with-bootindex",
+                        "-device virtio-serial -device virtio-scsi "
+                        "-device virtio-blk,drive=d1 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
+                        "-device virtio-blk,drive=d2,bootindex=1 "
+                        "-drive if=none,id=d2,media=cdrom,file=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/without-bootindex",
+                        "-device virtio-scsi -device virtio-serial "
+                        "-device x-terminal3270 -device virtio-blk,drive=d1 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
+                        "-device virtio-blk,drive=d2 "
+                        "-drive if=none,id=d2,media=cdrom,file=", test_cdboot);
 }
 
 int main(int argc, char **argv)
-- 
2.18.1


