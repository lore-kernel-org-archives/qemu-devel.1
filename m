Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F696C606D1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 20:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9612171F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 20:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9612171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkaaJ-0002u4-TW
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 16:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55516)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkaZc-0002MC-Ri
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 16:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkaZb-0006JB-P2
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 16:49:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hkaZb-0006Ib-Jl; Mon, 08 Jul 2019 16:49:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CE0F72E95A2;
 Mon,  8 Jul 2019 20:49:18 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56CBD57996;
 Mon,  8 Jul 2019 20:49:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 00:49:09 +0400
Message-Id: <20190708204909.10891-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 08 Jul 2019 20:49:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] misc: fix naming scheme of compatiblity arrays
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
Cc: peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since merge 31ed41889e6e13699871040fe089a2884dca46cb ("Merge
remote-tracking branch
'remotes/elmarco/tags/machine-props-pull-request' into staging"), the
compat arrays are in lowercase.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/migration.rst | 2 +-
 hw/i386/pc_piix.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 220059679a..f7668ae389 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -314,7 +314,7 @@ For example:
=20
    a) Add a new property using ``DEFINE_PROP_BOOL`` - e.g. support-foo a=
nd
       default it to true.
-   b) Add an entry to the ``HW_COMPAT_`` for the previous version that s=
ets
+   b) Add an entry to the ``hw_compat_`` for the previous version that s=
ets
       the property to false.
    c) Add a static bool  support_foo function that tests the property.
    d) Add a subsection with a .needed set to the support_foo function
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c2280c72ef..6a0e29de7c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -313,7 +313,7 @@ else {
  * pc_compat_*() functions that run on machine-init time and
  * change global QEMU state are deprecated. Please don't create
  * one, and implement any pc-*-2.4 (and newer) compat code in
- * HW_COMPAT_*, PC_COMPAT_*, or * pc_*_machine_options().
+ * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
  */
=20
 static void pc_compat_2_3_fn(MachineState *machine)
--=20
2.22.0.214.g8dca754b1e


