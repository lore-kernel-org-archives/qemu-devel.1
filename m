Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C801C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE48E21D40
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYmYta8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE48E21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZZei-0000wK-TU
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZZak-0004PO-Hj
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:09:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZZai-0003NH-OV
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604322584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkzOcfULddzdjgTJYmiy3AM503DDuZdPb/VoF702x14=;
 b=AYmYta8jbSzB8PqsIv2vo21szh+sCxGY3WnODmeds+XjykHhsBUCY8DCzEciHQST0c0M4/
 5ATQat1Pwd7sxJ3mFGSJFUP2E93m+mrmkx+yrGcN6YR0DefP2JfANIRl4O8nauitnP7wbj
 Q0ZUOFehqd1n3AQlbmRvK0+hk01Mhk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-XYcGYT7-PeK3up1ItBigwA-1; Mon, 02 Nov 2020 08:09:42 -0500
X-MC-Unique: XYcGYT7-PeK3up1ItBigwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47F9B1009E25;
 Mon,  2 Nov 2020 13:09:41 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71D141002C21;
 Mon,  2 Nov 2020 13:09:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] docs: show stdout/stderr when meson fails build test
Date: Mon,  2 Nov 2020 13:09:25 +0000
Message-Id: <20201102130926.161183-4-berrange@redhat.com>
In-Reply-To: <20201102130926.161183-1-berrange@redhat.com>
References: <20201102130926.161183-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is hard to diagnose why Sphinx fails in a CI environment, as we
discard the stdout/err and just print a generic error message.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/meson.build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/meson.build b/docs/meson.build
index 8c222f96bb..278098dd4f 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -20,14 +20,15 @@ if sphinx_build.found()
   # version requirement). This will fail if sphinx-build is too old.
   run_command('mkdir', ['-p', tmpdir / 'sphinx'])
   run_command('touch', [tmpdir / 'sphinx/index.rst'])
-  sphinx_build_test_out = run_command(SPHINX_ARGS + [
+  sphinx_cmd = run_command(SPHINX_ARGS + [
     '-c', meson.current_source_dir(),
     '-b', 'html', tmpdir / 'sphinx',
     tmpdir / 'sphinx/out'])
-  build_docs = (sphinx_build_test_out.returncode() == 0)
+  build_docs = (sphinx_cmd.returncode() == 0)
 
   if not build_docs
-    warning('@0@ exists but it is either too old or uses too old a Python version'.format(get_option('sphinx_build')))
+    warning('@0@ exists but it is either too old or uses too old a Python version\nstdout:@1@\nstderr:@2@'.format(
+      get_option('sphinx_build'), sphinx_cmd.stdout().strip(), sphinx_cmd.stderr().strip()))
     if get_option('docs').enabled()
       error('Install a Python 3 version of python-sphinx')
     endif
-- 
2.28.0


