Received: from eggs.gnu.org ([209.51.188.92]:58595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grnyQ-0004T3-9H
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grnyE-0003WK-Bm
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:00:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1grnyD-0003V6-Kz
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:00:17 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  7 Feb 2019 13:00:09 -0500
Message-Id: <20190207180012.27303-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/3] Add "boot_linux" acceptance test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Cleber Rosa <crosa@redhat.com>

Some hopefully useful pointers for reviewers:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Git Info:
  - URI: https://github.com/clebergnu/qemu/tree/sent/test_boot_linux_v4
  - Remote: https://github.com/clebergnu/qemu
  - Branch: sent/test_boot_linux_v4

Travis CI Info:
  - https://travis-ci.org/clebergnu/qemu/builds/490166797

Previous version:
  - v3: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01677.ht=
ml
  - v2: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04318.ht=
ml
  - v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02530.=
html

Changes from v3:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * New patch "Acceptance tests: depend on qemu-img"

Known Issues on v3 (no longer applicable):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * A recent TCG performance regression[1] affects this test in a
   number of ways:
   - The test execution may timeout by itself
   - The generation of SSH host keys in the guest's first boot is also
     affected (possibly also a timeout)
   - The cloud-init "phone home" feature attempts to read the host keys
     and fails, causing the test to timeout and fail

   These are not observed anymore once the fix[2] is applied.

[1] - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00338.html
[2] - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01129.html

Changes from v2:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Updated the tag to include the "arch:" key, in a similar fashion as to
   the tests in the "Acceptance Tests: target architecture support":
   - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00369.html

 * Renamed the test method name to test_x86_64_pc, again, similarly to th=
e
   boot_linux_console.py tests in the series mentioned before.

 * Set the machine type explicitly, again similarly to the
   boot_linux_console.py tests in the series mentioned before.

 * Added messages after the launch of the VM, to let test runners know
   the test know waits for a boot confirmation from the the guest (Eduard=
o).

 * Updated commit message to reflect the fact that this version does
   not allow for parameterization of the guest OS, version, etc.

 * Dropped the RFC prefix on patch "RFC: Acceptance tests: add the
   build directory to the system PATH"

 * Changed the comments on "RFC: Acceptance tests: add the build
   directory to the system PATH" to make it clear the addition of a
   the build directory to the PATH may influence other utility code.

Changes from v1:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * The commit message was adjusted, removing the reference to the
   avocado.utils.vmimage encoding issue on previous Avocado versions
   (<=3D 64.0) and the fix that would (and was) included in Avocado
   version 65.0.

 * Effectively added pycdlib=3D=3D1.6.0 to the requirements.txt file,
   added on a56931eef3, and adjusted the commit message was also
   to reflect that.

 * Updated the default version of the guest OS, from Fedora 28 to 29.
   Besides possible improvements in the (virtual) hardware coverage,
   it brings a performance improvement in the order of 20% to the
   test.

 * Removed all direct parameters usage.  Because some parameters and
   its default values implemented in the test would prevent it from
   running on some environments.  Example: the "accel" parameter had a
   default value of "kvm", which would prevent this test, that boots a
   x86_64 OS, from running on a host arch different than x86_64.  I
   recognize that it's desirable to make tests reusable and
   parameterized (that was the reason for the first version doing so),
   but the mechanism to be used to define the architectures that a
   given test should support is still an open issue, and has been
   discussed in other threads.  I'll follow up those discussions with
   a proposal, and until then, removing those aspects from this test
   implementation seemed to be the best option.  A caveat: this test
   currently adds the same tag (x86_64) and follows other assumptions
   made on "boot_linux_console.py", that is, that a x86_64 target
   binary will be used to run it.  If a user is in an environment that
   does not have a x86_64 target binary, it could filter those tests
   out with: "avocado run --filter-by-tags=3D'-x86_64' tests/acceptance".

 * Removed most arguments to the QEMU command line for pretty much the
   same reasons described above, and by following the general
   perception that I could grasp from other discussions that QEMU
   defaults should preferrably be used.  This test, as well as others,
   can and should be extended later to allow for different test
   scenarios by passing well documented parameter values.  That is,
   they should respect well-known parameters such as "accel" mentioned
   above, so that the same test can run with KVM or TCG.

 * Changed the value of the memory argument to 1024, which based on
   my experimentations and observations is the minimum amount of RAM
   for the Fedora 29 cloud image to sucessfully boot on QEMU.  I know
   there's no such thing as a "one size fits all", specially for QEMU,
   but this makes me wonder wether a x86_64 machine type shouldn't
   have its default_ram_size bumped to a number practical enough to
   run modern operating systems.

 * Added a new patch "RFC: Acceptance tests: add the build directory
   to the system PATH", which is supposed to gather feedback on how to
   enable the use of built binaries, such as qemu-img, to code used by
   the test code.  The specific situation here is that the vmimage,
   part of the avocado.utils libraries, makes use of qemu-img to create
   snapshot files.  Even though we could require qemu-img to be installed
   as a dependency of tests, system wide, it actually goes against the
   goal of testing all QEMU things from the source/build tree.  This
   became aparent with tests running on environments such as Travis CI,
   which don't necessarily have qemu-img available elsewhere.

Cleber Rosa (3):
  Acceptance tests: add the build directory to the system PATH
  Acceptance tests: depend on qemu-img
  Add "boot_linux" acceptance test for x86_64 and pc machine type

 tests/Makefile.include                    |  2 +-
 tests/acceptance/avocado_qemu/__init__.py |  7 ++++
 tests/acceptance/boot_linux.py            | 51 +++++++++++++++++++++++
 tests/requirements.txt                    |  1 +
 4 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 tests/acceptance/boot_linux.py

--=20
2.20.1
