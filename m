Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B72EC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E194207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFNrO+CP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E194207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igvv3-0003pB-C3
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1igvpe-0006Ut-K5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1igvpd-00087A-Hs
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:15:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52421
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1igvpd-00086F-Ea
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576523700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opxgMBEqE0axlltMOU81qh5BAxTCcpRMIpFZ8BVm1aQ=;
 b=GFNrO+CPMhx/EhmeKsROGVxuCi2yW9vSGPX1yFHnqalMEaP6KtSYzTNhRSKWWuqIg4K+tN
 tzPHtjT13fo/J8cEU9R2NBZcRmoH6rAzdIn+I6PmKVvsgmoPpEnuzgcP7I+fevh3YqyGP4
 Cg0AskwpQqZGXXgzcwZ9dwfWFQrmiQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-kCGTr6PMOWuXOyKUOE3pSw-1; Mon, 16 Dec 2019 14:14:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21FC5800D41;
 Mon, 16 Dec 2019 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-67.gru2.redhat.com
 [10.97.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C6675C1B5;
 Mon, 16 Dec 2019 19:14:56 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/5] python/qemu: Remove unneeded imports in __init__
Date: Mon, 16 Dec 2019 16:14:38 -0300
Message-Id: <20191216191438.93418-6-wainersm@redhat.com>
In-Reply-To: <20191216191438.93418-1-wainersm@redhat.com>
References: <20191216191438.93418-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kCGTr6PMOWuXOyKUOE3pSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, ehabkost@redhat.com, philmd@redhat.com, jsnow@redhat.com,
 crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

__init_.py import some sub-modules unnecessarily. So let's
clean it up.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Suggested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
 python/qemu/__init__.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index eff17a306e..4ca06c34a4 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -9,9 +9,3 @@
 # This work is licensed under the terms of the GNU GPL, version 2.  See
 # the COPYING file in the top-level directory.
 #
-# Based on qmp.py.
-#
-
-from . import qmp
-from . import machine
-from . import accel
--=20
2.23.0


