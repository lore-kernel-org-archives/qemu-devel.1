Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55F4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258832085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIUqKtqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258832085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7VY-0003kM-5J
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7TL-0001xv-Fr
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7TJ-0003a7-LD
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603737836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9TKpgmGkiiAAbw2JALujkOukYurv4UBkg8ahf24A44=;
 b=aIUqKtqC4D0Oq1+mOSLjUfoQ9ckAd0rmRU4QjYJoJctuEy2IIQuOp4o74+SEzDp7Be7bLy
 TotAXj5t+fE+hDLZa2zec+IKaCvX2leFK6ElR8k+9JlROM3gu/EU/F/VSgyJLy0bTaYfCa
 Uuj2GeF3Xiv/PNHsVIwqrBNGqh+K3Vc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-HR80G1wKNaiM4Xk_L7O55Q-1; Mon, 26 Oct 2020 14:43:54 -0400
X-MC-Unique: HR80G1wKNaiM4Xk_L7O55Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7832680363B;
 Mon, 26 Oct 2020 18:43:53 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-208.ams2.redhat.com
 [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D9995D9CA;
 Mon, 26 Oct 2020 18:43:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com,
 misono.tomohiro@jp.fujitsu.com
Subject: [PULL 07/16] tools/virtiofsd: xattr name mapping examples
Date: Mon, 26 Oct 2020 18:43:22 +0000
Message-Id: <20201026184331.272953-8-dgilbert@redhat.com>
In-Reply-To: <20201026184331.272953-1-dgilbert@redhat.com>
References: <20201026184331.272953-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: virtio-fs@redhat.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a few examples of xattrmaps to the documentation.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201023165812.36028-5-dgilbert@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/tools/virtiofsd.rst | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 67c16f9df0..d80c078d80 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -219,6 +219,56 @@ e.g.:
 
   would hide 'security.' xattr's in listxattr from the server.
 
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
+the 'user.virtiofs.' path directly.
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


