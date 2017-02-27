Received: from eggs.gnu.org ([2001:4830:134:3::10]:38059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ciMJw-000157-3s
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ciMJs-0007aS-Tw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:36 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ciMJs-0007Zb-NK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:32 -0500
Received: by mail-wm0-x233.google.com with SMTP id u199so20128200wmd.1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 06:30:32 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 27 Feb 2017 14:30:26 +0000
Message-Id: <20170227143028.16428-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/2] s390x cross Docker target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

A build failure on s390 was reported so to investigate I put together
a cross-compile environment to debug it. As it turned out the report
was a false positive but the cross target might still be useful for
people who don't have big iron handy ;-)

Alex Bennée (2):
  new: dockerfiles/debian-s390-cross
  .shippable: add s390x-cross target

 .shippable.yml                                     |  2 ++
 tests/docker/dockerfiles/debian-s390x-cross.docker | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-s390x-cross.docker

-- 
2.11.0
