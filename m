Received: from eggs.gnu.org ([2001:4830:134:3::10]:40012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQtn4-0006k7-Em
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQtn1-0001Ti-Cj
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:41:02 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 18 Dec 2017 12:40:47 +0100
Message-Id: <1513597251-21942-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] tests: Rename pc-cpu-test.c to
 cpu-plug-test.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, david@redhat.com, Daniel Barboza <danielhb@linux.vnet.ibm.com>

So far the CPU hot-plug qtest was only checking "cpu-add" on x86. With
these patches, we now test "device_add" for hot-plugging CPUs on x86,
and enable the test on ppc64 and s390x, too.

v2:
 - Rebased to current master, fixed contextual conflicts in
   tests/Makefile.include
 - Adjusted the data->device_model to the current version of QEMU
   (e.g. use "qemu-s390x-cpu" instead of "qemu-s390-cpu")

Thomas Huth (4):
  tests: Rename pc-cpu-test.c to cpu-plug-test.c
  tests/cpu-plug-test: Check the CPU hot-plugging with device_add, too
  tests/cpu-plug-test: Check CPU hot-plugging on ppc64, too
  tests/cpu-plug-test: Test CPU hot-plugging on s390x

 tests/Makefile.include |   6 +-
 tests/cpu-plug-test.c  | 267 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/pc-cpu-test.c    | 135 -------------------------
 3 files changed, 271 insertions(+), 137 deletions(-)
 create mode 100644 tests/cpu-plug-test.c
 delete mode 100644 tests/pc-cpu-test.c

--=20
1.8.3.1
