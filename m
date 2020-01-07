Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDAAC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 06:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BB52073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 06:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BB52073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iohys-00014j-AP
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 01:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wang.yongD@h3c.com>) id 1iohvv-0004BA-41
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 01:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wang.yongD@h3c.com>) id 1iohvt-0005gt-Qw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 01:01:38 -0500
Received: from smtp.h3c.com ([60.191.123.50]:52480 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wang.yongD@h3c.com>) id 1iohvs-0005aL-Fs
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 01:01:37 -0500
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([10.8.0.70])
 by h3cspam02-ex.h3c.com with ESMTPS id 00760xDd057934
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Jan 2020 14:00:59 +0800 (GMT-8)
 (envelope-from wang.yongD@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Jan 2020 14:01:01 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Tue, 7 Jan 2020 14:01:01 +0800
From: Wangyong <wang.yongD@h3c.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mark.kanda@oracle.com" <mark.kanda@oracle.com>,
 "hch@lst.de" <hch@lst.de>
Subject: [PATCH] linux-aio: increasing MAX_EVENTS to a larger hardcoded value
Thread-Topic: [PATCH] linux-aio: increasing MAX_EVENTS to a larger hardcoded
 value
Thread-Index: AdXFH2NLa0A87O+DRx2QfJMBGFrevg==
Date: Tue, 7 Jan 2020 06:01:01 +0000
Message-ID: <faa5781afd354a96a0be152b288f636f@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.162]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 00760xDd057934
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 60.191.123.50
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
Cc: Changlimin <changlimin@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 6040aedddb5f474a9c2304b6a432a652d82b3d3c "virtio-blk:
make queue size configurable",if the user set the queue size to
more than 128 ,it will not take effect. That's because linux aio's
maximum outstanding requests at a time is always less than or equal
to 128.

This patch simply increase MAX_EVENTS to a larger hardcoded value of
1024 as a shortterm fix.

Signed-off-by: wangyong <wang.yongD@h3c.com>
---
 block/linux-aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/linux-aio.c b/block/linux-aio.c
index c7eca9a256..91204a25a2 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -26,7 +26,7 @@
  *      than this we will get EAGAIN from io_submit which is communicated =
to
  *      the guest as an I/O error.
  */
-#define MAX_EVENTS 128
+#define MAX_EVENTS 1024

 struct qemu_laiocb {
     Coroutine *co;
--
2.12.1.windows.1

