Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1904CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70EB2084D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J57VkUiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70EB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3OUy-000434-41
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3OTq-0003Qr-0e
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:49:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34285
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3OTn-0001ig-Hv
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596653373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=dNdMo7AeNS+sDK5o7kW5ZLmSFzg9R3rbVIubsszgzGc=;
 b=J57VkUivkX5Z2zEyPzGy/Uxc+QsN3WAL2fCUczLaK+1RJ8vtul4vsowiXIhED468MixxuP
 ZmurPiQGWdOvrnmAipHcnq2n4WaOdtG+DxhPdJ20lONxl4KfvFY3tn+xM7jAh1zMQXQw5s
 W6Bd8WV/gNzPkcTp6q5TKHjmw75KfsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-SL2lI6qiO_aP6iN-fLdypg-1; Wed, 05 Aug 2020 14:49:32 -0400
X-MC-Unique: SL2lI6qiO_aP6iN-fLdypg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 281C918C63DE;
 Wed,  5 Aug 2020 18:49:31 +0000 (UTC)
Received: from thuth.com (ovpn-112-142.ams2.redhat.com [10.36.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4870419D71;
 Wed,  5 Aug 2020 18:49:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/2] travis.yml: Drop the Python 3.5 and 3.6 builds
Date: Wed,  5 Aug 2020 20:49:26 +0200
Message-Id: <20200805184926.15071-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Python 3.5 is already the default in Ubuntu Xenial (which we use for
most jobs on Travis), and Python 3.6 is the default on Ubuntu Bionic
(which we use for the s390x jobs on Travis for example already), so
explicitely defining tests for Python 3.5 and 3.6 seems redundant.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 18290bc51d..b4c603f0ec 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -258,23 +258,6 @@ jobs:
         - TEST_CMD=""
 
 
-    # Python builds
-    - name: "GCC Python 3.5 (x86_64-softmmu)"
-      env:
-        - CONFIG="--target-list=x86_64-softmmu"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-      language: python
-      python: 3.5
-
-
-    - name: "GCC Python 3.6 (x86_64-softmmu)"
-      env:
-        - CONFIG="--target-list=x86_64-softmmu"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-      language: python
-      python: 3.6
-
-
     # Using newer GCC with sanitizers
     - name: "GCC9 with sanitizers (softmmu)"
       addons:
-- 
2.18.1


