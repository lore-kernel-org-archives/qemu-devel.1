Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE023C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595BD208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfKmOwX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595BD208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJCMT-0001Z8-6o
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 05:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJCLb-0000uq-G0
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJCLY-0002Ow-W6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600419982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VrJ9MH7sCjHHK4bdsm1eUbET4NsCywypUj4ioRHWGv8=;
 b=RfKmOwX+kswJcxBEZBcHMWFTfq7KVqN3MYGZf/g+3Rm15DXOEwHhcorvGhB50CoPAln3NP
 ZPh61qtxHu3aKKzFWlA25eCFax8BYaM/jY4FYx8HI1iubmgTG0w8PtM1fqpfD9YB+ffwMR
 7V+f1G4Dr4VCQJkAH1ctCI5CqRgD9Bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-JSBB41iFOTef1ihqapUsiQ-1; Fri, 18 Sep 2020 05:06:07 -0400
X-MC-Unique: JSBB41iFOTef1ihqapUsiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22A0E1891E85;
 Fri, 18 Sep 2020 09:06:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-161.ams2.redhat.com
 [10.36.113.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7196E73675;
 Fri, 18 Sep 2020 09:06:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] docs: simplify and clarify the platform support rules
Date: Fri, 18 Sep 2020 10:06:03 +0100
Message-Id: <20200918090603.1640224-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The distinction between short life and long life Linux distributions
turned out to be redundant. They can both be covered in a simple way
by noting support will target the current release, and the previous
release for a period of two years or until its EOL. This rule can also
apply to the other UNIX based distros, leaving only Windows needing a
different set of rules.

This also clarifies that Debian LTS is out of scope, because the LTS
support is provided by a separate group from the main Debian maintainer
team.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/build-platforms.rst | 59 +++++++++++----------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/docs/system/build-platforms.rst b/docs/system/build-platforms.rst
index 9734eba2f1..1cdff44abf 100644
--- a/docs/system/build-platforms.rst
+++ b/docs/system/build-platforms.rst
@@ -29,51 +29,30 @@ The Repology site https://repology.org is a useful resource to identify
 currently shipped versions of software in various operating systems,
 though it does not cover all distros listed below.
 
-Linux OS
---------
+Linux OS, macOS, FreeBSD, NetBSD, OpenBSD
+-----------------------------------------
 
-For distributions with frequent, short-lifetime releases, the project
-will aim to support all versions that are not end of life by their
-respective vendors. For the purposes of identifying supported software
-versions, the project will look at Fedora, Ubuntu, and openSUSE distros.
-Other short- lifetime distros will be assumed to ship similar software
-versions.
+The project aims to support the most recent major version at all times. Support
+for the previous major version will be dropped 2 years after the new major
+version is released or when the vendor itself drops support, whichever comes
+first. In this context, third-party efforts to extend the lifetime of a distro
+are not considered, even when they are endorsed by the vendor (eg. Debian LTS).
 
-For distributions with long-lifetime releases, the project will aim to
-support the most recent major version at all times. Support for the
-previous major version will be dropped 2 years after the new major
-version is released, or when it reaches "end of life". For the purposes
-of identifying supported software versions, the project will look at
-RHEL, Debian, Ubuntu LTS, and SLES distros. Other long-lifetime distros
-will be assumed to ship similar software versions.
+For the purposes of identifying supported software versions available on Linux,
+the project will look at CentOS, Debian, Fedora, openSUSE, RHEL, SLES and
+Ubuntu LTS. Other distros will be assumed to ship similar software versions.
 
-Windows
--------
-
-The project supports building with current versions of the MinGW
-toolchain, hosted on Linux.
+For FreeBSD and OpenBSD, decisions will be made based on the contents of the
+respective ports repository, while NetBSD will use the pkgsrc repository.
 
-macOS
------
+For macOS, `HomeBrew`_ will be used, although `MacPorts`_ is expected to carry
+similar versions.
 
-The project supports building with the two most recent versions of
-macOS, with the current Homebrew package set available.
-
-FreeBSD
+Windows
 -------
 
-The project aims to support all versions which are not end of
-life.
-
-NetBSD
-------
-
-The project aims to support the most recent major version at all times.
-Support for the previous major version will be dropped 2 years after the
-new major version is released.
-
-OpenBSD
--------
+The project supports building with current versions of the MinGW toolchain,
+hosted on Linux (Debian/Fedora).
 
-The project aims to support all versions which are not end of
-life.
+The version of the Windows API that's currently targeted is Vista / Server
+2008.
-- 
2.26.2


