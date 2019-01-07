Received: from eggs.gnu.org ([209.51.188.92]:53615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggWt0-0007pn-6Z
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggWsr-0002Ro-VJ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:32:13 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggWsm-0002Po-8V
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:32:04 -0500
Received: by mail-oi1-x243.google.com with SMTP id x202so590771oif.13
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 07:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20190106053409.10712-1-fam@euphon.net>
In-Reply-To: <20190106053409.10712-1-fam@euphon.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 15:31:50 +0000
Message-ID: <CAFEAcA8=yM9MB3z9hK_3qW=uyFzRdDQ93y1yAtdG=ikKJoHPMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Block and testing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <fam@euphon.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sun, 6 Jan 2019 at 05:35, Fam Zheng <fam@euphon.net> wrote:
>
> The following changes since commit 9b2e891ec5ccdb4a7d583b77988848282606fdea:
>
>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into staging (2018-12-22 11:25:31 +0000)
>
> are available in the git repository at:
>
>   https://famz@github.com/famz/qemu tags/block-and-testing-pull-request

I think something in your workflow has put in the wrong URL
for your repo here: this looks like the one you use to log
in with (ie to push with), not the general one other people
pull from the repo with. I manually used the github URL I
have on record for you (git://github.com/famz/qemu).


> for you to fetch changes up to 3baa6942169cce0f58b88484ad010742c382480a:
>
>   tests: vm: auto_install OpenBSD (2019-01-02 20:51:15 +0800)

This makes my OpenBSD build test fail:

DEBUG:root:QEMU args: -nodefaults -m 4G -cpu max -vnc
127.0.0.1:0,to=20 -serial file:/home/peter.maydell
/qemu-openbsd/build/vm-test-0cyRK6.tmp/serial.out -smp 18 -enable-kvm
-netdev user,id=vnet,hostfwd=:127.
0.0.1:0-:22,tftp=/tmp/tmpXrGR4K,bootfile=/auto_install,tftp-server-name=10.0.2.4,guestfwd=tcp:10.0.2.4:8
0-cmd:cat /tmp/tmpXrGR4K/install.conf -device
virtio-net-pci,netdev=vnet -device VGA -drive file=tests/v
m/openbsd.img.tmp,if=none,id=drive0,cache=writeback -device
virtio-blk,drive=drive0,bootindex=0 -boot on
ce=n -no-reboot -cdrom
/home/peter.maydell/.cache/qemu-vm/download/535472578c58eb79f8b3c168a22fa5bcd2c1e
6d4
DEBUG:QMP:>>> {'execute': 'quit'}
DEBUG:qemu:Error launching VM
DEBUG:qemu:Command: 'qemu-system-x86_64 -chardev
socket,id=mon,path=/var/tmp/tmp2kj6Xg/qemu-35162-monito
r.sock -mon chardev=mon,mode=control -display none -vga none
-nodefaults -m 4G -cpu max -vnc 127.0.0.1:0
,to=20 -serial file:/home/peter.maydell/qemu-openbsd/build/vm-test-0cyRK6.tmp/serial.out
-smp 18 -enable
-kvm -netdev user,id=vnet,hostfwd=:127.0.0.1:0-:22,tftp=/tmp/tmpXrGR4K,bootfile=/auto_install,tftp-serve
r-name=10.0.2.4,guestfwd=tcp:10.0.2.4:80-cmd:cat
/tmp/tmpXrGR4K/install.conf -device virtio-net-pci,netd
ev=vnet -device VGA -drive
file=tests/vm/openbsd.img.tmp,if=none,id=drive0,cache=writeback
-device virti
o-blk,drive=drive0,bootindex=0 -boot once=n -no-reboot -cdrom
/home/peter.maydell/.cache/qemu-vm/downloa
d/535472578c58eb79f8b3c168a22fa5bcd2c1e6d4'
DEBUG:qemu:Output: "qemu-system-x86_64: -netdev
user,id=vnet,hostfwd=:127.0.0.1:0-:22,tftp=/tmp/tmpXrGR4K,bootfile=/auto_install,tftp-server-name=10.0.2.4,guestfwd=tcp:10.0.2.4:80-cmd:cat
/tmp/tmpXrGR4K/install.conf: Invalid parameter 'tftp-server-name'\n"
ERROR:root:Failed to launch QEMU, command line:
ERROR:root:qemu-system-x86_64 -nodefaults -m 4G -cpu max -vnc
127.0.0.1:0,to=20 -serial
file:/home/peter.maydell/qemu-openbsd/build/vm-test-0cyRK6.tmp/serial.out
-smp 18 -enable-kvm -netdev
user,id=vnet,hostfwd=:127.0.0.1:0-:22,tftp=/tmp/tmpXrGR4K,bootfile=/auto_install,tftp-server-name=10.0.2.4,guestfwd=tcp:10.0.2.4:80-cmd:cat
/tmp/tmpXrGR4K/install.conf -device virtio-net-pci,netdev=vnet -device
VGA -drive file=tests/vm/openbsd.img.tmp,if=none,id=drive0,cache=writeback
-device virtio-blk,drive=drive0,bootindex=0 -boot once=n -no-reboot
-cdrom /home/peter.maydell/.cache/qemu-vm/download/535472578c58eb79f8b3c168a22fa5bcd2c1e6d4
ERROR:root:Log:
ERROR:root:qemu-system-x86_64: -netdev
user,id=vnet,hostfwd=:127.0.0.1:0-:22,tftp=/tmp/tmpXrGR4K,bootfile=/auto_install,tftp-server-name=10.0.2.4,guestfwd=tcp:10.0.2.4:80-cmd:cat
/tmp/tmpXrGR4K/install.conf: Invalid parameter 'tftp-server-name'

ERROR:root:QEMU version >= 2.10 is required
Failed to prepare guest environment

The host is an Ubuntu 18.04.1, with QEMU version
2.11.1(Debian 1:2.11+dfsg-1ubuntu7.8), so that should
be good enough for a ">= 2.10" requirement.
I notice that our qapi/net.json says tftp-server-name is
"Since 3.1", though, so maybe the error message is wrong.

I don't really want to have to build and maintain a non-distro
QEMU binary for running these VM tests if we can avoid it.

thanks
-- PMM
