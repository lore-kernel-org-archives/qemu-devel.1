Received: from eggs.gnu.org ([2001:4830:134:3::10]:44024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZymj-0005Gy-PA
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZyme-0007BP-D9
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:13 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZyme-0007B3-8C
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:08 -0500
Received: by mail-qk0-x244.google.com with SMTP id b76so8508380qkc.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 04:50:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 Jan 2018 09:49:53 -0300
Message-Id: <20180112125000.27256-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/7] docker: update Ubuntu and Fedora images,
 deprecate old ones
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi,

This series is to be clearer about which upstream version we are using.

All "FROM distrib:latest" entries have now been removed and replaced by
explicit "FROM distrib:version" ones.

To keep backward compatibility, a warning is displayed to the user,
suggesting which correct base image to use.

To be consistent, we remove the deprecated images of the "make docker" output.

Regards,

Phil.

Philippe Mathieu-Daudé (7):
  docker: sort images list displayed by 'make docker'
  docker: do not display deprecated images in 'make docker' help
  docker: add the Ubuntu Trusty base image
  docker: do not use Trusty APT source in Xenial
  docker: warn users to use ubuntu16.04 for the LTS Xenial image
  docker: add the Fedora 27 base image
  docker: warn users to use newer fedora25/fedora27 base image

 tests/docker/Makefile.include               |  5 ++++-
 tests/docker/dockerfiles/fedora.docker      | 29 ++++++++++++-----------------
 tests/docker/dockerfiles/fedora25.docker    | 18 ++++++++++++++++++
 tests/docker/dockerfiles/fedora27.docker    | 18 ++++++++++++++++++
 tests/docker/dockerfiles/ubuntu.docker      | 28 ++++++++++------------------
 tests/docker/dockerfiles/ubuntu14.04.docker | 17 +++++++++++++++++
 tests/docker/dockerfiles/ubuntu16.04.docker | 16 ++++++++++++++++
 7 files changed, 95 insertions(+), 36 deletions(-)
 create mode 100644 tests/docker/dockerfiles/fedora25.docker
 create mode 100644 tests/docker/dockerfiles/fedora27.docker
 create mode 100644 tests/docker/dockerfiles/ubuntu14.04.docker
 create mode 100644 tests/docker/dockerfiles/ubuntu16.04.docker

-- 
2.15.1
