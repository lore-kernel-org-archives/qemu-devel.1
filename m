Received: from eggs.gnu.org ([2001:4830:134:3::10]:38652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nitin.gupta981@gmail.com>) id 1eJwAy-0006oF-2T
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nitin.gupta981@gmail.com>) id 1eJwAw-0006h3-V8
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:48:56 -0500
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:33579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nitin.gupta981@gmail.com>)
	id 1eJwAw-0006gq-Pg
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:48:54 -0500
Received: by mail-vk0-x236.google.com with SMTP id q189so583405vke.0
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 22:48:54 -0800 (PST)
MIME-Version: 1.0
From: Nitin Gupta <nitin.gupta981@gmail.com>
Date: Wed, 29 Nov 2017 12:18:53 +0530
Message-ID: <CAB3_1NuFzu0QZjPnrgCoT8NYTthE4RZAYWWvDc=MpkXvqLYFpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] NVME pass through in the guest VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Qemu Team

i am new in qemu and trying for nvme pass through ..
for that i used  below git repo for nvme

https://github.com/famz/qemu/tree/nvme

and trying to launch the VM by below qemu command ..

/usr/local/bin/qemu-system-x86_64 -name sl7.0 -m 1024 -object
memory-backend-file,id=mem,size=1G,mem-path=/dev/hugepages,share=on
-nographic -no-user-config -nodefaults -serial
mon:telnet:localhost:7704,server,nowait -monitor
mon:telnet:localhost:8804,server,nowait -numa node,memdev=mem -drive
file=/home/qemu/qcows,format=qcow2,if=none,id=disk -device
ide-hd,drive=disk,bootindex=0 -drive
file=nvme://0000:d8:00.0,if=none,id=drive0 -device
virtio-blk,drive=drive0,id=virtio0 --enable-kvm

i am getting kernel panic and not proceed further..please help

PS:-  our guest VM version is


Regards
Nitin
