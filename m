Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDE1C0650E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487F9205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487F9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8UJ-0003NQ-CR
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34089)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hi4pH-0005Qy-LR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hi4pC-0000P3-O2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:31:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hi4or-0008K0-Pe; Mon, 01 Jul 2019 18:30:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B41430C34C2;
 Mon,  1 Jul 2019 22:29:53 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 367FB5D9C3;
 Mon,  1 Jul 2019 22:29:48 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Date: Mon,  1 Jul 2019 19:29:12 -0300
Message-Id: <20190701222912.4703-5-ehabkost@redhat.com>
In-Reply-To: <20190701222912.4703-1-ehabkost@redhat.com>
References: <20190701222912.4703-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 01 Jul 2019 22:29:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/4] Deprecate Python 2 support
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
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
index f2cb9f3c66..d565ea4bb9 100755
--- a/configure
+++ b/configure
@@ -6502,6 +6502,14 @@ if test "$supported_os" =3D "no"; then
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
index df04f2840b..241c978d2d 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -243,3 +243,11 @@ Note that if you are exposing the export via /dev/nb=
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


