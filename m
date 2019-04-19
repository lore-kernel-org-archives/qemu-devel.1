Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BEAC282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 14:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FE9222C8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 14:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JuJrQ2sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FE9222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHU9o-0005Nz-2V
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 10:06:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukasstraub2@web.de>) id 1hHU7i-0003ld-28
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 10:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukasstraub2@web.de>) id 1hHU00-000731-F8
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:56:17 -0400
Received: from mout.web.de ([212.227.17.11]:44585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hHU00-0006wy-4H
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1555682167;
	bh=NIpxH5ThknGkRJ6F3e+5pSUuOOjFOm5bswAT736K03Q=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=JuJrQ2spKtpUHadHgS4F37Mm+bZL+gPtTZ05OAYP8A7Xn17GOwGR6vO9HEmIhgkS/
	NsGy0Bq2YbC7GBKiJ6N89qdPCTC0q4NaP8oryRx/7Ck8roKNEk9FD1BkUHgLvmG2f2
	MMgaMK6qosfgmK5UsKw3tfxtBwg2S2ZLecBI0kXA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([46.91.89.140]) by smtp.web.de (mrweb103
	[213.165.67.124]) with ESMTPSA (Nemesis) id 0MBCJd-1h9Xtr484j-00AICR;
	Fri, 19 Apr 2019 15:56:07 +0200
Date: Fri, 19 Apr 2019 15:56:05 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Message-ID: <20190419155605.5349857a@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FOWPNRZw+hzvt8A4AnU8Db9Td57bXoINzU+y5mLnHDU9T6ZBfiY
	dJtA9z657cV6W+jYFvYKduMQBoconikLUH/bVnPc3wfE7LUlg+50ikGFapL7lb9T7yB9bRh
	fGWxMSo+cdu9RetZihPtLhxXaieqBfkbDHyzAHJ1MZtjgnei9tC4KyHvFMzpX2Rodk8h+4d
	E6Q4LsR6btxtEkUNanKgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jU1pFBqBRgs=:dllQByPVPhasFHdTQjgFLl
	8Voxt7YrH5udTebVg8RELT3v5Fex/nCH+EpWR/jtVUIY6JDdA0woxJNM4zCEvhXc/buMQUFeh
	2opLzEMb+m9D2/lM+7ZiIQrFqhcqcweg6/aVH8QPa1mg2XCPedz3eZYmeYkCaPQluNCt5Qzrc
	evUEacx8HwTBlUMxGZPqRE97fGJuvd96LR0pr1ZhOcbMBKdjq7RwmPKO0gcL0vO5/hteKT5Zk
	Hl5ejTyHWEV3VgBr7P/y91GaMAfG9axNpX1BpuBSVt+P5OznMfrGkkIiqCBxqSYV3I0wKr0Qk
	+5ADrMMpS3QpWo3k503AYwEoQBXryIclfmOHsaoVEWGotvxNTPTVlkxhnX1Hry+fDskJMDJUg
	Gd3odrQ1Jw3vPS+pDdqw/acBmGbKdu98necPK+UW5L6BlqXgcFRNBEpqOn7CqtiOyqgpAu9q5
	XKL162zDn93R3vQp1zAu3siiI8baTGmaCt5s45BvOpPTNz9Kcw1Wd/I93br7CrtQEVxIp4c+4
	iopXmr0BMjq4S/PozWy0b3tqgNVSFYqzX+B+OzlQcp+CAjhVwlvFFi4lcN+Dygm/PO1UEzoAS
	sLtQRctbk7Bi61V3MAbp6WMAr4Z9yp42NHWQAE51AWS2WbacyorMVwBK+wsst/7YwesvcIp7i
	kg1uNZaz05LCR59uYaBdh7afCZhPVl2e7oj+A1psr5I+H2yjYmCXWiNMNwI+fvIJDr+ghMDDV
	ZB7oQWo+HgQhioUjHpkUT0hxs1Bw01Vg7zgA6vxrDigDEKCjs5DCJ9h+DsutCWLXHQQgzJtuF
	k1CBt3JnlNd8uPxWhFU/jKufSYH2TSTOnXO9K3OuE0XX1KH4lkWsVNPatFwaKkLdehPiM06o8
	K1c8igHHMmT1059PrRAlmDF//6NSsPri2qp2RUd+bk8CTxaO4M7wyg0pNyxwjDSLvdHOh2yp4
	Ak1JJrY7KZA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
Subject: [Qemu-devel] [PATCH] net/colo-compare.c: Fix a crash in COLO
 Primary.
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419135605._QLStUjsd-v3_cy4dBDOcvdXMny8I8LtJgY0wWXnGuw@z>

From: Lukas Straub <lukasstraub2@web.de>
Fixes the following bug: https://bugs.launchpad.net/qemu/+bug/1824622

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 net/colo-compare.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index bf10526f05..fcb491121b 100644
=2D-- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -813,9 +813,8 @@ static void colo_compare_handle_event(void *opaque)
         break;
     }

-    assert(event_unhandled_count > 0);
-
     qemu_mutex_lock(&event_mtx);
+    assert(event_unhandled_count > 0);
     event_unhandled_count--;
     qemu_cond_broadcast(&event_complete_cond);
     qemu_mutex_unlock(&event_mtx);
=2D-
2.20.1


