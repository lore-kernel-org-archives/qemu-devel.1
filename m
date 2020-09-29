Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8AAC47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9762076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlaomrJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9762076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNM83-0003aX-MQ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM66-0001lQ-5r
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM62-0003Su-EF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:37 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUESf4c7tu9j2EpuNq5laxTXxEk8TmEK8eJ9ksZ2j9Q=;
 b=OlaomrJglw1P09LEL7aDDLJTRsh2IqyqJyZZCU6H1LF7qxi/T3FR87bMZ+IStHK/eJ3LuB
 36X/nfNK/oVPw9pLeOdqerI1oGYrMT6z0Wk071SJlB1jX4mSoqhQlh9jdOCHFwSK7D7Cou
 Nx1bb1xBfLt/RPv7YBr8r5N5lVF/OS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-tQz5bF8FNcO7Kpioj_c6bw-1; Tue, 29 Sep 2020 16:19:30 -0400
X-MC-Unique: tQz5bF8FNcO7Kpioj_c6bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E370318BE164;
 Tue, 29 Sep 2020 20:19:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B70A578807;
 Tue, 29 Sep 2020 20:19:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B282F11358C0; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/29] qapi/block.json: Add newline after "Example:" for
 block-latency-histogram-set
Date: Tue, 29 Sep 2020 22:19:07 +0200
Message-Id: <20200929201926.2155622-11-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The block-latency-histogram-set command is the only one which uses
the Example/Examples section with the first line of the documentation
immediately following the ':'. Bring it into line with the rest.

This will allow us to avoid special-casing the indentation handling
for "Examples" sections; instead for Examples as for any other section
header these two indentations will be equivalent:

Examples:
Line one
Line two

Examples: Line one
          Line two

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200925162316.21205-3-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block.json | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index c54a393cf3..a009f7d3a2 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -528,7 +528,8 @@
 #
 # Since: 4.0
 #
-# Example: set new histograms for all io types with intervals
+# Example:
+# set new histograms for all io types with intervals
 # [0, 10), [10, 50), [50, 100), [100, +inf):
 #
 # -> { "execute": "block-latency-histogram-set",
@@ -536,7 +537,8 @@
 #                     "boundaries": [10, 50, 100] } }
 # <- { "return": {} }
 #
-# Example: set new histogram only for write, other histograms will remain
+# Example:
+# set new histogram only for write, other histograms will remain
 # not changed (or not created):
 #
 # -> { "execute": "block-latency-histogram-set",
@@ -544,7 +546,8 @@
 #                     "boundaries-write": [10, 50, 100] } }
 # <- { "return": {} }
 #
-# Example: set new histograms with the following intervals:
+# Example:
+# set new histograms with the following intervals:
 #   read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
 #   write: [0, 1000), [1000, 5000), [5000, +inf)
 #
@@ -554,7 +557,8 @@
 #                     "boundaries-write": [1000, 5000] } }
 # <- { "return": {} }
 #
-# Example: remove all latency histograms:
+# Example:
+# remove all latency histograms:
 #
 # -> { "execute": "block-latency-histogram-set",
 #      "arguments": { "id": "drive0" } }
-- 
2.26.2


