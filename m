Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFD4C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E564120897
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS0r2bhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E564120897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkb3-00034B-14
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDkXG-0003FU-0v
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDkXE-0008TO-5i
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599121434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YHjhf6PzUIaoSP4VLLRG7BIp8RgevkaPLq7xAy1AuSc=;
 b=IS0r2bhElZ5csOg1uNuALT2+yKuLxgBRX6gJiLvrLJUsTCPcZPQJTDA2v35gqLHbSwDr0O
 udBCrNOHqDJnSgUUhayh1tk3CO3xrLZPprUCoapaLHqTnJ1E4l1FPLd0Urt8A39F1ra9Vi
 KepIifWj1LMIRKATcP5/W9PFkBXA6YI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-iYBANOkTPXiqd1N4jTqiVw-1; Thu, 03 Sep 2020 04:23:51 -0400
X-MC-Unique: iYBANOkTPXiqd1N4jTqiVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2FDD8030DD;
 Thu,  3 Sep 2020 08:23:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3F8E87B2D;
 Thu,  3 Sep 2020 08:23:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C692710C83DE; Thu,  3 Sep 2020 10:23:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] docs/interop/qmp-spec: Point to the QEMU QMP reference
 manual
Date: Thu,  3 Sep 2020 10:23:42 +0200
Message-Id: <20200903082344.1877175-7-armbru@redhat.com>
In-Reply-To: <20200903082344.1877175-1-armbru@redhat.com>
References: <20200903082344.1877175-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 4d8bb958fa0..231aaf3a821 integrated the contents of
docs/qmp-events.txt into QAPI schema doc comments.  It left dangling
references to qmp-events.txt behind.  Fix to point to the QEMU QMP
reference manual generated from the QAPI schema.

Add a similar reference for commands.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200806081147.3123652-2-armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/interop/qmp-spec.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
index adcf86754d..cdf5842555 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.txt
@@ -110,6 +110,9 @@ or
   if provided.  The "id" member can be any json-value.  A json-number
   incremented for each successive command works fine.
 
+The actual commands are documented in the QEMU QMP reference manual
+docs/interop/qemu-qmp-ref.{7,html,info,pdf,txt}.
+
 2.3.1 Out-of-band execution
 ---------------------------
 
@@ -207,13 +210,13 @@ The format of asynchronous events is:
   there is a failure to retrieve host time, both members of the
   timestamp will be set to -1.
 
-For a listing of supported asynchronous events, please, refer to the
-qmp-events.txt file.
+The actual asynchronous events are documented in the QEMU QMP
+reference manual docs/interop/qemu-qmp-ref.{7,html,info,pdf,txt}.
 
 Some events are rate-limited to at most one per second.  If additional
 "similar" events arrive within one second, all but the last one are
 dropped, and the last one is delayed.  "Similar" normally means same
-event type.  See qmp-events.txt for details.
+event type.
 
 2.6 Forcing the JSON parser into known-good state
 -------------------------------------------------
-- 
2.26.2


