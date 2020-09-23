Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8077CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84AA20719
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmPU6F5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84AA20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7gS-0002HW-Uv
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kL7dx-0000Ot-Ub
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kL7du-0001HX-Rn
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600878557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=4Mos79MOqtlAK9URVdZQ3+08lCFCNJYaiMebh053uf8=;
 b=GmPU6F5MhyQ7c2dv3PsT20oEvpOQGCItfStgX7Xu5P/bP7+25zs2R1mRDOS9NC5Pawp9Go
 McNeDwY04EC30VII4lAc1qQx4zeBIrOjnbt8jHQ+tJ8KsccVuCLugSDko8Ga96DacSMwM+
 HlAJk16KBOYuiw0omKi5/LM6ePeCv80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-JHPJGCTcNG-h_06PDxllXA-1; Wed, 23 Sep 2020 12:29:13 -0400
X-MC-Unique: JHPJGCTcNG-h_06PDxllXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6425F186DD37;
 Wed, 23 Sep 2020 16:29:12 +0000 (UTC)
Received: from thuth.com (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B52B65C1C7;
 Wed, 23 Sep 2020 16:29:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 7/7] configure: Bump the minimum required Python version to
 3.6
Date: Wed, 23 Sep 2020 18:29:08 +0200
Message-Id: <20200923162908.95372-1-thuth@redhat.com>
In-Reply-To: <CAFEAcA-P5gngMXmBUtOGNn=ZUN8C2dmC=5Phxs7C5fYV=Odhjw@mail.gmail.com>
References: <CAFEAcA-P5gngMXmBUtOGNn=ZUN8C2dmC=5Phxs7C5fYV=Odhjw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All our supported build platforms have Python 3.6 or newer nowadays, and
there are some useful features in Python 3.6 which are not available in
3.5 yet (e.g. the type hint annotations which will allow us to statically
type the QAPI parser), so let's bump the minimum Python version to 3.6 now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2:
 - Bump the version in docs/conf.py, too
 - Remove the now unnecessary check in tests/qemu-iotests/iotests.py

 configure                     | 4 ++--
 docs/conf.py                  | 4 ++--
 tests/qemu-iotests/iotests.py | 2 --
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 7564479008..a3a643168e 100755
--- a/configure
+++ b/configure
@@ -1965,8 +1965,8 @@ fi
 
 # Note that if the Python conditional here evaluates True we will exit
 # with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then
-  error_exit "Cannot use '$python', Python >= 3.5 is required." \
+if ! $python -c 'import sys; sys.exit(sys.version_info < (3,6))'; then
+  error_exit "Cannot use '$python', Python >= 3.6 is required." \
       "Use --python=/path/to/python to specify a supported Python."
 fi
 
diff --git a/docs/conf.py b/docs/conf.py
index 0dbd90dc11..8aeac40124 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -36,9 +36,9 @@ from sphinx.errors import ConfigError
 # In newer versions of Sphinx this will display nicely; in older versions
 # Sphinx will also produce a Python backtrace but at least the information
 # gets printed...
-if sys.version_info < (3,5):
+if sys.version_info < (3,6):
     raise ConfigError(
-        "QEMU requires a Sphinx that uses Python 3.5 or better\n")
+        "QEMU requires a Sphinx that uses Python 3.6 or better\n")
 
 # The per-manual conf.py will set qemu_docdir for a single-manual build;
 # otherwise set it here if this is an entire-manual-set build.
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 91e4a57126..f48460480a 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -40,8 +40,6 @@ sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 from qemu import qtest
 from qemu.qmp import QMPMessage
 
-assert sys.version_info >= (3, 6)
-
 # Use this logger for logging messages directly from the iotests module
 logger = logging.getLogger('qemu.iotests')
 logger.addHandler(logging.NullHandler())
-- 
2.18.2


