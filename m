Received: from eggs.gnu.org ([2001:4830:134:3::10]:45075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFkA-0002Mo-PY
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFk7-0008Ui-GM
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:38 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:38080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFk7-0008UU-A5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:35 -0400
Received: by mail-ua0-x243.google.com with SMTP id o11-v6so12550172uak.5
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:29:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Jul 2018 23:29:20 -0300
Message-Id: <20180717022924.25428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] docker: Improve 'host-cross' image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <huth@tuxfamily.org>

Sorry I don't have a better name for this image,
it is meant to cross-build for the same architecture
than the host.

Due to the bad name, explicitely tagged the last 2
patches as 'RFC'.

Tested on x86_64 and aarch64, should also work on
s390x and ppc64le (per the Docker doc).

If they are volunteers for test, the command is as simple as:

  $ make docker-test-quick@debian-host-cross [V=1]

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  docker: Use the host architecture
  docker: Improve how the virgl library is built
  docker: Rename 'amd64' image as 'host-cross'
  docker: Add many libraries to the 'host-cross' image

 .shippable.yml                                |  4 +-
 tests/docker/Makefile.include                 |  2 +-
 tests/docker/dockerfiles/debian-amd64.docker  | 39 ---------
 .../dockerfiles/debian-host-cross.docker      | 83 +++++++++++++++++++
 4 files changed, 86 insertions(+), 42 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-amd64.docker
 create mode 100644 tests/docker/dockerfiles/debian-host-cross.docker

-- 
2.18.0
