Received: from eggs.gnu.org ([209.51.188.92]:34802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Qeq-0004pY-Gv
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Qep-00029L-4V
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:20:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2Qen-00022w-EC
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:20:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id w6so23188061wrs.4
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 17:20:08 -0800 (PST)
References: <20190309004826.9027-1-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bf1a5775-17d9-c5bd-4e08-451585d3015e@redhat.com>
Date: Sat, 9 Mar 2019 02:20:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190309004826.9027-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

On 3/9/19 1:48 AM, Laszlo Ersek wrote:
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
> 
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

GitHub moans here:

remote: warning: GH001: Large files detected. You may want to try Git
Large File Storage - https://git-lfs.github.com.
remote: warning: See http://git.io/iEPt8g for more information.
remote: warning: File pc-bios/edk2-arm-vars.fd is 64.00 MB; this is
larger than GitHub's recommended maximum file size of 50.00 MB
remote: warning: File pc-bios/edk2-arm-code.fd is 64.00 MB; this is
larger than GitHub's recommended maximum file size of 50.00 MB
remote: warning: File pc-bios/edk2-aarch64-code.fd is 64.00 MB; this is
larger than GitHub's recommended maximum file size of 50.00 MB

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
