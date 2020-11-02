Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3558FC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9409C206B7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNC+RDu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9409C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZV3o-000110-FG
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 03:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZV0T-0006RI-3x
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:16:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZV0R-0005ir-GQ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604304958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8O1PrFo7vJ6w2Qp6s/wLGP5W+QzGcrDXB3cihlX0Hxc=;
 b=WNC+RDu3LGPQok0hHPbfP1tX7eS96TR7+m6z8f7cNo1cRv6sfL10eMjOvPaRdBvXRTNOjU
 1bH9EcJ15S2LSLiAabDrT0E3dmL/JKNZL5H+p8fp3qRkAIncwq9m4I93UreuTX4ZLmELrV
 jbaN9DpTiX8xq0wC981mCRsNsopbrYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-lBUYt4kGP22YzkGxi9AFMQ-1; Mon, 02 Nov 2020 03:15:57 -0500
X-MC-Unique: lBUYt4kGP22YzkGxi9AFMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 089A69CC02
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 08:15:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FFC45D9DD;
 Mon,  2 Nov 2020 08:15:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E594E1132921; Mon,  2 Nov 2020 09:15:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qapi: Fix missing headers in QMP Reference Manual
Date: Mon,  2 Nov 2020 09:15:50 +0100
Message-Id: <20201102081550.171061-3-armbru@redhat.com>
In-Reply-To: <20201102081550.171061-1-armbru@redhat.com>
References: <20201102081550.171061-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Audio stuff is under "Miscellanea", and authorization stuff is under
"Input".  Add suitable header doc comments to correct that.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/audio.json | 4 ++++
 qapi/authz.json | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 3b843878d2..072ed79def 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -5,6 +5,10 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
 
+##
+# = Audio
+##
+
 ##
 # @AudiodevPerDirectionOptions:
 #
diff --git a/qapi/authz.json b/qapi/authz.json
index f3e9745426..42afe752d1 100644
--- a/qapi/authz.json
+++ b/qapi/authz.json
@@ -1,7 +1,9 @@
 # -*- Mode: Python -*-
 # vim: filetype=python
-#
-# QAPI authz definitions
+
+##
+# = User authorization
+##
 
 ##
 # @QAuthZListPolicy:
-- 
2.26.2


