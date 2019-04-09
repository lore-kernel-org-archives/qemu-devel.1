Received: from eggs.gnu.org ([209.51.188.92]:51445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDzy8-0007Zz-2l
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDzy6-0002RA-Oi
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:15:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hDzy6-0002Qx-It
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:15:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id a71so110354qkg.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 16:15:54 -0700 (PDT)
Date: Tue, 9 Apr 2019 19:15:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190409191500-mutt-send-email-mst@kernel.org>
References: <20190409230022.6462-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409230022.6462-1-lersek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1 v4 00/12] bundle edk2 platform
 firmware with QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org

On Wed, Apr 10, 2019 at 01:00:10AM +0200, Laszlo Ersek wrote:
> Repo:   https://github.com/lersek/qemu.git
> Branch: edk2_build_v4
> 
> Posting a v4 is necessary because patch #6 needs
> - manual conflict resolution against some commits between v4.0.0-rc2 and
>   v4.0.0-rc3,
> - and corresponding commit message updates.
> 
> These are noted in more detail on the patch itself:
> 
>   [PATCH for-4.1 v4 06/12]
>   roms/Makefile: replace the $(EDK2_EFIROM) target with "edk2-basetools"
> 
> Due to this update, I had to drop all previous feedback tags on this
> patch. I plan to send a pullreq as soon as 4.0 is released, so please
> re-review / retest the above patch (and *only* the above patch) soon.
> (The notes on the patch list the tags individually that I've now
> dropped.)

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I also think pull requests for that is a good idea.
Firmware is pretty independent of the rest of qemu.

> Version 3, that is:
> 
>   [Qemu-devel] [PATCH for-4.1 v3 00/12] bundle edk2 platform firmware with QEMU
> 
> was posted at:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg06148.html
>   http://mid.mail-archive.com/20190321113408.19929-1-lersek@redhat.com
> 
> Thanks,
> Laszlo
> 
> Laszlo Ersek (12):
>   roms: lift "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"
>   roms/edk2-funcs.sh: require gcc-4.8+ for building i386 and x86_64
>   tests/uefi-test-tools/build.sh: work around TianoCore#1607
>   roms/edk2: advance to tag edk2-stable201903
>   roms/edk2-funcs.sh: add the qemu_edk2_get_thread_count() function
>   roms/Makefile: replace the $(EDK2_EFIROM) target with "edk2-basetools"
>   roms: build edk2 firmware binaries and variable store templates
>   pc-bios: add edk2 firmware binaries and variable store templates
>   pc-bios: document the edk2 firmware images; add firmware descriptors
>   tests: add missing dependency to build QTEST_QEMU_BINARY, round 2
>   Makefile: install the edk2 firmware images and their descriptors
>   MAINTAINERS: add the "EDK2 Firmware" subsystem
> 
>  .gitignore                                     |   1 +
>  MAINTAINERS                                    |  12 +
>  Makefile                                       |  29 ++-
>  configure                                      |   1 +
>  pc-bios/README                                 |  11 +
>  pc-bios/descriptors/50-edk2-i386-secure.json   |  34 +++
>  pc-bios/descriptors/50-edk2-x86_64-secure.json |  35 +++
>  pc-bios/descriptors/60-edk2-aarch64.json       |  31 +++
>  pc-bios/descriptors/60-edk2-arm.json           |  31 +++
>  pc-bios/descriptors/60-edk2-i386.json          |  33 +++
>  pc-bios/descriptors/60-edk2-x86_64.json        |  34 +++
>  pc-bios/edk2-aarch64-code.fd.bz2               | Bin 0 -> 1177603 bytes
>  pc-bios/edk2-arm-code.fd.bz2                   | Bin 0 -> 1173662 bytes
>  pc-bios/edk2-arm-vars.fd.bz2                   | Bin 0 -> 263 bytes
>  pc-bios/edk2-i386-code.fd.bz2                  | Bin 0 -> 1688659 bytes
>  pc-bios/edk2-i386-secure-code.fd.bz2           | Bin 0 -> 1881979 bytes
>  pc-bios/edk2-i386-vars.fd.bz2                  | Bin 0 -> 190 bytes
>  pc-bios/edk2-licenses.txt                      | 209 ++++++++++++++++
>  pc-bios/edk2-x86_64-code.fd.bz2                | Bin 0 -> 1669280 bytes
>  pc-bios/edk2-x86_64-secure-code.fd.bz2         | Bin 0 -> 1901210 bytes
>  roms/Makefile                                  |   9 +-
>  roms/Makefile.edk2                             | 148 ++++++++++++
>  roms/edk2                                      |   2 +-
>  roms/edk2-build.sh                             |  55 +++++
>  roms/edk2-funcs.sh                             | 253 ++++++++++++++++++++
>  tests/Makefile.include                         |   2 +-
>  tests/uefi-test-tools/build.sh                 | 100 +-------
>  27 files changed, 934 insertions(+), 96 deletions(-)
>  create mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
>  create mode 100644 pc-bios/descriptors/50-edk2-x86_64-secure.json
>  create mode 100644 pc-bios/descriptors/60-edk2-aarch64.json
>  create mode 100644 pc-bios/descriptors/60-edk2-arm.json
>  create mode 100644 pc-bios/descriptors/60-edk2-i386.json
>  create mode 100644 pc-bios/descriptors/60-edk2-x86_64.json
>  create mode 100644 pc-bios/edk2-aarch64-code.fd.bz2
>  create mode 100644 pc-bios/edk2-arm-code.fd.bz2
>  create mode 100644 pc-bios/edk2-arm-vars.fd.bz2
>  create mode 100644 pc-bios/edk2-i386-code.fd.bz2
>  create mode 100644 pc-bios/edk2-i386-secure-code.fd.bz2
>  create mode 100644 pc-bios/edk2-i386-vars.fd.bz2
>  create mode 100644 pc-bios/edk2-licenses.txt
>  create mode 100644 pc-bios/edk2-x86_64-code.fd.bz2
>  create mode 100644 pc-bios/edk2-x86_64-secure-code.fd.bz2
>  create mode 100644 roms/Makefile.edk2
>  create mode 100755 roms/edk2-build.sh
>  create mode 100644 roms/edk2-funcs.sh
> 
> -- 
> 2.19.1.3.g30247aa5d201
