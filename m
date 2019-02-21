Received: from eggs.gnu.org ([209.51.188.92]:46131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwpIq-0002Hn-Uo
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwpIp-00012p-Rq
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:26:20 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:43993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwpIp-00010S-1B
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:26:19 -0500
Received: by mail-ot1-x335.google.com with SMTP id n71so44989889ota.10
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 06:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
	<72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
In-Reply-To: <72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 14:26:06 +0000
Message-ID: <CAFEAcA9_shDqjpqF-k9mvR1N6DY7HmXMPiOpkSFcnGpyC3W7tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Thu, 21 Feb 2019 at 14:20, Auger Eric <eric.auger@redhat.com> wrote:
> My qemu cmd line is:
>
> qemu-system-aarch64 -M virt,gic-version=3 -cpu host -smp 2 -m 4G
> -display none --enable-kvm -serial tcp:localhost:4444,server -qmp
> unix:/home/augere/TEST/QEMU/qmp-sock,server,nowait -device
> virtio-blk-pci,bus=pcie.0,scsi=off,drive=drv0,id=virtio-disk0,bootindex=1,werror=stop,rerror=stop
> -drive
> file=aarch64-vm0-rhel-alt-7.6.qcow2,format=qcow2,if=none,cache=writethrough,id=drv0
> -device virtio-net-pci,bus=pcie.0,netdev=nic0,mac=6a:f5:10:b1:3d:d2
> -netdev
> tap,id=nic0,script=/home/augere/TEST/SCRIPTS/qemu-ifup,downscript=/home/augere/TEST/SCRIPTS/qemu-ifdown
> -bios
> /home/augere/UPSTREAM/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd
> -net none -d guest_errors

Does the bug still occur if you get rid of all the network/disk related
command line options here (hopefully it does, to reduce the size of
the test case) ? Can you provide the QEMU_EFI.fd ?

thanks
-- PMM
