Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409DCCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EFA20679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cccs+c1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EFA20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6LE-00018q-Op
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iO6II-0002Mi-Ae
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iO6IG-0000Ou-B7
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:34:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iO6IC-0000MM-VQ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572035680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7JbbghH8jZLr1Dv0CBBEEG/nngwnlrfbHJAFoetlSM=;
 b=Cccs+c1h5S8AdfMePYwe5HKYd8xe9cI5QtQrwKQtao+BW8E3+JT1bish3waYpfXs3f5sSo
 ryxgTKdTVpIHhnSIArZSoEW4gmX1efniuk5wyjEmCQF1bfhy72MlpquZFHs1PMwsNWSwaB
 V6tbPxZ5qBcW7sx6xNvS7zeqBwi9+/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-gWyNb81IMgSiUxocXbadBA-1; Fri, 25 Oct 2019 16:34:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23C03476;
 Fri, 25 Oct 2019 20:34:36 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7AC65C224;
 Fri, 25 Oct 2019 20:34:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/1] configure: Require Python >= 3.5
Date: Fri, 25 Oct 2019 17:34:27 -0300
Message-Id: <20191025203427.20181-2-ehabkost@redhat.com>
In-Reply-To: <20191025203427.20181-1-ehabkost@redhat.com>
References: <20191025203427.20181-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: gWyNb81IMgSiUxocXbadBA-1
X-Mimecast-Spam-Score: 0
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
Cc: John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Python 3.5 is the oldest Python version available on our
supported build platforms, and Python 2 end of life will be 3
weeks after the planned release date of QEMU 4.2.0.  Drop Python
2 support from configure completely, and require Python 3.5 or
newer.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20191016224237.26180-1-ehabkost@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure              | 18 ++++--------------
 tests/Makefile.include |  5 -----
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/configure b/configure
index 145fcabbb3..bfc2b1a9d8 100755
--- a/configure
+++ b/configure
@@ -896,9 +896,9 @@ fi
 : ${install=3D${INSTALL-install}}
 # We prefer python 3.x. A bare 'python' is traditionally
 # python 2.x, but some distros have it as python 3.x, so
-# we check that before python2
+# we check that too
 python=3D
-for binary in "${PYTHON-python3}" python python2
+for binary in "${PYTHON-python3}" python
 do
     if has "$binary"
     then
@@ -1829,8 +1829,8 @@ fi
=20
 # Note that if the Python conditional here evaluates True we will exit
 # with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
-  error_exit "Cannot use '$python', Python 2 >=3D 2.7 or Python 3 is requi=
red." \
+if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then
+  error_exit "Cannot use '$python', Python >=3D 3.5 is required." \
       "Use --python=3D/path/to/python to specify a supported Python."
 fi
=20
@@ -6466,15 +6466,6 @@ if test "$supported_os" =3D "no"; then
     echo "us upstream at qemu-devel@nongnu.org."
 fi
=20
-# Note that if the Python conditional here evaluates True we will exit
-# with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
-  echo
-  echo "warning: Python 2 support is deprecated" >&2
-  echo "warning: Python 3 will be required for building future versions of=
 QEMU" >&2
-  python2=3D"y"
-fi
-
 config_host_mak=3D"config-host.mak"
=20
 echo "# Automatically generated by configure - do not modify" >config-all-=
disas.mak
@@ -7295,7 +7286,6 @@ echo "INSTALL_DATA=3D$install -c -m 0644" >> $config_=
host_mak
 echo "INSTALL_PROG=3D$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=3D$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=3D$python" >> $config_host_mak
-echo "PYTHON2=3D$python2" >> $config_host_mak
 echo "CC=3D$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=3D$iasl" >> $config_host_mak
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 09e5b410dc..c4e656001e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1139,7 +1139,6 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
 AVOCADO_SHOW=3Dapp
 AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARGET=
_DIRS)))
=20
-ifneq ($(PYTHON2),y)
 $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
 =09$(call quiet-command, \
             $(PYTHON) -m venv --system-site-packages $@, \
@@ -1148,10 +1147,6 @@ $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
             $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_VENV=
_REQ), \
             PIP, $(TESTS_VENV_REQ))
 =09$(call quiet-command, touch $@)
-else
-$(TESTS_VENV_DIR):
-=09$(error "venv directory for tests requires Python 3")
-endif
=20
 $(TESTS_RESULTS_DIR):
 =09$(call quiet-command, mkdir -p $@, \
--=20
2.21.0


