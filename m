Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F1CC468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 21:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABC1208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 21:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABC1208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZMGR-0000WG-HB
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 17:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37795)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hZMDV-00070R-IS
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hZMDU-0002WO-Jv
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:16:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hZMDU-0002VN-EB
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:16:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F09C83003A4A;
 Fri,  7 Jun 2019 21:15:56 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D938600C0;
 Fri,  7 Jun 2019 21:15:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Date: Fri,  7 Jun 2019 18:15:39 -0300
Message-Id: <20190607211544.7964-4-ehabkost@redhat.com>
In-Reply-To: <20190607211544.7964-1-ehabkost@redhat.com>
References: <20190607211544.7964-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 07 Jun 2019 21:16:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/8] configure: Require python3 >= 3.5
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The oldest python3 version in distros that will be supported by
QEMU 4.1 is 3.5.3 (the one in Debian Stretch).  Error out if
running python3 < 3.5.

We have a .travis.yml job configured to use Python 3.4.  Change
it to use Python 3.5.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190508182339.22447-1-ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure   | 5 +++--
 .travis.yml | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index dcc732ff1e..9dc960824f 100755
--- a/configure
+++ b/configure
@@ -1852,8 +1852,9 @@ fi
 
 # Note that if the Python conditional here evaluates True we will exit
 # with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
-  error_exit "Cannot use '$python', Python 2 >= 2.7 or Python 3 is required." \
+if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7) or \
+                                      (3,0) <= sys.version_info < (3,5))'; then
+  error_exit "Cannot use '$python', Python 2 >= 2.7 or Python 3 >= 3.5 is required." \
       "Use --python=/path/to/python to specify a supported Python."
 fi
 
diff --git a/.travis.yml b/.travis.yml
index b053a836a3..75e017a5cf 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -212,7 +212,7 @@ matrix:
         - CONFIG="--target-list=x86_64-softmmu"
       language: python
       python:
-        - "3.4"
+        - "3.5"
 
 
     - env:
-- 
2.18.0.rc1.1.g3f1ff2140


