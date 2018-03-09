Received: from eggs.gnu.org ([2001:4830:134:3::10]:50093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOd0-0008BK-9b
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOcx-0006lD-6B
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1euOcx-0006kk-0B
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:31 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  9 Mar 2018 17:28:19 -0300
Message-Id: <20180309202827.12085-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/8] tests: Run device-crash-test on "make
 check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>

So, we're back to that time when we need to add new known crashes
to device-crash-test, because we haven't been running it in a
while and new bugs were introduced.

To help prevent this from happening again, this series adds new
rules to validate devices against the default machine-type on
"make check".  This should help us catch more obvious bugs, at
least.

Peter, is it possible to get this tested inside your system that
validates every pull request, just to see if it won't generate
any unexpected warning, error, or false positive?

Eduardo Habkost (8):
  device-crash-test: Refactor loglevel configuration code
  device-crash-test: Add examples to script documentation
  device-crash-test: Accept machine=DEFAULT to test the default machine
  device-crash-test: New known crashes
  device-crash-test: Remove runnable-machine check
  device-crash-test: Use WARN for known crashes
  device-crash-test: Don't print warnings in quiet mode
  tests: Run device-crash-test on "make check"

 scripts/device-crash-test | 135 ++++++++++++++++++++++++++--------------------
 tests/Makefile.include    |  13 ++++-
 2 files changed, 88 insertions(+), 60 deletions(-)

-- 
2.14.3
