Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25D4C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F64E208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKbjYSa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F64E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58kM-0002Yh-Nm
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j58Ja-0002xA-H6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j58JY-0007M6-Iq
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:25:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44615
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j58JY-0007Kn-En
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582291554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SW3lAstK1rmsyHibnDejOI0DENRkAykxJehfAUoooGg=;
 b=YKbjYSa+wGU+wkCEHTO83SJdud0buBJAODWzr4WFxfuulzRzWt5fmIbKUdof8K4vFnbGBy
 Mn5AUG7O/XAM3IDUepyCmWzk3h735JbSbF3VZDOej88DXVwki+kAbpMjMD2VlzLKPjT627
 Q9mi3a1ljDozNrqurj9ebufzu02514Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-q1OkKKHMP_W7vkKtHUVkWg-1; Fri, 21 Feb 2020 08:25:52 -0500
X-MC-Unique: q1OkKKHMP_W7vkKtHUVkWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E932E1005510;
 Fri, 21 Feb 2020 13:25:50 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF1C184BCC;
 Fri, 21 Feb 2020 13:25:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, philmd@redhat.com, yangx.jy@cn.fujitsu.com,
 mrezanin@redhat.com
Subject: [PULL 6/6] docs: Fix virtiofsd.1 location
Date: Fri, 21 Feb 2020 13:25:36 +0000
Message-Id: <20200221132536.38364-7-dgilbert@redhat.com>
In-Reply-To: <20200221132536.38364-1-dgilbert@redhat.com>
References: <20200221132536.38364-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Miroslav Rezanina <mrezanin@redhat.com>

Patch 6a7e2bbee5 docs: add virtiofsd(1) man page introduced new man
page virtiofsd.1. Unfortunately, wrong file location is used as
source for install command. This cause installation of docs fail.

Fixing wrong location so installation is successful.

Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
Message-Id: <1608747495.7195569.1581513386780.JavaMail.zimbra@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b5a7377cb1..146a91bc3e 100644
--- a/Makefile
+++ b/Makefile
@@ -865,7 +865,7 @@ ifdef CONFIG_VIRTFS
 =09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1 "$(DES=
TDIR)$(mandir)/man1"
 endif
 ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
-=09$(INSTALL_DATA) docs/interop/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
+=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtiofsd.1 "$(DESTDIR)$(man=
dir)/man1"
 endif
=20
 install-datadir:
--=20
2.24.1


