Received: from eggs.gnu.org ([2001:4830:134:3::10]:54496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d4a5x-0005Vh-Ty
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 17:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d4a5u-0003s0-Rd
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 17:40:01 -0400
Received: from mail-ve1eur01on0118.outbound.protection.outlook.com
	([104.47.1.118]:56313
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1d4a5u-0003pw-Bf
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 17:39:58 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Sat, 29 Apr 2017 20:06:09 +0000
Message-ID: <VI1PR0601MB2479CA25619E1C66359EC3709C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
References: <VI1PR0601MB247952CA06D05D5041AA450D9C130@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB247995F01C0EC808ADEA07C49C180@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479950F84BBE26A46F549FA9C110@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479D2A56A202E3FD18C6DDF9C1F0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429124421.2qcthvlsiwvtqov2@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CBDA85F323A82C0CFBD99C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode
 networking (SLIRP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, MCDONALD Margaret <margaret.mcdonald@hexagon.com>

>Ok, so nothing going out from qemu. Could you try to apply the attached pa=
tch to qemu-2.9 and see what it makes qemu print when you resolve a domain =
from the guest?

After applying patch, compiling, installing and then doing a nslookup reque=
st in the guest, I still receive no output in tcpdump and my logfile is emp=
ty:

[mfonnemann@localhost qemu-2.9.0]$ make
make  all-recursive
Making all in pixman
make[3]: Nothing to be done for `all'.
Making all in demos
make[3]: Nothing to be done for `all'.
Making all in test
make[3]: Nothing to be done for `all'.
        CHK version_gen.h
  CC      slirp/slirp.o
  CC      slirp/socket.o
  CC      slirp/udp.o
  LINK    i386-softmmu/qemu-system-i386
  LINK    x86_64-softmmu/qemu-system-x86_64

[mfonnemann@localhost qemu-2.9.0]$ sudo make install
[sudo] password for mfonnemann:
make  all-recursive
Making all in pixman
make[3]: Nothing to be done for `all'.
Making all in demos
make[3]: Nothing to be done for `all'.
Making all in test
make[3]: Nothing to be done for `all'.
        CHK version_gen.h
install -d -m 0755 "/usr/local/share/qemu"
install -d -m 0755 "/usr/local/var"/run
install -d -m 0755 "/usr/local/bin"
install -c -m 0755 qemu-ga ivshmem-client ivshmem-server qemu-nbd qemu-img =
qemu-io  "/usr/local/bin"
strip "/usr/local/bin/qemu-ga" "/usr/local/bin/ivshmem-client" "/usr/local/=
bin/ivshmem-server" "/usr/local/bin/qemu-nbd" "/usr/local/bin/qemu-img" "/u=
sr/local/bin/qemu-io"
install -d -m 0755 "/usr/local/libexec"
install -c -m 0755 qemu-bridge-helper "/usr/local/libexec"
strip "/usr/local/libexec/qemu-bridge-helper"
set -e; for x in bios.bin bios-256k.bin sgabios.bin vgabios.bin vgabios-cir=
rus.bin vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virti=
o.bin acpi-dsdt.aml ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-=
ppc QEMU,tcx.bin QEMU,cgthree.bin pxe-e1000.rom pxe-eepro100.rom pxe-ne2k_p=
ci.rom pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom efi-e1000.rom efi-eepro=
100.rom efi-ne2k_pci.rom efi-pcnet.rom efi-rtl8139.rom efi-virtio.rom efi-e=
1000e.rom efi-vmxnet3.rom qemu-icon.bmp qemu_logo_no_text.svg bamboo.dtb pe=
talogix-s3adsp1800.dtb petalogix-ml605.dtb multiboot.bin linuxboot.bin linu=
xboot_dma.bin kvmvapic.bin s390-ccw.img spapr-rtas.bin slof.bin skiboot.lid=
 palcode-clipper u-boot.e500; do \
        install -c -m 0644 /home/mfonnemann/qemu-2.9.0/pc-bios/$x "/usr/loc=
al/share/qemu"; \
done
install -d -m 0755 "/usr/local/share/qemu/keymaps"
set -e; for x in da     en-gb  et  fr     fr-ch  is  lt  modifiers  no  pt-=
br  sv ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru   =
  th common  de-ch  es     fo  fr-ca  hu     ja  mk  nl-be      pt  sl     =
tr bepo    cz; do \
        install -c -m 0644 /home/mfonnemann/qemu-2.9.0/pc-bios/keymaps/$x "=
/usr/local/share/qemu/keymaps"; \
done
install -c -m 0644 /home/mfonnemann/qemu-2.9.0/trace-events-all "/usr/local=
/share/qemu/trace-events-all"
for d in i386-softmmu x86_64-softmmu; do \
make --no-print-directory BUILD_DIR=3D/home/mfonnemann/qemu-2.9.0 TARGET_DI=
R=3D$d/ -C $d install || exit 1 ; \
        done
install -d -m 0755 "/usr/local/bin"
install -c -m 0755 qemu-system-i386  "/usr/local/bin"
strip "/usr/local/bin/qemu-system-i386"
install -d -m 0755 "/usr/local/bin"
install -c -m 0755 qemu-system-x86_64  "/usr/local/bin"
strip "/usr/local/bin/qemu-system-x86_64"

[mfonnemann@localhost qemu]$ /usr/local/bin/qemu-system-i386 -display curse=
s -readconfig qemu.cfg -D logfile

root@qemu:~# nslookup www.google.com

                    *** Unknown host

                    nslookup: www.google.com: Unknown host

[mfonnemann@localhost qemu]$ ls -Al logfile
-rw-rw-r--. 1 mfonnemann mfonnemann 0 Apr 29 15:58 logfile

Mark.
