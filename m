Received: from eggs.gnu.org ([2001:4830:134:3::10]:57449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krarun88@gmail.com>) id 1ejLVa-0006qL-OO
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 03:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krarun88@gmail.com>) id 1ejLVW-0006lQ-BR
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 03:55:14 -0500
Received: from mail-it0-x234.google.com ([2607:f8b0:4001:c0b::234]:51637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <krarun88@gmail.com>) id 1ejLVW-0006kg-6o
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 03:55:10 -0500
Received: by mail-it0-x234.google.com with SMTP id p139so1375052itb.1
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 00:55:09 -0800 (PST)
MIME-Version: 1.0
From: Arun raj <krarun88@gmail.com>
Date: Wed, 7 Feb 2018 14:25:08 +0530
Message-ID: <CAEZT4RNYVuFvwyp9VR94HAgVmz-_MFyd0yjEDRP8_iJ=D5XcKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Regarding Network interface on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I'm new to QEMU and using latest QEMU-2.11.50 version. i installed ubuntu
16.04 in QEMU and my host system has 4.4 kernel

following command is i'm using to run the QEMU :

qemu-system-x86_64 -machine q35,kernel_irqchip=split -m 1G -enable-kvm -smp
4 -device intel-iommu,intremap=on,x-buggy-eim=on -cpu
kvm64,-kvm_pv_eoi,-kvm_steal_time,-kvm_asyncpf,-kvmclock,+vmx -drive
file=testing.img,format=raw,id=disk,if=none -device ide-hd,drive=disk
-serial stdio -serial vc -netdev user,id=net -device
e1000e,addr=2.0,netdev=net -device intel-hda,addr=1b.0 -device hda-duplex

But in QEMU i can't able to access the internet and ping also not working.
Is there any additional command is require to solve this issue?


Regards,
Arun
