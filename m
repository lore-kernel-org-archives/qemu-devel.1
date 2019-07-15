Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1DBC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C18205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C18205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn55x-0005Df-Sn
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 13:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50503)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn55f-00047t-Q0
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn55e-000745-Kt
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:48:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hn55e-00071z-D8; Mon, 15 Jul 2019 13:48:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F78436883;
 Mon, 15 Jul 2019 17:48:41 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7CA55C260;
 Mon, 15 Jul 2019 17:48:34 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>
Date: Mon, 15 Jul 2019 19:48:08 +0200
Message-Id: <20190715174817.18981-2-philmd@redhat.com>
In-Reply-To: <20190715174817.18981-1-philmd@redhat.com>
References: <20190715174817.18981-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 15 Jul 2019 17:48:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [NOTFORMERGE PATCH v2 1/9] tests/docker: Kludge to
 build the Fedora image
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Helge Deller <deller@gmx.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rebuilding the Fedora image is failing:

  $ make docker-image-fedora V=3D1
  [...]
  Step 4/8 : RUN dnf install -y $PACKAGES
   ---> Running in cef9615efafb
  Fedora Modular 30 - x86_64                      2.0 MB/s | 2.7 MB     0=
0:01
  Fedora Modular 30 - x86_64 - Updates            1.6 MB/s | 2.3 MB     0=
0:01
  Fedora 30 - x86_64 - Updates                    6.1 MB/s |  17 MB     0=
0:02
  Failed to synchronize cache for repo 'updates'
  Error: Failed to synchronize cache for repo 'updates'
  The command '/bin/sh -c dnf install -y $PACKAGES' returned a non-zero c=
ode: 1
  Traceback (most recent call last):
    File "./tests/docker/docker.py", line 615, in <module>
      sys.exit(main())
    File "./tests/docker/docker.py", line 611, in main
      return args.cmdobj.run(args, argv)
    File "./tests/docker/docker.py", line 413, in run
      extra_files_cksum=3Dcksum)
    File "./tests/docker/docker.py", line 280, in build_image
      quiet=3Dquiet)
    File "./tests/docker/docker.py", line 207, in _do_check
      return subprocess.check_call(self._command + cmd, **kwargs)
    File "/usr/lib64/python2.7/subprocess.py", line 190, in check_call
      raise CalledProcessError(retcode, cmd)
  subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu=
:fedora', '-f', '/tmp/docker_buildbKtWAa/tmpIctHw2.docker', '/tmp/docker_=
buildbKtWAa']' returned non-zero exit status 1
  make: *** [tests/docker/Makefile.include:53: docker-image-fedora] Error=
 1

The fix found in one of the comment from this thread helped to have
it working again: https://bugzilla.redhat.com/show_bug.cgi?id=3D1706627

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
I have no idea what it does, it just works (TM).
---
 tests/docker/dockerfiles/fedora.docker | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
index e6d39e14cb..f6be5e2dd7 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -94,6 +94,7 @@ ENV PACKAGES \
     zlib-devel
 ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
=20
-RUN dnf install -y $PACKAGES
+RUN echo zchunk=3DFalse >> /etc/dnf/dnf.conf
+RUN dnf clean metadata && dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
 ENV FEATURES mingw clang pyyaml asan
--=20
2.20.1


