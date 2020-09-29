Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF448C47423
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C082076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFkhrIwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C082076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMIg-00027Q-5b
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6E-0001sd-3Q
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM64-0003Ue-H5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4TiT38gDo8oyo8Muf7mhAiplRC9qSsQ4WSYb3ECKjE=;
 b=VFkhrIwXF2z/p8AhusyST5eyK6PI9iChOHzLwOOlwmr18cPGsZO6UJ1mPrJ9qMZIgtcbFt
 VWYY7OY2JnQ6GUM07K6150Ed55zgw84N4Ta2YBmwtGaX7gI6CG1FXEnZbqBkvHoZfZnY98
 +APskQq2Y9ckScoED53KmHBCfiSQ8Fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464--oBLmtuJO_Sl_hk6d3KMUg-1; Tue, 29 Sep 2020 16:19:32 -0400
X-MC-Unique: -oBLmtuJO_Sl_hk6d3KMUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A26041DE02;
 Tue, 29 Sep 2020 20:19:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 750ED78822;
 Tue, 29 Sep 2020 20:19:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D83C411358D2; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/29] tests/qapi-schema: Convert doc-good.json to rST-style
 strong/emphasis
Date: Tue, 29 Sep 2020 22:19:17 +0200
Message-Id: <20200929201926.2155622-21-armbru@redhat.com>
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

doc-good.json currently uses the old *strong* and _emphasis_ markup.
As part of the conversion to rST this needs to switch to **strong**
and *emphasis*, because rST uses underscores as part of its markup
of hyperlinks and will otherwise warn about the syntax error.

In commit a660eed482063b we fixed up the in-tree uses of the
old markup:
 1) _this_ was replaced with *this*
 2) the only in-tree use of *this* was left alone (turning
    a 'strong' into an 'emphasis')
(and so currently in-tree nothing is using either new-style
**strong** or old-style _emphasis_).

Update doc-good.json in a similar way:
 1) replace _this_ with *this*
 2) remove the usage of old-style *this*

(This slightly reduces the coverage for the old Texinfo generator,
which is about to go away, but is fine for the new rST generator
because that does not need to handle strong/emphasis itself because
it is simply passing the entire text as raw rST to Sphinx.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200925162316.21205-13-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/doc-good.json | 2 +-
 tests/qapi-schema/doc-good.out  | 2 +-
 tests/qapi-schema/doc-good.texi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index c6822145c4..e9af0857db 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -10,7 +10,7 @@
 #
 # == Subsection
 #
-# *strong* _with emphasis_
+# *with emphasis*
 # @var {in braces}
 #
 # * List item one
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index b7e3f4313d..419284dae2 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -73,7 +73,7 @@ doc freeform
     body=
 == Subsection
 
-*strong* _with emphasis_
+*with emphasis*
 @var {in braces}
 
 * List item one
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index 12808989ff..29abef33e9 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -4,7 +4,7 @@
 
 @subsection Subsection
 
-@strong{strong} @emph{with emphasis}
+@strong{with emphasis}
 @code{var} @{in braces@}
 
 @itemize @bullet
-- 
2.26.2


