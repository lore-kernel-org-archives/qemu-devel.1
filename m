Received: from eggs.gnu.org ([2001:4830:134:3::10]:37558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cigtz-0002TV-QQ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cigtw-0004R9-NN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:29:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cigtw-0004Qn-HP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:29:08 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 28 Feb 2017 12:28:59 +0000
Message-Id: <20170228122901.24520-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Fix stale 'trace-events-all' file in build
 dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

If systemtap support was disabled, the trace-events-all file was
only getting regenerated at time of 'make instal'. This is bad
because it leaves stale files in the build dir for developers.

Daniel P. Berrange (2):
  makefile: merge GENERATED_HEADERS & GENERATED_SOURCES variables
  makefile: generate trace-events-all upfront

 Makefile                   | 39 +++++++++++++++++++--------------------
 Makefile.target            |  6 +++---
 target/s390x/Makefile.objs |  2 +-
 tests/Makefile.include     |  2 +-
 4 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.9.3
