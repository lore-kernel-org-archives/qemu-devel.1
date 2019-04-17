Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DB8C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935FB2073F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935FB2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqCe-0006RM-Pe
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:26:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4R-0008O5-Al
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4P-0008OC-6W
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGq4O-0008MZ-T0
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 320E92D7F8
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:18:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F3F4A60C68;
	Wed, 17 Apr 2019 19:18:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 6FF3E1132BB6; Wed, 17 Apr 2019 21:18:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 21:17:49 +0200
Message-Id: <20190417191805.28198-2-armbru@redhat.com>
In-Reply-To: <20190417191805.28198-1-armbru@redhat.com>
References: <20190417191805.28198-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 17 Apr 2019 19:18:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 01/17] include: Include fprintf-fn.h only
 where needed
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
Cc: dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417191749.haV8g_7XPsLlXbdEfC9S1GOm-Q2cMPd3kwY9ZUwSREY@z>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/qemu-common.h | 2 --
 include/qemu/cutils.h | 2 --
 include/sysemu/cpus.h | 1 +
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index a102245519..f891e05e7e 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -12,8 +12,6 @@
 #ifndef QEMU_COMMON_H
 #define QEMU_COMMON_H
 
-#include "qemu/fprintf-fn.h"
-
 #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
 
 /* Copyright string for -version arguments, About dialogs, etc */
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index d2dad3057c..12301340a4 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -1,8 +1,6 @@
 #ifndef QEMU_CUTILS_H
 #define QEMU_CUTILS_H
 
-#include "qemu/fprintf-fn.h"
-
 /**
  * pstrcpy:
  * @buf: buffer to copy string into
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 731756d948..eea0010b53 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_CPUS_H
 #define QEMU_CPUS_H
 
+#include "qemu/fprintf-fn.h"
 #include "qemu/timer.h"
 
 /* cpus.c */
-- 
2.17.2


