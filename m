Received: from eggs.gnu.org ([2001:4830:134:3::10]:47233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS4xc-0000Oz-T6
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:44:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS4xY-0008Ex-Ti
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:44:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cS4xY-0008Em-HY
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:44:12 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EC50C04B93D
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 16:44:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-38.ams2.redhat.com
	[10.36.116.38])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0DGiAIw013689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 11:44:11 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 13 Jan 2017 17:44:09 +0100
Message-Id: <1484325849-18314-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 000/180] QAPI patches for 2017-01-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is Marc-Andr=C3=A9's "[PATCH v8 00/21] qapi doc generation (whole
version, squashed)" with a few commit messages tweaked, and "[PATCH v8
14/21] (SQUASHED) move doc to schema" unsquashed into 161 patches.

We did all the respins with in this squashed form to reduce noise.
However, since the unsquashed form is better suited for review, and
probably nicer if we have to revisit this part of the work down the
road, I'm proposing to merge this unsquashed.

If you want me to post the unsquashed patches, I'm happy to redo this
pull request.

If you'd rather pull the squashed version, likewise.

I'm afraid this is a bit of a doc conflict magnet.  The sooner we can
get it in, the easier for Marc-Andr=C3=A9 and me.

The following changes since commit fdbd92f738693abfda60d2d1fc075cd796f33f=
80:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-20170112=
-1' into staging (2017-01-13 14:02:30 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-01-13

for you to fetch changes up to 3b4ce60a8bb5f48d87c925a4a783d005914605d1:

  build-sys: add qapi doc generation targets (2017-01-13 17:32:16 +0100)

----------------------------------------------------------------
QAPI patches for 2017-01-13

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (180):
      qapi: replace 'o' for list items
      qapi: move QKeyCode doc body at the top
      qapi: Format TODO comments more consistently
      qapi: improve device_add schema
      qapi: improve TransactionAction doc
      qga/schema: improve guest-set-vcpus Returns: section
      qapi: Reorder doc comments for future doc generator
      qapi: Move "command is experimental" notes down
      qapi: add some sections in docs
      docs: add master qapi texi files
      qapi: rework qapi Exception
      texi2pod: learn quotation, deftp and deftypefn
      qmp-commands: move 'add_client' doc to schema
      qmp-commands: move 'query-name' doc to schema
      qmp-commands: move 'query-kvm' doc to schema
      qmp-commands: move 'query-status' doc to schema
      qmp-commands: move 'query-uuid' doc to schema
      qmp-commands: move 'query-chardev' doc to schema
      qmp-commands: move 'query-chardev-backends' doc to schema
      qmp-commands: move 'ringbuf-write' doc to schema
      qmp-commands: move 'ringbuf-read' doc to schema
      qmp-commands: move 'query-events' doc to schema
      qmp-commands: move 'query-migrate' doc to schema
      qmp-commands: move 'migrate-set-capabilities' doc to schema
      qmp-commands: move 'query-migrate-capabilities' doc to schema
      qmp-commands: move 'migrate-set-parameters' doc to schema
      qmp-commands: move 'query-migrate-parameters' doc to schema
      qmp-commands: move 'client_migrate_info' doc to schema
      qmp-commands: move 'migrate-start-postcopy' doc to schema
      qmp-commands: move 'query-mice' doc to schema
      qmp-commands: move 'query-cpus' doc to schema
      qmp-commands: move 'query-iothreads' doc to schema
      qmp-commands: move 'query-vnc' doc to schema
      qmp-commands: move 'query-spice' doc to schema
      qmp-commands: move 'query-balloon' doc to schema
      qmp-commands: move 'query-pci' doc to schema
      qmp-commands: move 'quit' doc to schema
      qmp-commands: move 'stop' doc to schema
      qmp-commands: move 'system_reset' doc to schema
      qmp-commands: move 'system_powerdown' doc to schema
      qmp-commands: move 'cpu-add' doc to schema
      qmp-commands: move 'memsave' doc to schema
      qmp-commands: move 'pmemsave' doc to schema
      qmp-commands: move 'cont' doc to schema
      qmp-commands: move 'system_wakeup' doc to schema
      qmp-commands: move 'inject-nmi' doc to schema
      qmp-commands: move 'set_link' doc to schema
      qmp-commands: move 'balloon' doc to schema
      qmp-commands: move 'transaction' doc to schema
      qmp-commands: move 'human-monitor-command' doc to schema
      qmp-commands: move 'migrate_cancel' doc to schema
      qmp-commands: move 'migrate_set_downtime' doc to schema
      qmp-commands: move 'migrate_set_speed' doc to schema
      qmp-commands: move 'query-migrate-cache-size' doc to schema
      qmp-commands: move 'set_password' doc to schema
      qmp-commands: move 'expire_password' doc to schema
      qmp-commands: move 'change' doc to schema
      qmp-commands: move 'migrate' doc to schema
      qmp-commands: move 'migrate-incoming' doc to schema
      qmp-commands: move 'xen-save-devices-state' doc to schema
      qmp-commands: move 'xen-set-global-dirty-log' doc to schema
      qmp-commands: move 'device_del' doc to schema
      qmp-commands: move 'dump-guest-memory' doc to schema
      qmp-commands: move 'query-dump-guest-memory-capability' doc to sche=
