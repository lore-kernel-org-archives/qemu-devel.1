Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34690C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4512080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4512080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haj4u-0005Dt-58
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 11:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57380)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1haidv-0004g3-Du
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1haidr-0006NE-QH
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:24:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1haidr-0006Mb-HP
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:24:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C280B3092669
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 15:24:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B02ED1001B0A;
 Tue, 11 Jun 2019 15:24:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E18861136424; Tue, 11 Jun 2019 17:24:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 17:24:48 +0200
Message-Id: <20190611152448.29436-13-armbru@redhat.com>
In-Reply-To: <20190611152448.29436-1-armbru@redhat.com>
References: <20190611152448.29436-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 11 Jun 2019 15:24:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/12] MAINTAINERS: Polish headline decorations
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190606172408.18399-4-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 550d6c5959..588c8d947a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -65,7 +65,7 @@ F: *
 F: */
=20
 Responsible Disclosure, Reporting Security Issues
-------------------------------
+-------------------------------------------------
 W: https://wiki.qemu.org/SecurityProcess
 M: Michael S. Tsirkin <mst@redhat.com>
 L: secalert@redhat.com
@@ -107,8 +107,8 @@ K: ^Subject:.*(?i)s390x?
 T: git https://github.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
-Guest CPU cores (TCG):
-----------------------
+Guest CPU cores (TCG)
+---------------------
 Overall TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 R: Paolo Bonzini <pbonzini@redhat.com>
@@ -344,9 +344,8 @@ M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
 S: Maintained
 F: tests/tcg/multiarch/
=20
-Guest CPU Cores (KVM):
-----------------------
-
+Guest CPU Cores (KVM)
+---------------------
 Overall KVM CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
 L: kvm@vger.kernel.org
@@ -402,9 +401,8 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
=20
-Guest CPU Cores (Xen):
-----------------------
-
+Guest CPU Cores (Xen)
+---------------------
 X86 Xen CPUs
 M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony Perard <anthony.perard@citrix.com>
@@ -425,9 +423,8 @@ F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
 F: include/sysemu/xen-mapcache.h
=20
-Hosts:
-------
-
+Hosts
+-----
 LINUX
 M: Michael S. Tsirkin <mst@redhat.com>
 M: Cornelia Huck <cohuck@redhat.com>
@@ -464,6 +461,7 @@ X: qga/*win32*
 F: qemu.nsi
=20
 Alpha Machines
+--------------
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: hw/alpha/
@@ -1198,7 +1196,7 @@ F: hw/s390x/s390-pci*
 L: qemu-s390x@nongnu.org
=20
 UniCore32 Machines
--------------
+------------------
 PKUnity-3 SoC initramfs-with-busybox
 M: Guan Xuetao <gxt@mprc.pku.edu.cn>
 S: Maintained
--=20
2.21.0


