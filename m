Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F3BECE599
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 22:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F2A21835
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 22:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F2A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKs15-0006xg-8l
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 18:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKs0C-0006Dk-QF
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 18:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKs0B-0008BM-Lm
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 18:42:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKs0B-0008AB-Da
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 18:42:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A757818CB8E8;
 Wed, 16 Oct 2019 22:42:42 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E295E19C70;
 Wed, 16 Oct 2019 22:42:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Require Python >= 3.5
Date: Wed, 16 Oct 2019 19:42:37 -0300
Message-Id: <20191016224237.26180-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 16 Oct 2019 22:42:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Python 3.5 is the oldest Python version available on our
supported build platforms, and Python 2 end of life will be 3
weeks after the planned release date of QEMU 4.2.0.  Drop Python
2 support from configure completely, and require Python 3.5 or
newer.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure              | 18 ++++--------------
 tests/Makefile.include |  5 -----
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/configure b/configure
index 08ca4bcb46..870657ec7b 100755
--- a/configure
+++ b/configure
@@ -895,9 +895,9 @@ fi
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
@@ -1824,8 +1824,8 @@ fi
=20
 # Note that if the Python conditional here evaluates True we will exit
 # with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
-  error_exit "Cannot use '$python', Python 2 >=3D 2.7 or Python 3 is req=
uired." \
+if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then
+  error_exit "Cannot use '$python', Python >=3D 3.5 is required." \
       "Use --python=3D/path/to/python to specify a supported Python."
 fi
=20
@@ -6456,15 +6456,6 @@ if test "$supported_os" =3D "no"; then
     echo "us upstream at qemu-devel@nongnu.org."
 fi
=20
-# Note that if the Python conditional here evaluates True we will exit
-# with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
-  echo
-  echo "warning: Python 2 support is deprecated" >&2
-  echo "warning: Python 3 will be required for building future versions =
of QEMU" >&2
-  python2=3D"y"
-fi
-
 config_host_mak=3D"config-host.mak"
=20
 echo "# Automatically generated by configure - do not modify" >config-al=
l-disas.mak
@@ -7282,7 +7273,6 @@ echo "INSTALL_DATA=3D$install -c -m 0644" >> $confi=
g_host_mak
 echo "INSTALL_PROG=3D$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=3D$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=3D$python" >> $config_host_mak
-echo "PYTHON2=3D$python2" >> $config_host_mak
 echo "CC=3D$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=3D$iasl" >> $config_host_mak
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3543451ed3..54ee1f0a2f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1137,7 +1137,6 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
 AVOCADO_SHOW=3Dapp
 AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARG=
ET_DIRS)))
=20
-ifneq ($(PYTHON2),y)
 $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
 	$(call quiet-command, \
             $(PYTHON) -m venv --system-site-packages $@, \
@@ -1146,10 +1145,6 @@ $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
             $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_VE=
NV_REQ), \
             PIP, $(TESTS_VENV_REQ))
 	$(call quiet-command, touch $@)
-else
-$(TESTS_VENV_DIR):
-	$(error "venv directory for tests requires Python 3")
-endif
=20
 $(TESTS_RESULTS_DIR):
 	$(call quiet-command, mkdir -p $@, \
--=20
2.21.0


