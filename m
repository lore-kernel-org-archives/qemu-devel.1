Received: from eggs.gnu.org ([2001:4830:134:3::10]:50145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jenia.ivlev@gmail.com>) id 1dBXtW-00086P-4j
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jenia.ivlev@gmail.com>) id 1dBXtV-000741-CZ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:43:58 -0400
Received: from mail-yw0-x22a.google.com ([2607:f8b0:4002:c05::22a]:33393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jenia.ivlev@gmail.com>)
	id 1dBXtV-00072n-5x
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:43:57 -0400
Received: by mail-yw0-x22a.google.com with SMTP id p73so18814736ywp.0
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 19:43:56 -0700 (PDT)
MIME-Version: 1.0
From: jenia mtl <jenia.ivlev@gmail.com>
Date: Thu, 18 May 2017 22:43:55 -0400
Message-ID: <CAJO5WKsHRbOpeSB2BrUhBRuB=xDUbXDm4n+XhO2v2phV+1Sgiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] specify memory in QEMU with Virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello.


How do I specify how much graphics memory the Windows client should have in
QEMU. I have successfully installed Virtio and can launch the VM (Windows)
with it. This doubles the memory form 8MB to 16MB. But I need 512. How can
I set that?

I launch it like this (this command can be used to installed the OS and
also to launch it. If you don't want to install, Just don't enter the
Windows Install Interface, let it go to booting the OS)

    qemu-system-x86_64 -enable-kvm -m 4G -soundhw hda -boot order=c -drive
file=image_file,if=virtio -drive file="OS.iso",index=2,media=cdrom -drive
file=/usr/share/virtio/virtio-win.iso,index=3,media=cdrom



Thanks in advance
Jenia
