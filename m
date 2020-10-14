Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1626C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F55021D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzlAfdXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F55021D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSlA8-0002uA-UV
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSl6n-0007LZ-55
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSl6k-0008HD-R2
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602698557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8enSobz6KFfIEiRA4KGb/6ffO3C7NW/uljYZU8UUeA=;
 b=bzlAfdXQoFOaB2h7wAjVQMNYeiwDFnDb3uO2cqwQFVSw35YPGwOqz0T4wu8QrB1Xawdjda
 M3iyJKoVtn+xDepsQiVCYGbBh8XoRQIqO9eyySqXLJpjvAA+K1LPIfEEgq42mvw7/y0vuG
 nWAQnCHS7zSLmGmT7njmRn2SHrxhh4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-EOL9rcOsOOSfv_G93R-wNg-1; Wed, 14 Oct 2020 14:02:31 -0400
X-MC-Unique: EOL9rcOsOOSfv_G93R-wNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 362CF18BE161
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 18:02:30 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-95.ams2.redhat.com
 [10.36.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF8E46EF68;
 Wed, 14 Oct 2020 18:02:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 dinechin@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v3 4/5] tools/virtiofsd: xattr name mapping examples
Date: Wed, 14 Oct 2020 19:02:08 +0100
Message-Id: <20201014180209.49299-5-dgilbert@redhat.com>
In-Reply-To: <20201014180209.49299-1-dgilbert@redhat.com>
References: <20201014180209.49299-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a few examples of xattrmaps to the documentation.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/tools/virtiofsd.rst | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index a3a120da2f..5cb64612ed 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -163,6 +163,56 @@ in which case a 'server' rule will always match on all names from
 the server.
 
 
+xattr-mapping Examples
+----------------------
+
+1) Prefix all attributes with 'user.virtiofs.'
+
+::
+
+-o xattrmap=":prefix:all::user.virtiofs.::bad:all:::"
+
+
+This uses two rules, using : as the field separator;
+the first rule prefixes and strips 'user.virtiofs.',
+the second rule hides any non-prefixed attributes that
+the host set.
+
+2) Prefix 'trusted.' attributes, allow others through
+
+::
+
+   "/prefix/all/trusted./user.virtiofs./
+    /bad/server//trusted./
+    /bad/client/user.virtiofs.//
+    /ok/all///"
+
+
+Here there are four rules, using / as the field
+separator, and also demonstrating that new lines can
+be included between rules.
+The first rule is the prefixing of 'trusted.' and
+stripping of 'user.virtiofs.'.
+The second rule hides unprefixed 'trusted.' attributes
+on the host.
+The third rule stops a guest from explicitly setting
+the 'user.viritofs.' path directly.
+Finally, the fourth rule lets all remaining attributes
+through.
+
+3) Hide 'security.' attributes, and allow everything else
+
+::
+
+    "/bad/all/security./security./
+     /ok/all///'
+
+The first rule combines what could be separate client and server
+rules into a single 'all' rule, matching 'security.' in either
+client arguments or lists returned from the host.  This stops
+the client seeing any 'security.' attributes on the server and
+stops it setting any.
+
 Examples
 --------
 
-- 
2.28.0


