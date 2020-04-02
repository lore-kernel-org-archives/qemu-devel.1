Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72142C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D9B206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="UaH9qInN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D9B206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzeE-0006OJ-C0
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1jJzdE-0005mR-LG
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1jJzdD-0006iD-FT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:11:40 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:11126)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1jJzdA-0006Yl-N4; Thu, 02 Apr 2020 09:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1585833097;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OgFQkZch/oM5un8LEmRzT+QveAnBoTeas/B8j4hRfYQ=;
 b=UaH9qInNbcBng1GM7QmXCcOOvw1Jby25zfA9QstqTOMnYnhBazlj5Gza
 vpo0L54Op+VMPaj6fWhsYunJ4RWyNQ+oCwAvSS8L1yJ3Bd/XUEUDQyxTa
 qRku7P0DOqePPULxKlf+9A3E/McU8sRvQu5do8XXAxSx+rjNfg4zFW7di Y=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: jrYCned0zzmId+3VG51uzDweAkYLKQvprNqgL3yH1dIw8ng0jdhCsTvy25IqzPnpxc4bRNChfr
 Y8Xmx+YTn/ac1cxN7kEjcDL+8SEboZc8wq3Kf3hbwuiEj0npO+0qxWFbX7TkmUAAx5GhYWyRkN
 noiN67KleqeMSoAxSApvDCkzcy0ODUukA56ZKBKld6tHlUdC1PS1RMLxdGrbq9p/v0kam0aniv
 00hfdjBg09FKh4nRPXym0f6CtUJlbLcv/3sJyytjdnVJWcqJLecS+N7odzBYScy+oaqEleLrsM
 /ic=
X-SBRS: 2.7
X-MesageID: 15286998
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,335,1580792400"; d="scan'208";a="15286998"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH for-5.0] xen-block: Fix double qlist remove
Date: Thu, 2 Apr 2020 14:08:19 +0100
Message-ID: <20200402130819.1216125-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.142
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit a31ca6801c02 ("qemu/queue.h: clear linked list pointers on
remove") revealed that a request was removed twice from a list, once
in xen_block_finish_request() and a second time in
xen_block_release_request() when both function are called from
xen_block_complete_aio(). But also, the `requests_inflight' counter is
decreased twice, and thus became negative.

This is a bug that was introduced in bfd0d6366043, where a `finished'
list was removed.

This patch simply re-add the `finish' parameter of
xen_block_release_request() so that we can distinguish when we need to
remove a request from the inflight list and when not.

Fixes: bfd0d6366043 ("xen-block: improve response latency")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/dataplane/xen-block.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 288a87a814ad..6cc089fc561f 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -123,15 +123,19 @@ static void xen_block_finish_request(XenBlockRequest *request)
     dataplane->requests_inflight--;
 }
 
-static void xen_block_release_request(XenBlockRequest *request)
+static void xen_block_release_request(XenBlockRequest *request, bool finish)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
 
-    QLIST_REMOVE(request, list);
+    if (!finish) {
+        QLIST_REMOVE(request, list);
+    }
     reset_request(request);
     request->dataplane = dataplane;
     QLIST_INSERT_HEAD(&dataplane->freelist, request, list);
-    dataplane->requests_inflight--;
+    if (!finish) {
+        dataplane->requests_inflight--;
+    }
 }
 
 /*
@@ -316,7 +320,7 @@ static void xen_block_complete_aio(void *opaque, int ret)
             error_report_err(local_err);
         }
     }
-    xen_block_release_request(request);
+    xen_block_release_request(request, true);
 
     if (dataplane->more_work) {
         qemu_bh_schedule(dataplane->bh);
@@ -585,7 +589,7 @@ static bool xen_block_handle_requests(XenBlockDataPlane *dataplane)
                     error_report_err(local_err);
                 }
             }
-            xen_block_release_request(request);
+            xen_block_release_request(request, false);
             continue;
         }
 
-- 
Anthony PERARD


