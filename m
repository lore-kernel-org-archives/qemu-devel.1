Received: from eggs.gnu.org ([2001:4830:134:3::10]:59972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLn3-00017B-82
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLmy-0000K9-K4
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:34:53 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 14:34:16 -0300
Message-Id: <20171219173425.8113-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/9] iotests: python3 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Nir Soffer <nirsof@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

Hi,

This is a very boring series.

I a later series I refactor the iotests.py class, however when the first version
of series [1] was posted I received comments that this class should no support
Python 3.

I didn't tested with very old CentOS release, but this should work with Python
versions >= 2.6.0a2.

Note: in today's IRC chat we suggest to drop Python 2 support for block iotests,
continuing to support it for common scripts used by the build system.

I'm not a Python expert, so I'll be very happy/relieved if someone is willing to
fix/continue/improve this series :)

Regards,

Phil.

[1]: http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02339.html

Philippe Mathieu-Daudé (9):
  qemu.py: replace iteritems() by items() for python3 compatibility
  qmp.py: encode JSON unicode as byte strings for python3 compatibility
  iotests: replace print statement by print() function for python3
    compatibility
  iotests: use octal numbers for python3 compatibility
  iotests: replace xrange() by range() for python3 compatibility
  iotests: replace dict.has_key() by 'in' operator for python3
    compatibility
  iotests: replace lambda function by lambda expression for python3
    compatibility
  iotests: replace assertEquals() by assertEqual() for python3
    compatibility
  iotests.py: use io.StringIO with python3

 scripts/qemu.py               |  2 +-
 scripts/qmp/qmp.py            |  2 +-
 tests/qemu-iotests/041        |  6 +++---
 tests/qemu-iotests/044        | 14 +++++++-------
 tests/qemu-iotests/065        |  4 ++--
 tests/qemu-iotests/093        |  2 +-
 tests/qemu-iotests/096        |  4 ++--
 tests/qemu-iotests/118        | 28 ++++++++++++++--------------
 tests/qemu-iotests/136        |  2 +-
 tests/qemu-iotests/139        |  2 +-
 tests/qemu-iotests/149        |  3 ++-
 tests/qemu-iotests/163        |  2 +-
 tests/qemu-iotests/165        |  3 ++-
 tests/qemu-iotests/iotests.py | 14 +++++++++-----
 14 files changed, 47 insertions(+), 41 deletions(-)

-- 
2.15.1
