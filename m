Received: from eggs.gnu.org ([2001:4830:134:3::10]:55141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fzm6k-0000E3-VF
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fzlwP-0005ZJ-N4
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 12:55:06 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:34656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fzlwP-0005YW-DZ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 12:55:05 -0400
Received: by mail-qt0-x22b.google.com with SMTP id m13-v6so29054461qth.1
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 09:55:04 -0700 (PDT)
MIME-Version: 1.0
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 12 Sep 2018 00:54:25 +0800
Message-ID: <CAKXe6SKtGLjDgh0thEemmoodtPZGKOcepbsJ6m76xhznuP3=VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [Question] Question about ACPI table in qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Laszlo Ersek <lersek@redhat.com>, kevin@koconnor.net
Cc: Qemu Developers <qemu-devel@nongnu.org>

Hi all,

I noticed that both qemu and seabios create the ACPI table.
Once I think he bios' ACPI table will overwrite the qemu's if seabios
compiled with CONFIG_ACPI.

But after I read this -->
https://lists.gnu.org/archive/html/qemu-devel/2013-02/msg04555.html

There say:

"just have QEMU pass the tables to SeaBIOS for it to copy
>>> into memory like it does on CSM, coreboot, and Xen"

So where does this 'copy' happens? or is there something others I missed?

Thanks,
Li Qiang
