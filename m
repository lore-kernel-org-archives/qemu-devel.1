Received: from eggs.gnu.org ([2001:4830:134:3::10]:56854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbEl7-0007bp-Is
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbEl4-0006Pm-07
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:29 -0400
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:35571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbEl3-0006PK-Rj
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:25 -0400
Received: by mail-ua0-x22f.google.com with SMTP id d29so163692690uai.2
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:33:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 20:33:12 -0300
Message-Id: <20170728233316.13352-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] docker: improve code coverage on CentOS
 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Olaf Hering <olaf@aepfle.de>

This series installs more packages to docker images to extend CI code
coverage.

Debian already have those but these images are only used on Shippable.
Extending CentOS images could improve patchew, and local user not custom to
Debian.

The first idea was to add Suse images but only OpenSUSE 13.2 is available on
DockerHub and the problem reported on [1] is using SUSE SLE11.

Regards,

Phil.

[1] http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg08993.html

Philippe Mathieu-Daudé (4):
  docker: use one package per line in CentOS config
  docker: add Xen libs to centos6 image
  docker: install more packages on CentOS to extend code coverage
  docker: add centos7 image

 tests/docker/dockerfiles/centos6.docker | 31 ++++++++++++++++++++++++++-----
 tests/docker/dockerfiles/centos7.docker | 31 +++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 5 deletions(-)
 create mode 100644 tests/docker/dockerfiles/centos7.docker

-- 
2.13.3
