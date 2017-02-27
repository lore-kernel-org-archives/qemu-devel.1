Received: from eggs.gnu.org ([2001:4830:134:3::10]:40420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ciJ6W-00080H-4R
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ciJ6T-0004si-Lx
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:04:32 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ciJ6T-0004sZ-Ah
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:04:29 -0500
Received: by mail-lf0-x242.google.com with SMTP id l6so944605lfb.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 03:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Feb 2017 11:04:13 +0000
Message-ID: <CAJ+F1C+67=zo_u0Ae0r08tpxbSFU3VmVe_NLu6Pdq0wV6_sC0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/30] Various memory leak fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi

On Tue, Feb 21, 2017 at 6:27 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> After this series removing a few memory leaks, make check with ASAN
> enabled gives a "clean" run with x86_64-softmmu target (there are
> warnings related to coroutine makecontext/swapcontext).
>
> This should help spot memory related regressions when introducing one.
>
> Note: some of these patches were sent and reviewed previously but not
> yet applied, I rebased them and included them here for completeness.
>

The series is missing reviews of the following patches: 8, 9, 11, 12, 17,
19, 20, 28, 29

Any volunteer? Thanks!


>
> v2:
> - add r-b tags
> - fix gtest compatibility with old glib
> - add "migration: fix id leak regression" patch
>
> Igor Mammedov (1):
>   pc: pcihp: avoid adding ACPI_PCIHP_PROP_BSEL twice
>
> Marc-Andr=C3=A9 Lureau (29):
>   qtest: fix a memory leak
>   tests: fix qmp response leak
>   tests: fix leaks in test-io-channel-command
>   timer: use an inline function for free
>   glib-compat: add g_test_add_data_func_full fallback
>   tests: fix ptimer leaks
>   tests: fix endianness-test leaks
>   tests: fix q35-test leaks
>   tests: fix vhost-user-test leaks
>   tests: fix ide-test leaks
>   tests: fix hd-geo-test leaks
>   tests: fix bios-tables-test leak
>   tests: fix ipmi-kcs-test leak
>   tests: fix ipmi-bt-test leak
>   tests: fix eepro100-test leak
>   tests: fix tco-test leaks
>   tests: fix e1000-test leak
>   tests: fix i440fx-test leaks
>   tests: fix e1000e leaks
>   tests: fix virtio-scsi-test leak
>   tests: fix virtio-9p-test leaks
>   bus: do not unref hotplug handler
>   usb: replace handle_destroy with unrealize
>   usb: release the created buses
>   tests: allows to run single test in usb-hcd-ehci-test
>   tests: fix usb-test leaks
>   tests: add specialized device_find function
>   tests: fix virtio-blk-test leaks
>   migration: fix id leak regression
>
>  include/glib-compat.h           |  21 +++++++
>  include/hw/ptimer.h             |   1 +
>  include/hw/usb.h                |   5 --
>  include/qemu/timer.h            |   5 +-
>  tests/libqos/usb.h              |   1 +
>  tests/libqos/virtio-pci.h       |   6 +-
>  hw/acpi/pcihp.c                 |  11 ----
>  hw/core/bus.c                   |   2 +-
>  hw/core/ptimer.c                |   8 +++
>  hw/i386/acpi-build.c            |   4 +-
>  hw/usb/bus.c                    |   9 +--
>  hw/usb/dev-audio.c              |   4 +-
>  hw/usb/dev-bluetooth.c          |   4 +-
>  hw/usb/dev-hid.c                |   4 +-
>  hw/usb/dev-hub.c                |   4 +-
>  hw/usb/dev-network.c            |   4 +-
>  hw/usb/dev-smartcard-reader.c   |   4 +-
>  hw/usb/dev-storage.c            |  16 ++++++
>  hw/usb/dev-uas.c                |   6 +-
>  hw/usb/dev-wacom.c              |   4 +-
>  hw/usb/host-libusb.c            |   4 +-
>  hw/usb/redirect.c               |   4 +-
>  migration/savevm.c              |   1 +
>  qemu-timer.c                    |   5 --
>  qtest.c                         |   1 +
>  tests/bios-tables-test.c        |   2 +-
>  tests/e1000-test.c              |   1 +
>  tests/e1000e-test.c             |   6 +-
>  tests/eepro100-test.c           |   1 +
>  tests/endianness-test.c         |   3 +
>  tests/hd-geo-test.c             |  47 ++++++++++------
>  tests/i440fx-test.c             |   5 ++
>  tests/ide-test.c                |  12 ++++
>  tests/ipmi-bt-test.c            |   1 +
>  tests/ipmi-kcs-test.c           |   1 +
>  tests/libqos/usb.c              |   6 ++
>  tests/libqos/virtio-pci.c       |  38 +++++++++++--
>  tests/libqtest.c                |  10 ----
>  tests/postcopy-test.c           |   2 +-
>  tests/ptimer-test-stubs.c       |   5 ++
>  tests/ptimer-test.c             | 122
> ++++++++++++++++++++++++----------------
>  tests/pvpanic-test.c            |   1 +
>  tests/q35-test.c                |   3 +
>  tests/tco-test.c                |  35 +++++++-----
>  tests/test-filter-mirror.c      |   2 +-
>  tests/test-filter-redirector.c  |   4 +-
>  tests/test-io-channel-command.c |   6 +-
>  tests/usb-hcd-ehci-test.c       |  19 +++++--
>  tests/usb-hcd-uhci-test.c       |   1 +
>  tests/vhost-user-test.c         |  11 ++--
>  tests/virtio-9p-test.c          |   2 +-
>  tests/virtio-blk-test.c         |  29 +++++-----
>  tests/virtio-scsi-test.c        |   2 +-
>  53 files changed, 338 insertions(+), 177 deletions(-)
>
> --
> 2.11.0.295.gd7dffce1c.dirty
>
>
> --
Marc-Andr=C3=A9 Lureau
