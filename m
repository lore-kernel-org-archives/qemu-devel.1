Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2091C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854DA21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854DA21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51417 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT2Wp-0006dn-M7
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 07:01:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2PZ-0000Ku-IN
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2PY-0004xw-JX
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hT2PY-0004xA-9v
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EAF3301988B;
	Tue, 21 May 2019 10:54:18 +0000 (UTC)
Received: from thuth.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F9DF7841E;
	Tue, 21 May 2019 10:54:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:53:43 +0200
Message-Id: <20190521105344.11637-13-thuth@redhat.com>
In-Reply-To: <20190521105344.11637-1-thuth@redhat.com>
References: <20190521105344.11637-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 21 May 2019 10:54:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/13] cirrus / travis: Add gnu-sed and bash for
 macOS and FreeBSD
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, lvivier@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to enable the qemu-iotests during "make check" again,
and for running the iotests, we need bash and gnu-sed.

Reviewed-by: Li-Wen Hsu <lwhsu@freebsd.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20190502084506.8009-5-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .cirrus.yml | 4 ++--
 .travis.yml | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 47ef5bc604..8326a3a4b1 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -7,7 +7,7 @@ freebsd_12_task:
     cpu: 8
     memory: 8G
   install_script: pkg install -y
-    bison curl cyrus-sasl git glib gmake gnutls
+    bash bison curl cyrus-sasl git glib gmake gnutls gsed
     nettle perl5 pixman pkgconf png usbredir
   script:
     - mkdir build
@@ -20,7 +20,7 @@ macos_task:
   osx_instance:
     image: mojave-base
   install_script:
-    - brew install pkg-config python glib pixman make sdl2
+    - brew install pkg-config python gnu-sed glib pixman make sdl2
   script:
     - ./configure --python=3D/usr/local/bin/python3 || { cat config.log;=
 exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
diff --git a/.travis.yml b/.travis.yml
index 66448d99d6..6fd89b3d91 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -42,6 +42,7 @@ addons:
     packages:
       - glib
       - pixman
+      - gnu-sed
=20
=20
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
--=20
2.21.0


