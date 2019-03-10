Received: from eggs.gnu.org ([209.51.188.92]:41998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h2paC-0005h0-Le
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 22:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h2paB-0001YT-09
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 22:57:04 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h2paA-0001V7-FW
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 22:57:02 -0500
Received: by mail-qt1-f194.google.com with SMTP id f11so1599627qti.7
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 19:56:58 -0800 (PST)
Date: Sat, 9 Mar 2019 22:56:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190309225457-mutt-send-email-mst@kernel.org>
References: <20190309004826.9027-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309004826.9027-1-lersek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/10] bundle edk2 platform firmware with
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Sat, Mar 09, 2019 at 01:48:16AM +0100, Laszlo Ersek wrote:
> Repo:   https://github.com/lersek/qemu.git
> Branch: edk2_build
> 
> This series advances the roms/edk2 submodule to the "edk2-stable201903"
> release, and builds and captures platform firmware binaries from that
> release. At this point they are meant to be used by both end-users and
> by Igor's ACPI unit tests in qtest ("make check").
> 
> Previous discussion:
> 
>   [Qemu-devel] bundling edk2 platform firmware images with QEMU
>   http://mid.mail-archive.com/80f0bae3-e79a-bb68-04c4-1c9c684d95b8@redhat.com
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02601.html
> 
> Note that the series was formatted with "--no-binary" (affecting patch
> #8), therefore it cannot be applied with "git-am". See the remote
> repo/branch reference near the top instead.
> 
> Thanks,
> Laszlo

High time IMO.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Laszlo I suggest you add an entry to MAINTAINERS
and start doing pull requests.

Peter, what do you say? OK with you?


> Laszlo Ersek (10):
>   roms: lift "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"
>   roms/edk2-funcs.sh: require gcc-4.8+ for building i386 and x86_64
>   tests/uefi-test-tools/build.sh: work around TianoCore#1607
>   roms/edk2: advance to tag edk2-stable201903
>   roms/edk2-funcs.sh: add the qemu_edk2_get_thread_count() function
>   roms/Makefile: replace the $(EFIROM) target with "edk2-basetools"
>   roms: build edk2 firmware binaries and variable store templates
>   pc-bios: add edk2 firmware binaries and variable store templates
>   pc-bios: document the edk2 firmware images; add firmware descriptors
>   Makefile: install the edk2 firmware images and their descriptors
> 
>  Makefile                                       |  17 +-
>  pc-bios/README                                 |  11 +
>  pc-bios/descriptors/50-edk2-i386-secure.json   |  34 +++
>  pc-bios/descriptors/50-edk2-x86_64-secure.json |  35 +++
>  pc-bios/descriptors/60-edk2-aarch64.json       |  31 +++
>  pc-bios/descriptors/60-edk2-arm.json           |  31 +++
>  pc-bios/descriptors/60-edk2-i386.json          |  33 +++
>  pc-bios/descriptors/60-edk2-x86_64.json        |  34 +++
>  pc-bios/edk2-aarch64-code.fd                   | Bin 0 -> 67108864 bytes
>  pc-bios/edk2-arm-code.fd                       | Bin 0 -> 67108864 bytes
>  pc-bios/edk2-arm-vars.fd                       | Bin 0 -> 67108864 bytes
>  pc-bios/edk2-i386-code.fd                      | Bin 0 -> 3653632 bytes
>  pc-bios/edk2-i386-secure-code.fd               | Bin 0 -> 3653632 bytes
>  pc-bios/edk2-i386-vars.fd                      | Bin 0 -> 540672 bytes
>  pc-bios/edk2-licenses.txt                      | 209 ++++++++++++++++
>  pc-bios/edk2-x86_64-code.fd                    | Bin 0 -> 3653632 bytes
>  pc-bios/edk2-x86_64-secure-code.fd             | Bin 0 -> 3653632 bytes
>  roms/Makefile                                  |   9 +-
>  roms/Makefile.edk2                             | 138 +++++++++++
>  roms/edk2                                      |   2 +-
>  roms/edk2-build.sh                             |  55 +++++
>  roms/edk2-funcs.sh                             | 253 ++++++++++++++++++++
>  tests/uefi-test-tools/build.sh                 | 100 +-------
>  23 files changed, 897 insertions(+), 95 deletions(-)
>  create mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
>  create mode 100644 pc-bios/descriptors/50-edk2-x86_64-secure.json
>  create mode 100644 pc-bios/descriptors/60-edk2-aarch64.json
>  create mode 100644 pc-bios/descriptors/60-edk2-arm.json
>  create mode 100644 pc-bios/descriptors/60-edk2-i386.json
>  create mode 100644 pc-bios/descriptors/60-edk2-x86_64.json
>  create mode 100644 pc-bios/edk2-aarch64-code.fd
>  create mode 100644 pc-bios/edk2-arm-code.fd
>  create mode 100644 pc-bios/edk2-arm-vars.fd
>  create mode 100644 pc-bios/edk2-i386-code.fd
>  create mode 100644 pc-bios/edk2-i386-secure-code.fd
>  create mode 100644 pc-bios/edk2-i386-vars.fd
>  create mode 100644 pc-bios/edk2-licenses.txt
>  create mode 100644 pc-bios/edk2-x86_64-code.fd
>  create mode 100644 pc-bios/edk2-x86_64-secure-code.fd
>  create mode 100644 roms/Makefile.edk2
>  create mode 100755 roms/edk2-build.sh
>  create mode 100644 roms/edk2-funcs.sh
> 
> -- 
> 2.19.1.3.g30247aa5d201
