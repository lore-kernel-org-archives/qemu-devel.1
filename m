Received: from eggs.gnu.org ([2001:4830:134:3::10]:50224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVWI-00026d-D0
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVWH-0005Xq-2r
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:12:54 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDVWG-0005Wj-OA
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:12:52 -0400
Received: by mail-oi1-x244.google.com with SMTP id u197-v6so26896418oif.5
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 07:12:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 15:12:31 +0100
Message-ID: <CAFEAcA9p0dLoNQy7kBdcXMz0HiMGEZTBX67Lq2SizTY3kgeksw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/45] Machine queue, 2018-10-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, Libvirt <libvir-list@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

On 18 October 2018 at 21:03, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 09558375a634e17cea6cfbfec883ac2376d2dc=
7f:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
81016-1' into staging (2018-10-16 17:42:56 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 6d8e1bcc7dd5e819ce81e6a87fffe23e39c700cc:
>
>   numa: Clean up error reporting in parse_numa() (2018-10-17 16:33:40 -03=
00)
>
> ----------------------------------------------------------------
> Machine queue, 2018-10-18
>
> * sysbus init/realize cleanups
>   (C=C3=A9dric Le Goater, Philippe Mathieu-Daud=C3=A9)
> * memory-device refactoring (David Hildenbrand)
> * -smp: deprecate incorrect CPUs topology (Igor Mammedov)
> * -numa parsing cleanups (Markus Armbruster)
> * Fix hostmem-file memory leak (Zhang Yi)
> * Typo fix (Li Qiang)
>
> ----------------------------------------------------------------
>

Hi. This had some problems in merge testing, I'm afraid:

On aarch64 host, warnings running tests/cpu-plug-test for i386 and s390 tar=
gets:

TEST: tests/cpu-plug-test... (pid=3D12602)
  /i386/cpu-plug/pc-i440fx-3.0/cpu-add/1x3x2&maxcpus=3D12:
qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
(1) * cores (3) * threads (2) !=3D maxcpus (12)
OK
  /i386/cpu-plug/pc-i440fx-3.0/device-add/1x3x2&maxcpus=3D12:
qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
(1) * cores (3) * threads (2) !=3D maxcpus (12)
OK
  /i386/cpu-plug/pc-q35-3.0/cpu-add/1x3x2&maxcpus=3D12:
qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
(1) * cores (3) * threads (2) !=3D maxcpus (12)
OK
  /i386/cpu-plug/pc-q35-3.0/device-add/1x3x2&maxcpus=3D12:
qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
(1) * cores (3) * threads (2) !=3D maxcpus (12)
OK
  /arm/qom/n800:                                                       OK
PASS: tests/cpu-plug-test
[...]
TEST: tests/cpu-plug-test... (pid=3D15040)
  /s390x/cpu-plug/s390-ccw-virtio-3.1/cpu-add/1x3x1&maxcpus=3D6:
qemu-system-s390x: warning: Invalid CPU topology deprecated: sockets
(1) * cores (3) * threads (1) !=3D maxcpus (6)
OK
  /s390x/cpu-plug/s390-ccw-virtio-3.1/device-add/1x3x1&maxcpus=3D6:
qemu-system-s390x: warning: Invalid CPU topology deprecated: sockets
(1) * cores (3) * threads (1) !=3D maxcpus (6)
OK
  /s390x/cpu-plug/s390-ccw-virtio-3.0/cpu-add/1x3x1&maxcpus=3D6:
qemu-system-s390x: warning: Invalid CPU topology deprecated: sockets
(1) * cores (3) * threads (1) !=3D maxcpus (6)
OK
  /s390x/cpu-plug/s390-ccw-virtio-3.0/device-add/1x3x1&maxcpus=3D6:
qemu-system-s390x: warning: Invalid CPU topology deprecated: sockets
(1) * cores (3) * threads (1) !=3D maxcpus (6)
OK
PASS: tests/cpu-plug-test

(plus similar ppc64, x86_64 targets)

I see similar warnings on hosts SPARC, PPC64BE, S390, 32-bit Arm
and x86 FreeBSD.

I also got a build failure on one of my configs, but I think that
is caused by some latent bug in our makefiles where we don't
correctly rebuild x86_64-softmmu/config-devices.mak when a
change is made to default-configs/i386-softmmu.mak -- doing a
hand rm of the config-devices.mak fixed it.


thanks
-- PMM