ma
      qmp-commands: move 'dump-skeys' doc to schema
      qmp-commands: move 'netdev_add' doc to schema
      qmp-commands: move 'netdev_del' doc to schema
      qmp-commands: move 'object-add' doc to schema
      qmp-commands: move 'object-del' doc to schema
      qmp-commands: move 'getfd' doc to schema
      qmp-commands: move 'closefd' doc to schema
      qmp-commands: move 'add-fd' doc to schema
      qmp-commands: move 'remove-fd' doc to schema
      qmp-commands: move 'query-fdsets' doc to schema
      qmp-commands: move 'send-key' doc to schema
      qmp-commands: move 'screendump' doc to schema
      qmp-commands: move 'chardev-add' doc to schema
      qmp-commands: move 'chardev-remove' doc to schema
      qmp-commands: move 'query-tpm-models' doc to schema
      qmp-commands: move 'query-tpm-types' doc to schema
      qmp-commands: move 'query-tpm' doc to schema
      qmp-commands: move 'query-command-line-options' doc to schema
      qmp-commands: move 'query-rx-filter' doc to schema
      qmp-commands: move 'input-send-event' doc to schema
      qmp-commands: move 'query-memdev' doc to schema
      qmp-commands: move 'query-memory-devices' doc to schema
      qmp-commands: move 'query-acpi-ospm-status' doc to schema
      qmp-commands: move 'rtc-reset-reinjection' doc to schema
      qmp-commands: move 'query-block' doc to schema
      qmp-commands: move 'query-blockstats' doc to schema
      qmp-commands: move 'block_passwd' doc to schema
      qmp-commands: move 'block_resize' doc to schema
      qmp-commands: move 'blockdev-snapshot-sync' doc to schema
      qmp-commands: move 'blockdev-snapshot' doc to schema
      qmp-commands: move 'change-backing-file' doc to schema
      qmp-commands: move 'block-commit' doc to schema
      qmp-commands: move 'drive-backup' doc to schema
      qmp-commands: move 'blockdev-backup' doc to schema
      qmp-commands: move 'query-named-block-nodes' doc to schema
      qmp-commands: move 'drive-mirror' doc to schema
      qmp-commands: move 'block-dirty-bitmap-add' doc to schema
      qmp-commands: move 'block-dirty-bitmap-remove' doc to schema
      qmp-commands: move 'block-dirty-bitmap-clear' doc to schema
      qmp-commands: move 'block_set_io_throttle' doc to schema
      qmp-commands: move 'block-stream' doc to schema
      qmp-commands: move 'blockdev-add' doc to schema
      qmp-commands: move 'x-blockdev-del' doc to schema
      qmp-commands: move 'blockdev-open-tray' doc to schema
      qmp-commands: move 'blockdev-close-tray' doc to schema
      qmp-commands: move 'x-blockdev-remove-medium' doc to schema
      qmp-commands: move 'x-blockdev-insert-medium' doc to schema
      qmp-commands: move 'blockdev-change-medium' doc to schema
      qmp-commands: move 'block-set-write-threshold' doc to schema
      qmp-commands: move 'blockdev-snapshot-internal-sync' doc to schema
      qmp-commands: move 'blockdev-snapshot-delete-internal-sync' doc to =
