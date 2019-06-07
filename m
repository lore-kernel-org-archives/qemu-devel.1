Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498FEC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 21:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1047820868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 21:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1047820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZMIn-0002qk-83
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 17:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37820)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hZMDX-00073S-Se
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hZMDW-0002ZJ-St
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:16:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hZMDW-0002Yc-Nb
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:16:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEC0C30C5844;
 Fri,  7 Jun 2019 21:15:52 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E244608AB;
 Fri,  7 Jun 2019 21:15:52 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Date: Fri,  7 Jun 2019 18:15:38 -0300
Message-Id: <20190607211544.7964-3-ehabkost@redhat.com>
In-Reply-To: <20190607211544.7964-1-ehabkost@redhat.com>
References: <20190607211544.7964-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 07 Jun 2019 21:16:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/8] Deprecate Python 2 support
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

Python 2 will reach end of life in January 1 2020.  Declare it as
deprecated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190503193721.18459-1-ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
[ehabkost: print "warning:" in lowercase]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure            | 8 ++++++++
 qemu-deprecated.texi | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/configure b/configure
index b091b82cb3..dcc732ff1e 100755
--- a/configure
+++ b/configure
@@ -6506,6 +6506,14 @@ if test "$supported_os" =3D "no"; then
     echo "us upstream at qemu-devel@nongnu.org."
 fi
=20
+# Note that if the Python conditional here evaluates True we will exit
+# with status 1 which is a shell 'false' value.
+if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
+  echo
+  echo "warning: Python 2 support is deprecated" >&2
+  echo "warning: Python 3 will be required for building future versions =
of QEMU" >&2
+fi
+
 config_host_mak=3D"config-host.mak"
=20
 echo "# Automatically generated by configure - do not modify" >config-al=
l-disas.mak
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 50292d820b..65411c130e 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -237,3 +237,11 @@ Note that if you are exposing the export via /dev/nb=
d0, it is easier
 to just export the entire image and then mount only /dev/nbd0p1 than
 it is to reinvoke @command{qemu-nbd -c /dev/nbd0} limited to just a
 subset of the image.
+
+@section Build system
+
+@subsection Python 2 support (since 4.1.0)
+
+In the future, QEMU will require Python 3 to be available at
+build time.  Support for Python 2 in scripts shipped with QEMU
+is deprecated.
--=20
2.18.0.rc1.1.g3f1ff2140


