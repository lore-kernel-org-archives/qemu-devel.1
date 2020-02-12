Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A943C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BBD2073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzRWClPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BBD2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rtg-0001vo-1K
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrezanin@redhat.com>) id 1j1rsW-00006A-Nm
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1j1rsV-0000AK-8r
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:16:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44297
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mrezanin@redhat.com>) id 1j1rsV-00009f-2J
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581513390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=eUOUjurayrpPHx79FoNOSIJ/hmCUjZs8UB6F+2NQ5FE=;
 b=QzRWClPkG15LUl/kbpZkSRPzg4aRNYgPxDgk/XRhjpZZE6tUDRhb1TyXUQoAU6uxn8k5CN
 6D/9ooQnBdqE2nbD7kO8QT3OaUI+SospGvicqhJijOuoHNOJGodFuQpMiOYaThcmHpXp4l
 DJ0RSaJp4yT203nC36YdX1JWjWC/Z68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-AUhVmQAeNk-rfafBSaYkSg-1; Wed, 12 Feb 2020 08:16:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 111461851FDA;
 Wed, 12 Feb 2020 13:16:27 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08D1860BF1;
 Wed, 12 Feb 2020 13:16:27 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id EEB1218095FF;
 Wed, 12 Feb 2020 13:16:26 +0000 (UTC)
Date: Wed, 12 Feb 2020 08:16:26 -0500 (EST)
From: Miroslav Rezanina <mrezanin@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1608747495.7195569.1581513386780.JavaMail.zimbra@redhat.com>
In-Reply-To: <1908428819.7192207.1581512184275.JavaMail.zimbra@redhat.com>
Subject: [PATCH] docs: Fix virtiofsd.1 location
MIME-Version: 1.0
X-Originating-IP: [10.40.204.108, 10.4.195.17]
Thread-Topic: docs: Fix virtiofsd.1 location
Thread-Index: qzJivM1tz9HXMqT7v9j6aH0ajiE8dA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: AUhVmQAeNk-rfafBSaYkSg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch 6a7e2bbee5 docs: add virtiofsd(1) man page introduced new man
page virtiofsd.1. Unfortunately, wrong file location is used as
source for install command. This cause installation of docs fail.

Fixing wrong location so installation is successful.

Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f0e1a2f..62a367d 100644
--- a/Makefile
+++ b/Makefile
@@ -865,7 +865,7 @@ ifdef CONFIG_VIRTFS
        $(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
 endif
 ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
-       $(INSTALL_DATA) docs/interop/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
+       $(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
 endif

 install-datadir:
-- 
1.8.3.1