schema
      qmp-commands: move 'eject' doc to schema
      qmp-commands: move 'query-version' doc to schema
      qmp-commands: move 'query-commands' doc to schema
      qmp-commands: move 'query-rocker' doc to schema
      qmp-commands: move 'query-rocker-ports' doc to schema
      qmp-commands: move 'query-rocker-of-dpa-flows' doc to schema
      qmp-commands: move 'query-rocker-of-dpa-groups' doc to schema
      qmp-commands: move 'trace-event-get-state' doc to schema
      qmp-commands: move 'trace-event-set-state' doc to schema
      qmp-commands: move 'query-hotpluggable-cpus' doc to schema
      qmp-commands: move 'query-gic-capabilities' doc to schema
      qmp-commands: move 'x-blockdev-change' doc to schema
      qmp-commands: move 'blockdev-mirror' doc to schema
      qmp-commands: move 'query-dump' doc to schema
      qmp-commands: move 'migrate-set-cache-size' doc to schema
      qmp-commands: move 'xen-load-devices-state' doc to schema
      qmp-commands: move 'x-colo-lost-heartbeat' doc to schema
      qmp-commands: remove query-qmp-schema from txt
      qmp-commands: remove qmp_capabilities from txt
      qmp-commands: remove cpu from txt
      qmp-commands: remove device_add from txt
      qmp-commands: move documentation bits to schema
      qmp-events: move 'BLOCK_IMAGE_CORRUPTED' doc to schema
      qmp-events: move 'BLOCK_IO_ERROR' doc to schema
      qmp-events: move 'BLOCK_JOB_COMPLETED' doc to schema
      qmp-events: move 'BLOCK_JOB_CANCELLED' doc to schema
      qmp-events: move 'BLOCK_JOB_ERROR' doc to schema
      qmp-events: move 'BLOCK_JOB_READY' doc to schema
      qmp-events: move 'DEVICE_TRAY_MOVED' doc to schema
      qmp-events: move 'SHUTDOWN' doc to schema
      qmp-events: move 'POWERDOWN' doc to schema
      qmp-events: move 'RESET' doc to schema
      qmp-events: move 'STOP' doc to schema
      qmp-events: move 'RESUME' doc to schema
      qmp-events: move 'SUSPEND' doc to schema
      qmp-events: move 'SUSPEND_DISK' doc to schema
      qmp-events: move 'WAKEUP' doc to schema
      qmp-events: move 'RTC_CHANGE' doc to schema
      qmp-events: move 'WATCHDOG' doc to schema
      qmp-events: move 'DEVICE_DELETED' doc to schema
      qmp-events: move 'NIC_RX_FILTER_CHANGED' doc to schema
      qmp-events: move 'VNC_CONNECTED' doc to schema
      qmp-events: move 'VNC_INITIALIZED' doc to schema
      qmp-events: move 'VNC_DISCONNECTED' doc to schema
      qmp-events: move 'SPICE_CONNECTED' doc to schema
      qmp-events: move 'SPICE_INITIALIZED' doc to schema
      qmp-events: move 'SPICE_DISCONNECTED' doc to schema
      qmp-events: move 'SPICE_MIGRATE_COMPLETED' doc to schema
      qmp-events: move 'MIGRATION' doc to schema
      qmp-events: move 'ACPI_DEVICE_OST' doc to schema
      qmp-events: move 'BALLOON_CHANGE' doc to schema
      qmp-events: move 'GUEST_PANICKED' doc to schema
      qmp-events: move 'QUORUM_FAILURE' doc to schema
      qmp-events: move 'QUORUM_REPORT_BAD' doc to schema
      qmp-events: move 'VSERPORT_CHANGE' doc to schema
      qmp-events: move 'MEM_UNPLUG_ERROR' doc to schema
      qmp-events: move 'DUMP_COMPLETED' doc to schema
      qmp-events: move 'MIGRATION_PASS' doc to schema
      qapi: add qapi2texi script
      docs: add qemu logo to pdf
      build-sys: use --no-split for info
      build-sys: remove dvi doc generation
      build-sys: use a generic TEXI2MAN rule
      build-sys: add txt documentation rules
      build-sys: add qapi doc generation targets

 .gitignore                                         |   11 +-
 Makefile                                           |   94 +-
 configure                                          |    2 +-
 docs/qapi-code-gen.txt                             |  180 +-
 docs/qemu-ga-ref.texi                              |   78 +
 docs/qemu-qmp-ref.texi                             |   78 +
 docs/qemu_logo.pdf                                 |  Bin 0 -> 9117 byte=
s
 docs/qmp-commands.txt                              | 3824 --------------=
