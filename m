Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BC5ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91382082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91382082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL543-00021X-0E
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <casantos@redhat.com>) id 1iL522-00088P-58
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <casantos@redhat.com>) id 1iL51z-00070M-OU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:37:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17309)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <casantos@redhat.com>) id 1iL51z-0006zo-J1
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:37:27 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDABE83F45
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 12:37:25 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id s28so1988811qkm.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 05:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=k4bv22+6vrvmE7LRTGqHXn7bDo6l5gcFE05UN7e9g8Y=;
 b=cB3GgIsP6UCR3H4bQ0FQmDrv2KYzFNzKSmWtSnRXJ3xRQKTGtk5K3bWr1nYv6Q70OJ
 6mKa1kyMx/fCu46ftAELeaOrJ5iAeYIcJ4ZCUzIQRdB/EOJQn7F1H0ghVtUNomlvRNlc
 pPRko05gbOkJpNCXskMc7kO+SObe4vfkfpG9EwqTVGfI3SwyivV/RT3SscJB4CS0cf3f
 OWpjLlLcc92aOFIDjnmECQrkShS1ksBxP+7lnMZ/n2mh32dtvrGvrpVHwVSCUaYByM25
 7SgTWie1JHg+0+tyukIrot80nXHD20Bmqeb8Iiahodwp1sJpryiV+OLQNybNFCIO/D80
 Tiiw==
X-Gm-Message-State: APjAAAWIbzBYPA+bgD+4phEAa2a6OLzcCAZmu98vLhcLhbCExwNPhUum
 6babNJ5GXE54bY9K6Sf5qgrYlrjUnIRC5bpucQx94IPzaFh7z4fWLOh/H4DINJ6eq/kmxADQC+2
 56W54oaUytE1VaFc=
X-Received: by 2002:aed:3c67:: with SMTP id u36mr3513798qte.142.1571315844976; 
 Thu, 17 Oct 2019 05:37:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzRB4JleuNeb5TiK5uWS7hNhdSBS9cabcD1YUM1fTN1XoCG33nKqOhsnPYti0t2pRJZ75rABw==
X-Received: by 2002:aed:3c67:: with SMTP id u36mr3513778qte.142.1571315844725; 
 Thu, 17 Oct 2019 05:37:24 -0700 (PDT)
Received: from casantos.remote.csb ([177.18.44.193])
 by smtp.gmail.com with ESMTPSA id g31sm1242159qte.78.2019.10.17.05.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 05:37:24 -0700 (PDT)
From: casantos@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH] util/cacheinfo: fix crash when compiling with uClibc
Date: Thu, 17 Oct 2019 09:37:13 -0300
Message-Id: <20191017123713.30192-1-casantos@redhat.com>
X-Mailer: git-send-email 2.18.1
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
Cc: Carlos Santos <casantos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Carlos Santos <casantos@redhat.com>

uClibc defines _SC_LEVEL1_ICACHE_LINESIZE and _SC_LEVEL1_DCACHE_LINESIZE
but the corresponding sysconf calls returns -1, which is a valid result,
meaning that the limit is indeterminate.

Handle this situation using the fallback values instead of crashing due
to an assertion failure.

Signed-off-by: Carlos Santos <casantos@redhat.com>
---
 util/cacheinfo.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index ea6f3e99bf..d94dc6adc8 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -93,10 +93,16 @@ static void sys_cache_info(int *isize, int *dsize)
 static void sys_cache_info(int *isize, int *dsize)
 {
 # ifdef _SC_LEVEL1_ICACHE_LINESIZE
-    *isize = sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
+    int tmp_isize = (int) sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
+    if (tmp_isize > 0) {
+        *isize = tmp_isize;
+    }
 # endif
 # ifdef _SC_LEVEL1_DCACHE_LINESIZE
-    *dsize = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
+    int tmp_dsize = (int) sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
+    if (tmp_dsize > 0) {
+        *dsize = tmp_dsize;
+    }
 # endif
 }
 #endif /* sys_cache_info */
-- 
2.18.1


