Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1794C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 17:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DC620833
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 17:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="R3NFYLYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DC620833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHts1-0003R0-Am
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 13:33:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukasstraub2@web.de>) id 1hHtoI-000174-Ap
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 13:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukasstraub2@web.de>) id 1hHtZV-0006Zv-M3
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 13:14:38 -0400
Received: from mout.web.de ([212.227.17.12]:34047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hHtZV-0006TY-Cn
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 13:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1555780467;
	bh=B2vnL8cskgePAMIBWEzCG89t4Le6gqq4G4XQoKWpkuY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=R3NFYLYmhyIGFPaBy9LMF+ZC2dfHvECBI7dXF+JAe3wU36LTtou3ldnuB/5+7rGaZ
	eVPGBSwGIiQsaAYgBSRQhH06BnnO+D75TsbHoG9hauoRnS1VBFpUot4F99CLJNRv2Z
	dAViwZ3CjO9PqKzYgDMGSShJ+ZsyGRKuwjxNNIiY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([46.91.89.139]) by smtp.web.de (mrweb101
	[213.165.67.124]) with ESMTPSA (Nemesis) id 0MQvsg-1hP1Lw3YGU-00ULam;
	Sat, 20 Apr 2019 19:14:26 +0200
Date: Sat, 20 Apr 2019 19:14:25 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Message-ID: <20190420191425.7d1dab82@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+GA36cDvXqQY+sy7ZAgMf4rVSaAFp2491DsABo1QspY791wZBka
	mIvvEaKpwtxQPzjC9zQpXJSGC7t+RbP+ZuVitYuQzPgs7906FwRMuC9jFYSDNH7+LS+tsio
	Y3tG42u+2MLcy4hpHOwe3diijwkPBAynRNuCZMySOnaEle0cQ+iDPJDQ2Gq11lNofmN9cYv
	FmDjS3wOy9unN5E589Z8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N5t/V2DmoIQ=:sYcTqsYp6n5AjSem0yAz+N
	pEPnEWGuMeMKEhSoftSzzDigyUSNjkeFnG0PUW0FsAEof39EnxFEnDrJ5Brw9CC5yVEe/T9sp
	DT8J/9SfBqJbRHzMn3Hp6sxYcktedwsRAXEA7njd2GmvdAZpksIX4mO72iT9ZgCv1do7A42hn
	l5YkkMJxWFLKLSXcxmWkEo+9T47fnl1gYrW9I+9T+nOoQIdI0857NkqlFfY4b41kOvbrO/paa
	9J37gGDGqcO9nYEWFQI6kSe05qF9bTvKw/RzVz3f1pB5eUBOFsiWVaYj0yvK2Z35LpyiAqrMc
	GP7XWOSCd3imJvHv+m1eI1Nvo4h1qYWFqRK4kKatAh7XcrnQZh1C2v3Cp2rRWqfhZrv1dfGuo
	PC2fH27F8f2c6L5XGrunRurvNgjwn+7+CxSJdsdMTZP4wPbgy97qbhXyCm5u38KW7aaVTc5aO
	Gam66vQ0cRARuJW8HG8ZYv2fS940F0asYcGfogOkdW+STlvg3/UqTYxjC6F/xKDMy/lYhNjnK
	JZtvK68DZP/U513OTUERvdqiyGtbp6e0wtkG9eLAnqMgMZSlRhvrwqUTXod5HwAsNZFxUGt/q
	FE+USE1ZdB2Z7OVwhVl2boA0k5HSdzlvvyDuPD7xID1lc8sqYr2U22F8IySJX3MNWc7ih0ENp
	M1cQI6Rjnw6jlgtGNaaixd3NS5U/sGWEt/NbENwndoUNg8c7LdiuqThc1+SvKJl023i8sgYGc
	h9u0ZsKtPU9gc7ORuHCoHiZwTSzvROZ2G7mzfqROWGO/s+tk1e7VLH8EdD/rfz1+j8NR8T4+u
	mZDMF//D8iXT+HWxK2arsj73i4l3NqaguiwyFhIaa9UP9oLSclD0Ptgz5FyVedlZEmfuFQUHC
	rBrQ18zm0g8MQ7P4A5UJzZckbUG/Q3OkW+tm/zrxBJy24MvoYEJg98utjFuNRvqT9C4oKALKN
	EOFEeQI9VCw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
Subject: [Qemu-devel] [PATCH v2] net/colo-compare.c: Fix a crash in COLO
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
Message-ID: <20190420171425.XlCGSsv_wLbZOloSRX4250H6V6AzXJ8vSBfVg4HhUgk@z>

From: Lukas Straub <lukasstraub2@web.de>
Because event_unhandled_count may be accessed concurrently, it needs
to be protected by taking the lock. However the assert is outside the
lock, probably causing it to read garbage and aborting Qemu erroneously.

The Bug only happens when running Qemu in COLO mode.

This Patch fixes the following bug: https://bugs.launchpad.net/qemu/+bug/1=
824622

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


