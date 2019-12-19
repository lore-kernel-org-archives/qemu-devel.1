Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93348C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2B3206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWmOrhne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2B3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvDo-0004rj-93
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurt-0000RT-7j
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurr-0002KR-Ey
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51852
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurq-0002FU-Kw
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ib+TBuTaCY7leyC0IVdfkkv8AGpLyv11gaAtA9leCd8=;
 b=UWmOrhne5hqLey7UTkcliEJfdXLLQ8MLj0DCvNPs/D21/hi9JNv0C2H/3PAJfo/wdZ93CQ
 RKCB48Jx938otUXyBwZ+1/o626y/mFj+27aVyHZLcJKNtivU5pRDVKKLyHXY45p99BnTbD
 /d4zNawYB+7RSljOygEQXXtbm6FSoMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-xk-_F9cmOn-ccIbo_mpErw-1; Thu, 19 Dec 2019 07:25:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0B9BDB60
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:17 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC65B60C18;
 Thu, 19 Dec 2019 12:25:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 120/132] meson: install some scripts
Date: Thu, 19 Dec 2019 13:23:40 +0100
Message-Id: <1576758232-12439-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: xk-_F9cmOn-ccIbo_mpErw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile            | 3 ---
 meson.build         | 1 +
 scripts/meson.build | 3 +++
 3 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 scripts/meson.build

diff --git a/Makefile b/Makefile
index 710659b..d64e481 100644
--- a/Makefile
+++ b/Makefile
@@ -275,9 +275,6 @@ ifneq ($(vhost-user-json-y),)
 =09=09$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)/vhost-user/"; \
 =09done
 endif
-ifdef CONFIG_TRACE_SYSTEMTAP
-=09$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
-endif
 ifneq ($(BLOBS),)
 =09set -e; for x in $(BLOBS); do \
 =09=09$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)";=
 \
diff --git a/meson.build b/meson.build
index ce67e4c..32b9430 100644
--- a/meson.build
+++ b/meson.build
@@ -943,6 +943,7 @@ if have_tools
   endif
 endif
=20
+subdir('scripts')
 subdir('pc-bios')
 subdir('docs')
=20
diff --git a/scripts/meson.build b/scripts/meson.build
new file mode 100644
index 0000000..e8cc638
--- /dev/null
+++ b/scripts/meson.build
@@ -0,0 +1,3 @@
+if 'CONFIG_TRACE_SYSTEMTAP' in config_host
+  install_data('qemu-trace-stap', install_dir: get_option('bindir'))
+endif
--=20
1.8.3.1