------
 docs/qmp-events.txt                                |  731 ----
 docs/qmp-intro.txt                                 |    3 +-
 qapi-schema.json                                   | 1338 ++++++-
 qapi/block-core.json                               |  700 +++-
 qapi/block.json                                    |   66 +-
 qapi/common.json                                   |   38 +-
 qapi/crypto.json                                   |    5 +-
 qapi/event.json                                    |  250 +-
 qapi/introspect.json                               |    5 +-
 qapi/rocker.json                                   |   61 +-
 qapi/trace.json                                    |   17 +
 qga/qapi-schema.json                               |   11 +-
 rules.mak                                          |   12 +
 scripts/qapi.py                                    |  583 ++-
 scripts/qapi2texi.py                               |  271 ++
 scripts/texi2pod.pl                                |   54 +-
 tests/Makefile.include                             |   20 +
 tests/qapi-schema/alternate-any.err                |    2 +-
 tests/qapi-schema/alternate-any.json               |    4 +
 tests/qapi-schema/alternate-array.err              |    2 +-
 tests/qapi-schema/alternate-array.json             |    7 +
 tests/qapi-schema/alternate-base.err               |    2 +-
 tests/qapi-schema/alternate-base.json              |    7 +
 tests/qapi-schema/alternate-clash.err              |    2 +-
 tests/qapi-schema/alternate-clash.json             |    4 +
 tests/qapi-schema/alternate-conflict-dict.err      |    2 +-
 tests/qapi-schema/alternate-conflict-dict.json     |   10 +
 tests/qapi-schema/alternate-conflict-string.err    |    2 +-
 tests/qapi-schema/alternate-conflict-string.json   |    7 +
 tests/qapi-schema/alternate-empty.err              |    2 +-
 tests/qapi-schema/alternate-empty.json             |    4 +
 tests/qapi-schema/alternate-nested.err             |    2 +-
 tests/qapi-schema/alternate-nested.json            |    7 +
 tests/qapi-schema/alternate-unknown.err            |    2 +-
 tests/qapi-schema/alternate-unknown.json           |    4 +
 tests/qapi-schema/args-alternate.err               |    2 +-
 tests/qapi-schema/args-alternate.json              |    8 +
 tests/qapi-schema/args-any.err                     |    2 +-
 tests/qapi-schema/args-any.json                    |    4 +
 tests/qapi-schema/args-array-empty.err             |    2 +-
 tests/qapi-schema/args-array-empty.json            |    4 +
 tests/qapi-schema/args-array-unknown.err           |    2 +-
 tests/qapi-schema/args-array-unknown.json          |    4 +
 tests/qapi-schema/args-bad-boxed.err               |    2 +-
 tests/qapi-schema/args-bad-boxed.json              |    4 +
 tests/qapi-schema/args-boxed-anon.err              |    2 +-
 tests/qapi-schema/args-boxed-anon.json             |    4 +
 tests/qapi-schema/args-boxed-empty.err             |    2 +-
 tests/qapi-schema/args-boxed-empty.json            |    8 +
 tests/qapi-schema/args-boxed-string.err            |    2 +-
 tests/qapi-schema/args-boxed-string.json           |    4 +
 tests/qapi-schema/args-int.err                     |    2 +-
 tests/qapi-schema/args-int.json                    |    4 +
 tests/qapi-schema/args-invalid.err                 |    2 +-
 tests/qapi-schema/args-invalid.json                |    3 +
 tests/qapi-schema/args-member-array-bad.err        |    2 +-
 tests/qapi-schema/args-member-array-bad.json       |    4 +
 tests/qapi-schema/args-member-case.err             |    2 +-
 tests/qapi-schema/args-member-case.json            |    4 +
 tests/qapi-schema/args-member-unknown.err          |    2 +-
 tests/qapi-schema/args-member-unknown.json         |    4 +
 tests/qapi-schema/args-name-clash.err              |    2 +-
 tests/qapi-schema/args-name-clash.json             |    4 +
 tests/qapi-schema/args-union.err                   |    2 +-
 tests/qapi-schema/args-union.json                  |    7 +
 tests/qapi-schema/args-unknown.err                 |    2 +-
 tests/qapi-schema/args-unknown.json                |    4 +
 tests/qapi-schema/bad-base.err                     |    2 +-
 tests/qapi-schema/bad-base.json                    |    7 +
 tests/qapi-schema/bad-data.err                     |    2 +-
 tests/qapi-schema/bad-data.json                    |    4 +
 tests/qapi-schema/bad-ident.err                    |    2 +-
 tests/qapi-schema/bad-ident.json                   |    4 +
 tests/qapi-schema/bad-type-bool.err                |    2 +-
 tests/qapi-schema/bad-type-bool.json               |    4 +
 tests/qapi-schema/bad-type-dict.err                |    2 +-
 tests/qapi-schema/bad-type-dict.json               |    4 +
 tests/qapi-schema/base-cycle-direct.err            |    2 +-
 tests/qapi-schema/base-cycle-direct.json           |    4 +
 tests/qapi-schema/base-cycle-indirect.err          |    2 +-
 tests/qapi-schema/base-cycle-indirect.json         |    7 +
 tests/qapi-schema/command-int.err                  |    2 +-
 tests/qapi-schema/command-int.json                 |    4 +
 tests/qapi-schema/comments.json                    |    4 +
 tests/qapi-schema/comments.out                     |    3 +
 tests/qapi-schema/doc-bad-args.err                 |    1 +
 tests/qapi-schema/doc-bad-args.exit                |    1 +
 tests/qapi-schema/doc-bad-args.json                |    8 +
 tests/qapi-schema/doc-bad-args.out                 |    0
 tests/qapi-schema/doc-bad-symbol.err               |    1 +
 tests/qapi-schema/doc-bad-symbol.exit              |    1 +
 tests/qapi-schema/doc-bad-symbol.json              |    6 +
 tests/qapi-schema/doc-bad-symbol.out               |    0
 tests/qapi-schema/doc-duplicated-arg.err           |    1 +
 tests/qapi-schema/doc-duplicated-arg.exit          |    1 +
 tests/qapi-schema/doc-duplicated-arg.json          |    7 +
 tests/qapi-schema/doc-duplicated-arg.out           |    0
 tests/qapi-schema/doc-duplicated-return.err        |    1 +
 tests/qapi-schema/doc-duplicated-return.exit       |    1 +
 tests/qapi-schema/doc-duplicated-return.json       |    8 +
 tests/qapi-schema/doc-duplicated-return.out        |    0
 tests/qapi-schema/doc-duplicated-since.err         |    1 +
 tests/qapi-schema/doc-duplicated-since.exit        |    1 +
 tests/qapi-schema/doc-duplicated-since.json        |    8 +
 tests/qapi-schema/doc-duplicated-since.out         |    0
 tests/qapi-schema/doc-empty-arg.err                |    1 +
 tests/qapi-schema/doc-empty-arg.exit               |    1 +
 tests/qapi-schema/doc-empty-arg.json               |    6 +
 tests/qapi-schema/doc-empty-arg.out                |    0
 tests/qapi-schema/doc-empty-section.err            |    1 +
 tests/qapi-schema/doc-empty-section.exit           |    1 +
 tests/qapi-schema/doc-empty-section.json           |    8 +
 tests/qapi-schema/doc-empty-section.out            |    0
 tests/qapi-schema/doc-empty-symbol.err             |    1 +
 tests/qapi-schema/doc-empty-symbol.exit            |    1 +
 tests/qapi-schema/doc-empty-symbol.json            |    5 +
 tests/qapi-schema/doc-empty-symbol.out             |    0
 tests/qapi-schema/doc-interleaved-section.err      |    1 +
 tests/qapi-schema/doc-interleaved-section.exit     |    1 +
 tests/qapi-schema/doc-interleaved-section.json     |   21 +
 tests/qapi-schema/doc-interleaved-section.out      |    0
 tests/qapi-schema/doc-invalid-end.err              |    1 +
 tests/qapi-schema/doc-invalid-end.exit             |    1 +
 tests/qapi-schema/doc-invalid-end.json             |    5 +
 tests/qapi-schema/doc-invalid-end.out              |    0
 tests/qapi-schema/doc-invalid-end2.err             |    1 +
 tests/qapi-schema/doc-invalid-end2.exit            |    1 +
 tests/qapi-schema/doc-invalid-end2.json            |    5 +
 tests/qapi-schema/doc-invalid-end2.out             |    0
 tests/qapi-schema/doc-invalid-return.err           |    1 +
 tests/qapi-schema/doc-invalid-return.exit          |    1 +
 tests/qapi-schema/doc-invalid-return.json          |    7 +
 tests/qapi-schema/doc-invalid-return.out           |    0
 tests/qapi-schema/doc-invalid-section.err          |    1 +
 tests/qapi-schema/doc-invalid-section.exit         |    1 +
 tests/qapi-schema/doc-invalid-section.json         |    6 +
 tests/qapi-schema/doc-invalid-section.out          |    0
 tests/qapi-schema/doc-invalid-start.err            |    1 +
 tests/qapi-schema/doc-invalid-start.exit           |    1 +
 tests/qapi-schema/doc-invalid-start.json           |    5 +
 tests/qapi-schema/doc-invalid-start.out            |    0
 tests/qapi-schema/doc-missing-colon.err            |    1 +
 tests/qapi-schema/doc-missing-colon.exit           |    1 +
 tests/qapi-schema/doc-missing-colon.json           |    5 +
 tests/qapi-schema/doc-missing-colon.out            |    0
 tests/qapi-schema/doc-missing-expr.err             |    1 +
 tests/qapi-schema/doc-missing-expr.exit            |    1 +
 tests/qapi-schema/doc-missing-expr.json            |    5 +
 tests/qapi-schema/doc-missing-expr.out             |    0
 tests/qapi-schema/doc-missing-space.err            |    1 +
 tests/qapi-schema/doc-missing-space.exit           |    1 +
 tests/qapi-schema/doc-missing-space.json           |    6 +
 tests/qapi-schema/doc-missing-space.out            |    0
 tests/qapi-schema/doc-optional.err                 |    1 +
 tests/qapi-schema/doc-optional.exit                |    1 +
 tests/qapi-schema/doc-optional.json                |    7 +
 tests/qapi-schema/doc-optional.out                 |    0
 tests/qapi-schema/double-type.err                  |    2 +-
 tests/qapi-schema/double-type.json                 |    4 +
 tests/qapi-schema/enum-bad-name.err                |    2 +-
 tests/qapi-schema/enum-bad-name.json               |    4 +
 tests/qapi-schema/enum-bad-prefix.err              |    2 +-
 tests/qapi-schema/enum-bad-prefix.json             |    4 +
 tests/qapi-schema/enum-clash-member.err            |    2 +-
 tests/qapi-schema/enum-clash-member.json           |    4 +
 tests/qapi-schema/enum-dict-member.err             |    2 +-
 tests/qapi-schema/enum-dict-member.json            |    4 +
 tests/qapi-schema/enum-member-case.err             |    2 +-
 tests/qapi-schema/enum-member-case.json            |    7 +
 tests/qapi-schema/enum-missing-data.err            |    2 +-
 tests/qapi-schema/enum-missing-data.json           |    4 +
 tests/qapi-schema/enum-wrong-data.err              |    2 +-
 tests/qapi-schema/enum-wrong-data.json             |    4 +
 tests/qapi-schema/event-boxed-empty.err            |    2 +-
 tests/qapi-schema/event-boxed-empty.json           |    4 +
 tests/qapi-schema/event-case.json                  |    4 +
 tests/qapi-schema/event-case.out                   |    3 +
 tests/qapi-schema/event-nest-struct.err            |    2 +-
 tests/qapi-schema/event-nest-struct.json           |    4 +
 tests/qapi-schema/flat-union-array-branch.err      |    2 +-
 tests/qapi-schema/flat-union-array-branch.json     |   12 +
 tests/qapi-schema/flat-union-bad-base.err          |    2 +-
 tests/qapi-schema/flat-union-bad-base.json         |   13 +
 tests/qapi-schema/flat-union-bad-discriminator.err |    2 +-
 .../qapi-schema/flat-union-bad-discriminator.json  |   16 +
 tests/qapi-schema/flat-union-base-any.err          |    2 +-
 tests/qapi-schema/flat-union-base-any.json         |   13 +
 tests/qapi-schema/flat-union-base-union.err        |    2 +-
 tests/qapi-schema/flat-union-base-union.json       |   16 +
 tests/qapi-schema/flat-union-clash-member.err      |    2 +-
 tests/qapi-schema/flat-union-clash-member.json     |   16 +
 tests/qapi-schema/flat-union-empty.err             |    2 +-
 tests/qapi-schema/flat-union-empty.json            |   10 +
 tests/qapi-schema/flat-union-incomplete-branch.err |    2 +-
 .../qapi-schema/flat-union-incomplete-branch.json  |   10 +
 tests/qapi-schema/flat-union-inline.err            |    2 +-
 tests/qapi-schema/flat-union-inline.json           |   10 +
 tests/qapi-schema/flat-union-int-branch.err        |    2 +-
 tests/qapi-schema/flat-union-int-branch.json       |   13 +
 .../qapi-schema/flat-union-invalid-branch-key.err  |    2 +-
 .../qapi-schema/flat-union-invalid-branch-key.json |   15 +
 .../flat-union-invalid-discriminator.err           |    2 +-
 .../flat-union-invalid-discriminator.json          |   15 +
 tests/qapi-schema/flat-union-no-base.err           |    2 +-
 tests/qapi-schema/flat-union-no-base.json          |   13 +
 .../flat-union-optional-discriminator.err          |    2 +-
 .../flat-union-optional-discriminator.json         |   13 +
 .../flat-union-string-discriminator.err            |    2 +-
 .../flat-union-string-discriminator.json           |   15 +
 tests/qapi-schema/ident-with-escape.json           |    4 +
 tests/qapi-schema/ident-with-escape.out            |    3 +
 tests/qapi-schema/include-relpath-sub.json         |    3 +
 tests/qapi-schema/include-relpath.out              |    3 +
 tests/qapi-schema/include-repetition.out           |    3 +
 tests/qapi-schema/include-simple-sub.json          |    3 +
 tests/qapi-schema/include-simple.out               |    3 +
 tests/qapi-schema/indented-expr.json               |    6 +
 tests/qapi-schema/indented-expr.out                |    6 +
 tests/qapi-schema/missing-type.err                 |    2 +-
 tests/qapi-schema/missing-type.json                |    4 +
 tests/qapi-schema/nested-struct-data.err           |    2 +-
 tests/qapi-schema/nested-struct-data.json          |    4 +
 tests/qapi-schema/qapi-schema-test.json            |  213 ++
 tests/qapi-schema/qapi-schema-test.out             |  212 ++
 tests/qapi-schema/redefined-builtin.err            |    2 +-
 tests/qapi-schema/redefined-builtin.json           |    4 +
 tests/qapi-schema/redefined-command.err            |    2 +-
 tests/qapi-schema/redefined-command.json           |    7 +
 tests/qapi-schema/redefined-event.err              |    2 +-
 tests/qapi-schema/redefined-event.json             |    7 +
 tests/qapi-schema/redefined-type.err               |    2 +-
 tests/qapi-schema/redefined-type.json              |    7 +
 tests/qapi-schema/reserved-command-q.err           |    2 +-
 tests/qapi-schema/reserved-command-q.json          |    7 +
 tests/qapi-schema/reserved-enum-q.err              |    2 +-
 tests/qapi-schema/reserved-enum-q.json             |    4 +
 tests/qapi-schema/reserved-member-has.err          |    2 +-
 tests/qapi-schema/reserved-member-has.json         |    4 +
 tests/qapi-schema/reserved-member-q.err            |    2 +-
 tests/qapi-schema/reserved-member-q.json           |    4 +
 tests/qapi-schema/reserved-member-u.err            |    2 +-
 tests/qapi-schema/reserved-member-u.json           |    4 +
 tests/qapi-schema/reserved-member-underscore.err   |    2 +-
 tests/qapi-schema/reserved-member-underscore.json  |    4 +
 tests/qapi-schema/reserved-type-kind.err           |    2 +-
 tests/qapi-schema/reserved-type-kind.json          |    4 +
 tests/qapi-schema/reserved-type-list.err           |    2 +-
 tests/qapi-schema/reserved-type-list.json          |    4 +
 tests/qapi-schema/returns-alternate.err            |    2 +-
 tests/qapi-schema/returns-alternate.json           |    7 +
 tests/qapi-schema/returns-array-bad.err            |    2 +-
 tests/qapi-schema/returns-array-bad.json           |    4 +
 tests/qapi-schema/returns-dict.err                 |    2 +-
 tests/qapi-schema/returns-dict.json                |    4 +
 tests/qapi-schema/returns-unknown.err              |    2 +-
 tests/qapi-schema/returns-unknown.json             |    4 +
 tests/qapi-schema/returns-whitelist.err            |    2 +-
 tests/qapi-schema/returns-whitelist.json           |   16 +
 tests/qapi-schema/struct-base-clash-deep.err       |    2 +-
 tests/qapi-schema/struct-base-clash-deep.json      |   10 +
 tests/qapi-schema/struct-base-clash.err            |    2 +-
 tests/qapi-schema/struct-base-clash.json           |    7 +
 tests/qapi-schema/struct-data-invalid.err          |    2 +-
 tests/qapi-schema/struct-data-invalid.json         |    3 +
 tests/qapi-schema/struct-member-invalid.err        |    2 +-
 tests/qapi-schema/struct-member-invalid.json       |    3 +
 tests/qapi-schema/test-qapi.py                     |   12 +
 tests/qapi-schema/type-bypass-bad-gen.err          |    2 +-
 tests/qapi-schema/type-bypass-bad-gen.json         |    4 +
 tests/qapi-schema/unicode-str.err                  |    2 +-
 tests/qapi-schema/unicode-str.json                 |    4 +
 tests/qapi-schema/union-base-no-discriminator.err  |    2 +-
 tests/qapi-schema/union-base-no-discriminator.json |   12 +
 tests/qapi-schema/union-branch-case.err            |    2 +-
 tests/qapi-schema/union-branch-case.json           |    4 +
 tests/qapi-schema/union-clash-branches.err         |    2 +-
 tests/qapi-schema/union-clash-branches.json        |    4 +
 tests/qapi-schema/union-empty.err                  |    2 +-
 tests/qapi-schema/union-empty.json                 |    4 +
 tests/qapi-schema/union-invalid-base.err           |    2 +-
 tests/qapi-schema/union-invalid-base.json          |   10 +
 tests/qapi-schema/union-optional-branch.err        |    2 +-
 tests/qapi-schema/union-optional-branch.json       |    4 +
 tests/qapi-schema/union-unknown.err                |    2 +-
 tests/qapi-schema/union-unknown.json               |    4 +
 tests/qapi-schema/unknown-escape.err               |    2 +-
 tests/qapi-schema/unknown-escape.json              |    4 +
 tests/qapi-schema/unknown-expr-key.err             |    2 +-
 tests/qapi-schema/unknown-expr-key.json            |    4 +
 297 files changed, 4846 insertions(+), 5012 deletions(-)
 create mode 100644 docs/qemu-ga-ref.texi
 create mode 100644 docs/qemu-qmp-ref.texi
 create mode 100644 docs/qemu_logo.pdf
 delete mode 100644 docs/qmp-commands.txt
 delete mode 100644 docs/qmp-events.txt
 create mode 100755 scripts/qapi2texi.py
 create mode 100644 tests/qapi-schema/doc-bad-args.err
 create mode 100644 tests/qapi-schema/doc-bad-args.exit
 create mode 100644 tests/qapi-schema/doc-bad-args.json
 create mode 100644 tests/qapi-schema/doc-bad-args.out
 create mode 100644 tests/qapi-schema/doc-bad-symbol.err
 create mode 100644 tests/qapi-schema/doc-bad-symbol.exit
 create mode 100644 tests/qapi-schema/doc-bad-symbol.json
 create mode 100644 tests/qapi-schema/doc-bad-symbol.out
 create mode 100644 tests/qapi-schema/doc-duplicated-arg.err
 create mode 100644 tests/qapi-schema/doc-duplicated-arg.exit
 create mode 100644 tests/qapi-schema/doc-duplicated-arg.json
 create mode 100644 tests/qapi-schema/doc-duplicated-arg.out
 create mode 100644 tests/qapi-schema/doc-duplicated-return.err
 create mode 100644 tests/qapi-schema/doc-duplicated-return.exit
 create mode 100644 tests/qapi-schema/doc-duplicated-return.json
 create mode 100644 tests/qapi-schema/doc-duplicated-return.out
 create mode 100644 tests/qapi-schema/doc-duplicated-since.err
 create mode 100644 tests/qapi-schema/doc-duplicated-since.exit
 create mode 100644 tests/qapi-schema/doc-duplicated-since.json
 create mode 100644 tests/qapi-schema/doc-duplicated-since.out
 create mode 100644 tests/qapi-schema/doc-empty-arg.err
 create mode 100644 tests/qapi-schema/doc-empty-arg.exit
 create mode 100644 tests/qapi-schema/doc-empty-arg.json
 create mode 100644 tests/qapi-schema/doc-empty-arg.out
 create mode 100644 tests/qapi-schema/doc-empty-section.err
 create mode 100644 tests/qapi-schema/doc-empty-section.exit
 create mode 100644 tests/qapi-schema/doc-empty-section.json
 create mode 100644 tests/qapi-schema/doc-empty-section.out
 create mode 100644 tests/qapi-schema/doc-empty-symbol.err
 create mode 100644 tests/qapi-schema/doc-empty-symbol.exit
 create mode 100644 tests/qapi-schema/doc-empty-symbol.json
 create mode 100644 tests/qapi-schema/doc-empty-symbol.out
 create mode 100644 tests/qapi-schema/doc-interleaved-section.err
 create mode 100644 tests/qapi-schema/doc-interleaved-section.exit
 create mode 100644 tests/qapi-schema/doc-interleaved-section.json
 create mode 100644 tests/qapi-schema/doc-interleaved-section.out
 create mode 100644 tests/qapi-schema/doc-invalid-end.err
 create mode 100644 tests/qapi-schema/doc-invalid-end.exit
 create mode 100644 tests/qapi-schema/doc-invalid-end.json
 create mode 100644 tests/qapi-schema/doc-invalid-end.out
 create mode 100644 tests/qapi-schema/doc-invalid-end2.err
 create mode 100644 tests/qapi-schema/doc-invalid-end2.exit
 create mode 100644 tests/qapi-schema/doc-invalid-end2.json
 create mode 100644 tests/qapi-schema/doc-invalid-end2.out
 create mode 100644 tests/qapi-schema/doc-invalid-return.err
 create mode 100644 tests/qapi-schema/doc-invalid-return.exit
 create mode 100644 tests/qapi-schema/doc-invalid-return.json
 create mode 100644 tests/qapi-schema/doc-invalid-return.out
 create mode 100644 tests/qapi-schema/doc-invalid-section.err
 create mode 100644 tests/qapi-schema/doc-invalid-section.exit
 create mode 100644 tests/qapi-schema/doc-invalid-section.json
 create mode 100644 tests/qapi-schema/doc-invalid-section.out
 create mode 100644 tests/qapi-schema/doc-invalid-start.err
 create mode 100644 tests/qapi-schema/doc-invalid-start.exit
 create mode 100644 tests/qapi-schema/doc-invalid-start.json
 create mode 100644 tests/qapi-schema/doc-invalid-start.out
 create mode 100644 tests/qapi-schema/doc-missing-colon.err
 create mode 100644 tests/qapi-schema/doc-missing-colon.exit
 create mode 100644 tests/qapi-schema/doc-missing-colon.json
 create mode 100644 tests/qapi-schema/doc-missing-colon.out
 create mode 100644 tests/qapi-schema/doc-missing-expr.err
 create mode 100644 tests/qapi-schema/doc-missing-expr.exit
 create mode 100644 tests/qapi-schema/doc-missing-expr.json
 create mode 100644 tests/qapi-schema/doc-missing-expr.out
 create mode 100644 tests/qapi-schema/doc-missing-space.err
 create mode 100644 tests/qapi-schema/doc-missing-space.exit
 create mode 100644 tests/qapi-schema/doc-missing-space.json
 create mode 100644 tests/qapi-schema/doc-missing-space.out
 create mode 100644 tests/qapi-schema/doc-optional.err
 create mode 100644 tests/qapi-schema/doc-optional.exit
 create mode 100644 tests/qapi-schema/doc-optional.json
 create mode 100644 tests/qapi-schema/doc-optional.out

--=20
2.7.4
