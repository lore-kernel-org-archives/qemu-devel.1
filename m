Received: from eggs.gnu.org ([209.51.188.92]:45576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RPg-0003Iq-FN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RL3-00040V-9L
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:15:58 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:3899 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3RL2-0003xC-UV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:15:57 -0400
Date: Mon, 11 Mar 2019 20:15:47 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311201532.GA6@59ca1d9b7985>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v5 0/10] qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, eblake@redhat.com

Hi,

This series reworks qemu-binfmt-conf.sh:

* Argument <CPU> from option '--systemd' is generalized to <TARGETS>, and it is
  accepted for any mode (default, debian or systemd). It can be a single target
  arch or a list of them.
* Option '--clear' is added, which allows to remove an already registered
  target interpreter or a list of them. The implementation is functional but
  partial. Please, see the corresponding commit.
* Option '--test' is added, which allows to execute the CHECK according
  to the provided arguments, but no interpreter is configured.
* Support to set options through environment variables: QEMU_TARGETS,
  QEMU_PATH, QEMU_SUFFIX, QEMU_PERSISTENT, QEMU_CREDENTIAL, QEMU_CLEAR and
  QEMU_TEST.

The following changes are not backward compatible:

* Option '--persistent' no longer requires/accepts an argument.
* Option '--credential' no longer requires/accepts an argument.
* Option '--systemd' no longer requires/accepts an argument.
* Option '--qemu-path' is renamed to '--path'.
* Option '--qemu-suffix' is renamed to '--suffix'.

The functionality of all of them is untouched. Changes are related to syntax only.

The main differences compared to v4 are:

* Remove all the ':' in the first column of usage().
* Define BINFMT_CLEAR in the options case switch.
* Move comment about HOST_ARCH to the original location.
* Fix short option for 'clear'. Was 'c', which conflicted with 'credential'. It is now 'r'.
* Patches v4 4/10 and v4 9/10 are merged into v5 4/10.
* Patch v4 10/10 is now v5 9/10.

Based on:

* [PATCH v4 0/10] qemu-binfmt-conf.sh
* [PATCH v3 0/10] qemu-binfmt-conf.sh
* [PATCH v2] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c boolean (no arg)
* [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c boolean (no arg)

Regards

Unai Martinez-Corral (9):
      qemu-binfmt-conf.sh: enforce safe style consistency
      qemu-binfmt-conf.sh: make opts -p and -c boolean
      qemu-binfmt-conf.sh: add QEMU_CREDENTIAL and QEMU_PERSISTENT
      qemu-binfmt-conf.sh: use the same presentation format as for qemu-*
      qemu-binfmt-conf.sh: remove 'qemu' prefix from cli options
      qemu-binfmt-conf.sh: honour QEMU_PATH and/or QEMU_SUFFIX
      qemu-binfmt-conf.sh: generalize <CPU> to positional [TARGETS]
      qemu-binfmt-conf.sh: add option --clear
      qemu-binfmt-conf.sh: add --test

scripts/qemu-binfmt-conf.sh | 213
1 file changed, 78 insertions(+), 135 deletions(-)
