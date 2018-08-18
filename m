Received: from eggs.gnu.org ([2001:4830:134:3::10]:48124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqR9-0008OM-OR
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqR6-0008Sr-Ko
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:53:55 -0400
Received: from mail-vk0-x22d.google.com ([2607:f8b0:400c:c05::22d]:34729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqR6-0008Sd-GI
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:53:52 -0400
Received: by mail-vk0-x22d.google.com with SMTP id l143-v6so4071496vke.1
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 18:53:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 17 Aug 2018 22:53:40 -0300
Message-Id: <20180818015344.797-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] docker: Sort packages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Trivial cleanup patches.

Per the Docker recommendation, "this helps to avoid duplication of
packages and make the list much easier to update. This also makes PRs
a lot easier to read and review."

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  docker: Sort Fedora packages
  docker: Sort Fedora packages (i386-cross)
  docker: Sort Ubuntu packages
  docker: Sort CentOS packages

 tests/docker/dockerfiles/centos7.docker       |   2 +-
 .../dockerfiles/fedora-i386-cross.docker      |   9 +-
 tests/docker/dockerfiles/fedora.docker        | 102 ++++++++++++++----
 tests/docker/dockerfiles/ubuntu.docker        |  61 +++++++++--
 4 files changed, 141 insertions(+), 33 deletions(-)

-- 
2.18.0
