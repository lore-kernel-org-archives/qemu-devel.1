Received: from eggs.gnu.org ([2001:4830:134:3::10]:58482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1cy1TN-0001ex-JM
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 15:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1cy1TK-0004Ci-Fc
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 15:29:05 -0400
Received: from mail-qk0-x22d.google.com ([2607:f8b0:400d:c09::22d]:34873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1cy1TK-0004CE-A0
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 15:29:02 -0400
Received: by mail-qk0-x22d.google.com with SMTP id f133so6344478qke.2
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 12:29:00 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <149193892875.15312.10880186639757781549@loki>
Date: Tue, 11 Apr 2017 14:28:48 -0500
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.9.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fifth release candidate for the QEMU 2.9 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.9.0-rc4.tar.xz
  http://download.qemu-project.org/qemu-2.9.0-rc4.tar.xz.sig

A note from the maintainer:

  This is intended to be the final release candidate for v2.9.0, and
  unless any showstopper bugs are reported we plan to cut the final
  release next week on the 18th April.

You can help improve the quality of the QEMU 2.9 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.9

The dates have all been pushed back a week due to delays with the
initial RC.

Please add entries to the ChangeLog for the 2.9 release below:

  http://wiki.qemu.org/ChangeLog/2.9

Changes since rc3:

372b3fe: Update version for v2.9.0-rc4 release (Peter Maydell)
e3e0003: block/io: Comment out permission assertions (Max Reitz)
5eceb01: sheepdog: Fix crash in co_read_response() (Kevin Wolf)
2ec9a78: iscsi: Fix iscsi_create (Fam Zheng)
1606e4c: throttle: Remove block from group on hot-unplug (Eric Blake)
7a9e511: block: pass the right options for BlockDriver.bdrv_open() (Dong Ji=
a Shi)
76296df: sheepdog: Use bdrv_coroutine_enter before BDRV_POLL_WHILE (Fam Zhe=
ng)
49ca625: block: Fix bdrv_co_flush early return (Fam Zheng)
e92f0e1: block: Use bdrv_coroutine_enter to start I/O coroutines (Fam Zheng)
324ec3e: qemu-io-cmds: Use bdrv_coroutine_enter (Fam Zheng)
aef4278: blockjob: Use bdrv_coroutine_enter to start coroutine (Fam Zheng)
052a757: block: Introduce bdrv_coroutine_enter (Fam Zheng)
8865852: async: Introduce aio_co_enter (Fam Zheng)
ba9e75c: coroutine: Extract qemu_aio_coroutine_enter (Fam Zheng)
d90fce9: tests/block-job-txn: Don't start block job before adding to txn (F=
am Zheng)
aabf591: block: Quiesce old aio context during bdrv_set_aio_context (Fam Zh=
eng)
14e9559: block: Make bdrv_parent_drained_begin/end public (Fam Zheng)
86dbcdd: qxl: add migration blocker to avoid pre-save assert (Gerd Hoffmann)
ad04d8c: configure: on Windows minimum glib version must be 2.30 (Peter May=
dell)
982263c: replay: assert time only goes forward (Alex Benn=C3=A9e)
1d05906: cpus: call cpu_update_icount on read (Alex Benn=C3=A9e)
eda5f7c: cpu-exec: update icount after each TB_EXIT (Alex Benn=C3=A9e)
512d3c8: cpus: introduce cpu_update_icount helper (Alex Benn=C3=A9e)
e4cd965: cpus: don't credit executed instructions before they have run (Ale=
x Benn=C3=A9e)
0524838: cpus: move icount preparation out of tcg_exec_cpu (Alex Benn=C3=A9=
e)
243c5f7: cpus: check cpu->running in cpu_get_icount_raw() (Alex Benn=C3=A9e)
bf51c72: cpus: remove icount handling from qemu_tcg_cpu_thread_fn (Alex Ben=
n=C3=A9e)
b4e79a5: target/i386/misc_helper: wrap BQL around another IRQ generator (Al=
ex Benn=C3=A9e)
8695350: cpus: fix wrong define name (Nikunj A Dadhania)
4ffcdef: 9pfs: xattr: fix memory leak in v9fs_list_xattr (Li Qiang)
8037fa5: scripts/qemugdb/mtree.py: fix up mtree dump (Alex Benn=C3=A9e)
19dd29e: mirror: Fix aio context of mirror_top_bs (Fam Zheng)
bb2614e: block: Assert attached child node has right aio context (Fam Zheng)
c26a5ab: block: Fix unpaired aio_disable_external in external snapshot (Fam=
 Zheng)
1bf03e6: block: Don't check permissions for copy on read (Kevin Wolf)
89aa046: qemu-img: img_create does not support image-opts, fix docs (Jeff C=
ody)
5694923: iotests: Add mirror tests for orphaned source (Max Reitz)
7a25fcd: block/mirror: Fix use-after-free (Max Reitz)
0d0676a: commit: Set commit_top_bs->total_sectors (Kevin Wolf)
02be4ae: commit: Set commit_top_bs->aio_context (Kevin Wolf)
d35ff5e: block: Ignore guest dev permissions during incoming migration (Kev=
in Wolf)
a703d3a: qxl: switch display on entering VGA (Marc-Andr=C3=A9 Lureau)
8f419c5: vfio/pci-quirks: Exclude non-ioport BAR from NVIDIA quirk (Alex Wi=
lliamson)
8c9f42f: tco: do not generate an NMI (Paolo Bonzini)
