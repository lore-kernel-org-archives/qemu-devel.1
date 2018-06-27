Received: from eggs.gnu.org ([2001:4830:134:3::10]:38490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzyg-0006el-Db
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzyb-0001pu-Ge
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:14:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXzyb-0001nb-9H
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:14:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Jun 2018 23:14:17 -0300
Message-Id: <20180627021423.18404-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] docker: Port to Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This series makes tests/docker/docker.py compatible with both
Python 2 and Python 3, and adds type annotation to make
maintenance easier in the future.

A note about dockerfile encoding
--------------------------------

One decision I made while working on this was to open dockerfiles
in text mode instead of binary mode, to make the code simpler and
safer.

This means we won't support dockerfiles that are not valid utf-8
data, but I see that as a feature and not a bug.  :)

Opening dockerfiles in binary mode and treating its contents as
byte sequences instead of text is possible if we really want to,
but I don't think it would be worth the extra code complexity.

Eduardo Habkost (6):
  docker: Use BytesIO instead of StringIO
  docker: Always return int on run()
  docker: Add type annotations
  docker: Use os.environ.items() instead of .iteritems()
  docker: Make _get_so_libs() work on Python 3
  docker: Open dockerfiles in text mode

 tests/docker/docker.py | 115 ++++++++++++++++++++++++++++-------------
 1 file changed, 79 insertions(+), 36 deletions(-)


base-commit: bd4e4a387aa733e40270a7406c7d111f2292de65
prerequisite-patch-id: 83051ebcf718afae38540902b60a0f8e9f91c174
prerequisite-patch-id: 1a35c71f2a58523de78e3ea2e44c5ef1f84bcc4a
prerequisite-patch-id: 5206b4c5a6797ea17eb763da6203e1881d379f2c
-- 
2.18.0.rc1.1.g3f1ff2140
