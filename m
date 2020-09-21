Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1987AC4347E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A12216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXcA27vV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A12216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKPx7-0000Fk-D1
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKPqt-0001kJ-9v
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:43:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44600
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKPqr-0000T0-LE
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600710224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=GkpqyNJL94zTSdKSx1BNR6ICt7OR2AsoyrtuApxHpEw=;
 b=TXcA27vVJkCfBSGDY3ARCV2Vdl6/WMYzzRukqVpJ3+pZrWUiJSuIEvFhq8CTPCbQvZZ61y
 g+0OTOL+ujdKzC7qf0pALwJ0hZf2HeaqwsHyqUHQYSOZUx+wY4OYdqpH1HSEh9AIUiOEXY
 tFWgiS+hE+tunO/s6r9bzSRUacoWNmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-XnmkkoDtN8as3KtShL60sA-1; Mon, 21 Sep 2020 13:43:42 -0400
X-MC-Unique: XnmkkoDtN8as3KtShL60sA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B04E18BA282;
 Mon, 21 Sep 2020 17:43:41 +0000 (UTC)
Received: from thuth.com (ovpn-112-14.ams2.redhat.com [10.36.112.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A372B5D9CD;
 Mon, 21 Sep 2020 17:43:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/7] gitlab-ci: Remove the Debian9-based containers and
 containers-layer3
Date: Mon, 21 Sep 2020 19:43:15 +0200
Message-Id: <20200921174320.46062-3-thuth@redhat.com>
In-Reply-To: <20200921174320.46062-1-thuth@redhat.com>
References: <20200921174320.46062-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to our support policy, Debian 9 is not supported by the
QEMU project anymore. Since we now switched the MinGW cross-compiler
builds to Fedora, we do not need these Debian9-based containers
in the gitlab-CI anymore, and can now also get rid of the "layer3"
container build stage this way.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/containers.yml | 14 --------------
 .gitlab-ci.yml              |  1 -
 2 files changed, 15 deletions(-)

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 15e7b564f9..6769eef0ff 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -214,20 +214,6 @@ tricore-debian-cross-container:
   variables:
     NAME: debian-tricore-cross
 
-win32-debian-cross-container:
-  <<: *container_job_definition
-  stage: containers-layer3
-  needs: ['amd64-debian9-mxe-container']
-  variables:
-    NAME: debian-win32-cross
-
-win64-debian-cross-container:
-  <<: *container_job_definition
-  stage: containers-layer3
-  needs: ['amd64-debian9-mxe-container']
-  variables:
-    NAME: debian-win64-cross
-
 xtensa-debian-cross-container:
   <<: *container_job_definition
   variables:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a18e18b57e..c265e7f8ab 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -4,7 +4,6 @@
 stages:
   - containers
   - containers-layer2
-  - containers-layer3
   - build
   - test
 
-- 
2.18.2


