Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1DAC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E5122D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E5122D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UYz-0002kJ-GT
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPX-0006gi-Ki
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPW-0005Gy-I5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20236)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPW-0005Fb-Cd
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B500D8980E1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:37 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0E3660E1C;
 Wed, 21 Aug 2019 17:28:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:14 +0200
Message-Id: <1566408501-48680-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 21 Aug 2019 17:28:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/13] configure: remove AUTOCONF_HOST
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

This is a left-over from commit
c12b6d70e384c769ca372e15ffd19b3e9f563662 ("pixman: drop submodule")

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/configure b/configure
index b7f4283..d7d6dfc 100755
--- a/configure
+++ b/configure
@@ -7366,11 +7366,6 @@ if test "$sparse" =3D "yes" ; then
   echo "HOST_CC      :=3D REAL_CC=3D\"\$(HOST_CC)\" cgcc"  >> $config_ho=
st_mak
   echo "QEMU_CFLAGS  +=3D -Wbitwise -Wno-transparent-union -Wno-old-init=
ializer -Wno-non-pointer-null" >> $config_host_mak
 fi
-if test "$cross_prefix" !=3D ""; then
-  echo "AUTOCONF_HOST :=3D --host=3D${cross_prefix%-}"     >> $config_ho=
st_mak
-else
-  echo "AUTOCONF_HOST :=3D "                             >> $config_host=
_mak
-fi
 echo "LDFLAGS=3D$LDFLAGS" >> $config_host_mak
 echo "LDFLAGS_NOPIE=3D$LDFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_LDFLAGS=3D$QEMU_LDFLAGS" >> $config_host_mak
--=20
1.8.3.1



