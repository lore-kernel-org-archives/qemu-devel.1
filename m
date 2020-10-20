Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B37C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCE62225F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDFSXaUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCE62225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUxXh-0006pv-LY
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 15:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUxQh-00067v-UC
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUxQe-0000ye-6i
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603222574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKUvLoe1F+LpREDo9JJoOt/3t4Y/T5crpLJPTHUXyAk=;
 b=YDFSXaUprt5y4Qvw7TAxTvXi//8JnUocBr7liw4hioJPoNe9TlAcYz5ASLbAm61OcX8k3L
 YAsNXF0QGJGFz8EC4mApbNejiCZHTrhPfzfS6s0mKI8yk/ctj62nbsh4USapgf5VSCI8CL
 KOeTuDB52HSTnjfO8zr6r3wEkJvKO1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-M6H5cBYPNoy8ezWaUuYugg-1; Tue, 20 Oct 2020 15:36:11 -0400
X-MC-Unique: M6H5cBYPNoy8ezWaUuYugg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 932B71074649;
 Tue, 20 Oct 2020 19:36:10 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6E0F5C1C2;
 Tue, 20 Oct 2020 19:36:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/15] python: add directory structure README.rst files
Date: Tue, 20 Oct 2020 15:35:44 -0400
Message-Id: <20201020193555.1493936-5-jsnow@redhat.com>
In-Reply-To: <20201020193555.1493936-1-jsnow@redhat.com>
References: <20201020193555.1493936-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add short readmes to python/, python/qemu/, python/qemu/machine, and
python/qemu/machine that explain the directory hierarchy. These readmes
are visible when browsing the source on e.g. gitlab/github and are
designed to help new developers/users quickly make sense of the source
tree.

They are not designed for inclusion in a published manual.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/README.rst              | 27 +++++++++++++++++++++++++++
 python/qemu/README.rst         |  8 ++++++++
 python/qemu/machine/README.rst |  9 +++++++++
 python/qemu/qmp/README.rst     |  9 +++++++++
 4 files changed, 53 insertions(+)
 create mode 100644 python/README.rst
 create mode 100644 python/qemu/README.rst
 create mode 100644 python/qemu/machine/README.rst
 create mode 100644 python/qemu/qmp/README.rst

diff --git a/python/README.rst b/python/README.rst
new file mode 100644
index 0000000000..ff40e4c931
--- /dev/null
+++ b/python/README.rst
@@ -0,0 +1,27 @@
+QEMU Python Tooling
+===================
+
+This directory houses Python tooling used by the QEMU project to build,
+configure, and test QEMU. It is organized by namespace (``qemu``), and
+then by package (``qemu/machine``, ``qemu/qmp``).
+
+``setup.py`` is used by ``pip`` to install this tooling to the current
+environment. You will generally invoke it by doing one of the following:
+
+1. ``pip3 install .`` will install these packages to your current
+   environment. If you are inside a virtual environment, they will
+   install there. If you are not, it will attempt to install to the
+   global environment, which is not recommended.
+
+2. ``pip3 install --user .`` will install these packages to your user's
+   local python packages. If you are inside of a virtual environment,
+   this will fail.
+
+If you amend the ``-e`` argument, pip will install in "editable" mode;
+which installs a version of the package that uses symlinks to these
+files, such that the package always reflects the latest version in your
+git tree.
+
+See `Installing packages using pip and virtual environments
+<https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/>`_
+for more information.
diff --git a/python/qemu/README.rst b/python/qemu/README.rst
new file mode 100644
index 0000000000..31209c80a5
--- /dev/null
+++ b/python/qemu/README.rst
@@ -0,0 +1,8 @@
+QEMU Python Namespace
+=====================
+
+This directory serves as the root of a `Python PEP 420 implicit
+namespace package <<https://www.python.org/dev/peps/pep-0420/>`_.
+
+Each directory below is assumed to be an installable Python package that
+is available under the ``qemu.<package>`` namespace.
diff --git a/python/qemu/machine/README.rst b/python/qemu/machine/README.rst
new file mode 100644
index 0000000000..73ad23c501
--- /dev/null
+++ b/python/qemu/machine/README.rst
@@ -0,0 +1,9 @@
+qemu.machine Package
+====================
+
+This package provides core utilities used for testing and debugging
+QEMU. It is used by the iotests, vm tests, and several other utilities
+in the ./scripts directory. It is not a fully-fledged SDK and it is
+subject to change at any time.
+
+See the documentation in ``__init__.py`` for more information.
diff --git a/python/qemu/qmp/README.rst b/python/qemu/qmp/README.rst
new file mode 100644
index 0000000000..f35dffe582
--- /dev/null
+++ b/python/qemu/qmp/README.rst
@@ -0,0 +1,9 @@
+qemu.qmp Package
+================
+
+This package provides a library used for connecting to and communicating
+with QMP servers. It is used extensively by iotests, vm tests, and other
+utilities in the ./scripts directory. It is not a fully-fledged SDK and
+is subject to change at any time.
+
+See the documentation in ``__init__.py`` for more information.
-- 
2.26.2


