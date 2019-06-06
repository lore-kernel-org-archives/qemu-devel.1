Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0978BC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C4D206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C4D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYzwD-0007tT-2a
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 17:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51796)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hYzu5-0005vo-GN
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hYziZ-00087Z-Hs
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hYziZ-00086S-9D
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D456308213B;
 Thu,  6 Jun 2019 21:14:21 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01F2010ABD9F;
 Thu,  6 Jun 2019 21:14:15 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 17:14:07 -0400
Message-Id: <20190606211414.8681-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 06 Jun 2019 21:14:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 0/7] Add "boot_linux" acceptance test
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds an acceptance test that validates that a full blown Linux
guest can successfully boot in QEMU.

Changes from v5:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Added explicit "--enable-slirp=3Dgit" to Travis CI configure line, as
   these tests depend on "-netdev user" like networking.

 * Bumped Fedora to most recently released version (30).

 * Changed "checksum" parameter to 'sha256' and use the same hashes as
   provided by the Fedora project (instead of using Avocado's default
   sha1 and compute and use a different hash value).

 * New commit: Add "boot_linux" test for aarch64 and virt machine type

 * New commit: [RFC]: use Avocado data drainer for console logging

Changes from v4:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * New commit "Acceptance tests: use relative location for tests"

 * New commit "Acceptance tests: keep a stable reference to the QEMU buil=
d dir"

 * Pinned the Fedora 29 image by adding a checksum.  The goal is to
   never allow more than one component to change at a time (the one
   allowed to change is QEMU itself).  Updates to the image should be
   manual. (Based on comments from Cornelia)

 * Moved the downloading of the Fedora 29 cloud image to the test
   setUp() method, canceling the test if the image can not be
   downloaded.

 * Removed the ":avocado: enable" tag, given that Avocado versions
   68.0 and later operate on a "recursive by default" manner, that
   is able to correctly identify this as an Avocado test.

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

Some hopefully useful pointers for reviewers:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Git Info:
  - URI: https://github.com/clebergnu/qemu/tree/test_boot_linux_v6
  - Remote: https://github.com/clebergnu/qemu
  - Branch: test_boot_linux_v6

Travis CI Info:
  - Build: https://travis-ci.org/clebergnu/qemu/builds/542474730
  - Job: https://travis-ci.org/clebergnu/qemu/jobs/542474755

Previous version:
  - v5: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04652.ht=
ml
  - v4: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02032.ht=
ml
  - v3: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01677.ht=
ml
  - v2: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04318.ht=
ml
  - v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02530.=
html

Cleber Rosa (7):
  Acceptance tests: use relative location for tests
  Acceptance tests: keep a stable reference to the QEMU build dir
  Acceptance tests: add the build directory to the system PATH
  Acceptance tests: depend on qemu-img
  Add "boot_linux" test for x86_64 and pc and q35 machine types
  Add "boot_linux" test for aarch64 and virt machine type
  [RFC]: use Avocado data drainer for console logging

 .travis.yml                               |   2 +-
 tests/Makefile.include                    |   4 +-
 tests/acceptance/avocado_qemu/__init__.py |   8 +-
 tests/acceptance/boot_linux.py            | 111 ++++++++++++++++++++++
 tests/requirements.txt                    |   4 +-
 5 files changed, 124 insertions(+), 5 deletions(-)
 create mode 100644 tests/acceptance/boot_linux.py

--=20
2.21.0


