Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388C2C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0DEE2075E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUNEzGsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DEE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtKG-0005Cx-9C
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtH7-0008DL-LK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtFB-0003BJ-4t
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598439928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/LPOWdVtfu0NeWrtB6c9HQIy2uWkD+ZKoUqKz8BE1g=;
 b=bUNEzGsPH8Uc6zV9h3Iq3KYfhocxK5vKVWl3MXGL2kppKkaE64iv9qFjqHGyK6yau4NwCN
 J98ngOQkfhxuCphK/Fmmjcmq8W/K5BHFkfHe+cpl+lHmjRKWG8mFhplfV4v7JQPuZVSOdA
 9M6ee9it+qh29Eu1vmGj6NMCFJuBhuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-KyFZXRfPNU2R0N9c68yUCQ-1; Wed, 26 Aug 2020 07:05:26 -0400
X-MC-Unique: KyFZXRfPNU2R0N9c68yUCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4435B56BE3;
 Wed, 26 Aug 2020 11:05:25 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB2945C1A3;
 Wed, 26 Aug 2020 11:05:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/8] meson: use meson mandir instead of qemu_mandir
Date: Wed, 26 Aug 2020 15:04:18 +0400
Message-Id: <20200826110419.528931-8-marcandre.lureau@redhat.com>
In-Reply-To: <20200826110419.528931-1-marcandre.lureau@redhat.com>
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: sw@weilnetz.de, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When cross-compiling, by default qemu_mandir is 'c:\Program
Files\QEMU', which is not recognized as being an absolute path, and
meson will end up adding the prefix again.

Use the pre-prefixed meson mandir option instead.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 7570aab830..d3196ea2d2 100644
--- a/meson.build
+++ b/meson.build
@@ -1211,7 +1211,7 @@ if build_docs
                           output: man,
                           capture: true,
                           install: true,
-                          install_dir: config_host['mandir'] / 'man7',
+                          install_dir: get_option('mandir') / 'man7',
                           command: [pod2man, '--utf8', '--section=7', '--center=" "',
                                     '--release=" "', '@INPUT@'])
     endforeach
-- 
2.26.2


