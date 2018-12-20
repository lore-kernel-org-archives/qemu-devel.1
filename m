Received: from eggs.gnu.org ([2001:4830:134:3::10]:42204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ga2HR-00044Q-EJ
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ga2HQ-000831-BM
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:38:41 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:36931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ga2HQ-00082P-3J
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:38:40 -0500
Received: by mail-oi1-x22e.google.com with SMTP id y23so2556586oia.4
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 09:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20181220123655.30475-1-pbonzini@redhat.com>
In-Reply-To: <20181220123655.30475-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Dec 2018 17:38:27 +0000
Message-ID: <CAFEAcA_=kHDpwcwnEaVEAfD8fQ_UkjKcs_+k_DpQpo9KvF_nhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 20 Dec 2018 at 12:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e85c577158a2e8e252414959da9ef15c12eec6=
3d:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
8-12-17' into staging (2018-12-18 14:31:06 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b4e8bbb9ae50045160957e7ab66c4f1cae535ea4:
>
>   avoid TABs in files that only contain a few (2018-12-19 16:03:22 +0100)
>
> ----------------------------------------------------------------
> * HAX support for Linux hosts (Alejandro)
> * esp bugfixes (Guenter)
> * Windows build cleanup (Marc-Andr=C3=A9)
> * checkpatch logic improvements (Paolo)
> * coalesced range bugfix (Paolo)
> * switch testsuite to TAP (Paolo)
> * QTAILQ rewrite (Paolo)
> * block/iscsi.c cancellation fixes (Stefan)
> * improve selection of the default accelerator (Thomas)

This seemed to work on most of my test hosts but something
weird happened here: hyperlong repetitive command line and
looks like make got an "fwrite(): Resource temporarily unavailable"
halfway through writing it out??

This was on my x86-64 Linux Ubuntu system, clang build
which I configure with '--cc=3Dclang' '--cxx=3Dclang++' '--enable-gtk'
'--extra-cflags=3D-fsanitize=3Dundefined  -fno-sanitize=3Dshift-base -Werro=
r';
the error is during the 'make -C build/clang check V=3D1' phase.

In any case I think the command lines being produced here
are much too long, compared to the old test driver. This
would be impossible to do a "cut-n-paste the relevant
fragment of the command make ran, so I can retest a
single test in isolation", which is something I do fairly
frequently.

[...]
PASS 56 test-hmp /aarch64/hmp/lm3s811evb
PASS 57 test-hmp /aarch64/hmp/none+2MB
make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/clang'
make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/clang=
'
rc=3D0; {  MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 +
1))}  QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/endianness-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"endianness-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/fdc-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"fdc-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/ide-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"ide-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/ahci-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"ahci-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/hd-geo-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"hd-geo-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/boot-order-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"boot-order-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/bios-tables-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"bios-tables-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/boot-serial-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"boot-serial-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/pxe-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"pxe-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/rtc-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"rtc-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/ipmi-kcs-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"ipmi-kcs-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/ipmi-bt-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"ipmi-bt-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/i440fx-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"i440fx-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/fw_cfg-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"fw_cfg-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/drive_del-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"drive_del-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/wdt_ib700-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"wdt_ib700-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/tco-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"tco-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/e1000-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"e1000-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/e1000e-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"e1000e-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/rtl8139-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"rtl8139-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/pcnet-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"pcnet-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/eepro100-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"eepro100-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/ne2000-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"ne2000-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/nvme-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"nvme-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/ac97-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"ac97-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/es1370-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"es1370-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/virtio-net-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"virtio-net-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/virtio-balloon-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"virtio-balloon-test"  ||  exit
$?;   MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
 QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/virtio-blk-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"virtio-blk-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/virtio-rng-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"virtio-rng-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/virtio-scsi-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"virtio-scsi-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$((
${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/virtio-9p-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"virtio-9p-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/virtio-serial-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"virtio-serial-test"  ||  exit $?;
  MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/virtio-console-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"virtio-console-test"  ||  exit
$?;   MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
 QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/tpci200-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"tpci200-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/ipoctal232-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"ipoctal232-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/display-vga-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"display-vga-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/intel-hda-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"intel-hda-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/ivshmem-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"ivshmem-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/megasas-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"megasas-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/vmxnet3-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"vmxnet3-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/pvpanic-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"pvpanic-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/i82801b11-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"i82801b11-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/ioh3420-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"ioh3420-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/usb-hcd-ohci-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"usb-hcd-ohci-test"  ||  exit $?;
 MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/usb-hcd-uhci-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"usb-hcd-uhci-test"  ||  exit $?;
 MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/usb-hcd-xhci-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"usb-hcd-xhci-test"  ||  exit $?;
 MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/cpu-plug-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"cpu-plug-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/q35-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"q35-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/vmgenid-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"vmgenid-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/vhost-user-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"vhost-user-test"  ||  exit $?;
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img tests/tpm-crb-swtpm-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"tpm-crb-swtpm-test"  ||  exit $?;
  MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 2fwrite():
Resource temporarily unavailable
make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/clang'
make: write error: stdout


thanks
-- PMM
