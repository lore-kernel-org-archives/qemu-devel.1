Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E9AC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 11:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD01E21883
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 11:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD01E21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44681 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5pmx-0002aQ-VH
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 07:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i5plh-0001aF-4s
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i5plf-0002kN-3P
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:17:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i5ple-0002kA-UR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:17:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DCE0110C697C;
 Thu,  5 Sep 2019 11:17:33 +0000 (UTC)
Received: from thuth.com (ovpn-116-96.ams2.redhat.com [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD59E5D712;
 Thu,  5 Sep 2019 11:17:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Greg Kurz <groug@kaod.org>,
	qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 13:17:29 +0200
Message-Id: <20190905111729.1197-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 05 Sep 2019 11:17:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] gitlab-ci.yml: Install libattr1-dev and
 libcap-dev to test virtio-9p
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So far the gitlab-ci was not testing virtio-9p yet, since we did not
install libattr1-dev and libcap-dev in any of the pipelines. Do it
now to get some more test coverage.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index cd4c03372b..ed8067f5cf 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -59,7 +59,7 @@ build-user:
 
 build-clang:
  script:
- - apt-get install -y -qq clang libsdl2-dev
+ - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-dev
       xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev librbd-dev
  - ./configure --cc=clang --cxx=clang++ --enable-werror
       --target-list="alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu
-- 
2.18.1


