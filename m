Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4BCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E449208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9wwPOsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E449208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSI96-0000uy-8N
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHye-0005kg-Fr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyc-0006HP-Lk
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=fM19QF+Da0/05Z4a0DqLkyPFT2otN3NKHUFxw+WENwg=;
 b=P9wwPOsuMpe/FWDELIOEKRRAo22xzp5i9pefriHWax7/97K8IO3fwPdaYCjiARCyw5ftFM
 puIYT3AlI1Ua0Pnk6HaBj2+pYMnRksZ9XfEAq1WH3C/gWz8stsInlpR3/DTH4IUQtr7GW/
 2DRCSHzUg1befYLVAfjvxIRu+V7Bmp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-bIUlHlb6NDmnEZvvRQbsuw-1; Tue, 13 Oct 2020 06:56:15 -0400
X-MC-Unique: bIUlHlb6NDmnEZvvRQbsuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B43F38030CD;
 Tue, 13 Oct 2020 10:56:14 +0000 (UTC)
Received: from thuth.com (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2BFE7EB7A;
 Tue, 13 Oct 2020 10:56:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 18/23] scripts/ci/gitlab-pipeline-status: improve message
 regarding timeout
Date: Tue, 13 Oct 2020 12:55:22 +0200
Message-Id: <20201013105527.20088-19-thuth@redhat.com>
In-Reply-To: <20201013105527.20088-1-thuth@redhat.com>
References: <20201013105527.20088-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

The script has its own timeout, which is about how long the script
will wait (when called with --wait) for the pipeline to complete, and
not necessarily for the pipeline to complete.

Hopefully this new wording will be clearer.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200904164258.240278-3-crosa@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/ci/gitlab-pipeline-status | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
index 194dd4d0bb..2a36f74696 100755
--- a/scripts/ci/gitlab-pipeline-status
+++ b/scripts/ci/gitlab-pipeline-status
@@ -69,7 +69,10 @@ def wait_on_pipeline_success(timeout, interval,
     start = time.time()
     while True:
         if time.time() >= (start + timeout):
-            print("Waiting on the pipeline timed out")
+            msg = ("Timeout (-t/--timeout) of %i seconds reached, "
+                   "won't wait any longer for the pipeline to complete")
+            msg %= timeout
+            print(msg)
             return False
 
         status = get_pipeline_status(project_id, commit_sha)
-- 
2.18.2


