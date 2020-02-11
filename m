Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EA0C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 06:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3119E206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 06:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2x46VvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3119E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1POQ-00045w-BM
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 01:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1PNY-0003gw-Qj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 01:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1PNW-0004V1-IU
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 01:50:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52394
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1PNW-0004Rx-78
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 01:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581403836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KuIPLCD7SPpysjcLxdGf5JfV+C6Ye/giVda+EkRd3g4=;
 b=K2x46VvYvmBZrrDWU4RZ2b1qkcm84lvZFb10ABSt6zFM1rItb6WceTnC+MK0jAmLxV6QIn
 87AHVQcn+te27Fub3cfBKrihO1VPwen1lAHcvjnCmPHaSbJt1zYzVBt3wehXj4IWnYtkO1
 +v4VHPFTAyk+3ES0YLEsu/pq5NHtgMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-1ZyaK5vKOHaEoWv6l6qZwg-1; Tue, 11 Feb 2020 01:50:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4B841005502
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 06:50:31 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-81.brq.redhat.com [10.40.205.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B5B5C548;
 Tue, 11 Feb 2020 06:50:24 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] gitlab-ci.yml: Add .gitlab-ci.d directory for GitLab specific
 files
Date: Tue, 11 Feb 2020 07:50:22 +0100
Message-Id: <20200211065022.11134-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1ZyaK5vKOHaEoWv6l6qZwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we plan to let maintainers managing their own GitLab CI jobs,
add a single directory to contain all the new files (to keep the
root directory cleaner).

EDK2 job is the first user, move it there.

Suggested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .gitignore                                   | 1 +
 .gitlab-ci-edk2.yml =3D> .gitlab-ci.d/edk2.yml | 2 +-
 .gitlab-ci.yml                               | 2 +-
 MAINTAINERS                                  | 3 +--
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename .gitlab-ci-edk2.yml =3D> .gitlab-ci.d/edk2.yml (98%)

diff --git a/.gitignore b/.gitignore
index bc0a035f9c..18288eacd1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -95,6 +95,7 @@
 *.tp
 *.vr
 *.d
+!/.gitlab-ci.d
 !/scripts/qemu-guest-agent/fsfreeze-hook.d
 *.o
 .sdk
diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci.d/edk2.yml
similarity index 98%
rename from .gitlab-ci-edk2.yml
rename to .gitlab-ci.d/edk2.yml
index 088ba4b43a..a9990b7147 100644
--- a/.gitlab-ci-edk2.yml
+++ b/.gitlab-ci.d/edk2.yml
@@ -2,7 +2,7 @@ docker-edk2:
  stage: build
  rules: # Only run this job when the Dockerfile is modified
  - changes:
-   - .gitlab-ci-edk2.yml
+   - .gitlab-ci.d/edk2.yml
    - .gitlab-ci.d/edk2/Dockerfile
    when: always
  image: docker:19.03.1
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c15e394f09..dae6045d78 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,5 +1,5 @@
 include:
-  - local: '/.gitlab-ci-edk2.yml'
+  - local: '/.gitlab-ci.d/edk2.yml'
=20
 before_script:
  - apt-get update -qq
diff --git a/MAINTAINERS b/MAINTAINERS
index c7717df720..fb00a55f41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2391,8 +2391,7 @@ F: roms/edk2
 F: roms/edk2-*
 F: tests/data/uefi-boot-images/
 F: tests/uefi-test-tools/
-F: .gitlab-ci-edk2.yml
-F: .gitlab-ci.d/edk2/
+F: .gitlab-ci.d/edk2*
=20
 Usermode Emulation
 ------------------
--=20
2.21.1


