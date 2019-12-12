Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A49FC2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CA521655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtBRO8zD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CA521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifP4l-0006lG-Vc
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ifO3S-0001lW-Mz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ifO3Q-0005U5-88
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:58:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ifO3P-0005RY-IS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576155530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRvhJd1J7DuZ9DIj5XWMPvxBgRSr8B6bbR062Zm6ESk=;
 b=ZtBRO8zD1DGz6e8oegDh83CNQE71EH/h2io/3ZfV04OMJhu8dAIvF8lGP1OoiepiWHD+cn
 ZgENBtLMV542z1gz6XH2z1rj/POR25zoOHwJlTsE2XFFKNJ/oewsbYwwGvhSUidvD08Cij
 MI3JKej7+bMpmJ773da2NYdez1RqEPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-kARTAf4PORaDRvvDetLw6w-1; Thu, 12 Dec 2019 07:58:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76593107B26F;
 Thu, 12 Dec 2019 12:58:42 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA05D1001B09;
 Thu, 12 Dec 2019 12:58:41 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/5] python/qemu: Remove unneeded imports in __init__
Date: Thu, 12 Dec 2019 07:58:31 -0500
Message-Id: <20191212125831.2654-6-wainersm@redhat.com>
In-Reply-To: <20191212125831.2654-1-wainersm@redhat.com>
References: <20191212125831.2654-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: kARTAf4PORaDRvvDetLw6w-1
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
Cc: fam@euphon.net, ehabkost@redhat.com, jsnow@redhat.com,
 alex.bennee@linaro.org, crosa@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

__init_.py import some sub-modules unnecessarily. So let's
clean it up.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Suggested-by: Cleber Rosa <crosa@redhat.com>
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
2.21.0


