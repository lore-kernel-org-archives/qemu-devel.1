Received: from eggs.gnu.org ([2001:4830:134:3::10]:45022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8k7-0002EK-EE
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8k4-0007wC-97
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:30:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gL8k2-0007vE-Mh
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:30:38 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  9 Nov 2018 10:30:00 -0500
Message-Id: <20181109153002.597-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 0/2] Address OS X Travis failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, programmingkidx@gmail.com, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Cleber Rosa <crosa@redhat.com>

The OS X jobs on Travis fail for a number of reasons.  This is an
attempt to decide its faith, either as something that will be kept on
the configuration (and properly maintained), removed, or maybe active
but with failures waived (Travis allows for that).

The result of this can be seen in these jobs part of a recent build:

 - https://travis-ci.org/clebergnu/qemu/jobs/452517040
 - https://travis-ci.org/clebergnu/qemu/jobs/452517041
 - https://travis-ci.org/clebergnu/qemu/jobs/452517042
 - https://travis-ci.org/clebergnu/qemu/jobs/452517043
 - https://travis-ci.org/clebergnu/qemu/jobs/452517044
 - https://travis-ci.org/clebergnu/qemu/jobs/452517045
 - https://travis-ci.org/clebergnu/qemu/jobs/452517046

Cleber Rosa (2):
  tests/test-qht-par: test gets stuck intermittently on OSX
  Travis CI: break down OSX+clang jobs

 .travis.yml            | 29 ++++++++++++++++++++++++++++-
 tests/Makefile.include |  3 +++
 2 files changed, 31 insertions(+), 1 deletion(-)

--=20
2.19.1
