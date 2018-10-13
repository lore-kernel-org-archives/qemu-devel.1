Received: from eggs.gnu.org ([2001:4830:134:3::10]:43460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <za.hristomihaylov@gmail.com>) id 1gBN7u-0005Y0-2p
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <za.hristomihaylov@gmail.com>) id 1gBN7q-0004Qs-CE
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:50:53 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:34924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <za.hristomihaylov@gmail.com>)
	id 1gBN7q-0004QT-4Z
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:50:50 -0400
Received: by mail-ed1-x536.google.com with SMTP id y19-v6so14174790edd.2
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 09:50:49 -0700 (PDT)
Received: from [192.168.0.102] ([46.244.106.30])
	by smtp.gmail.com with ESMTPSA id
	k4-v6sm1008547ejz.67.2018.10.13.09.50.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 13 Oct 2018 09:50:47 -0700 (PDT)
From: Hristo Mihaylov <za.hristomihaylov@gmail.com>
Message-ID: <39e2ed06-0e66-8030-fa4f-91b4c505da09@gmail.com>
Date: Sat, 13 Oct 2018 18:50:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US-large
Subject: [Qemu-devel] Assertion error when installing OpenBSD 6.3 in Linux
 4.8.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,
I'm trying to install OpenBSD 6.3 on Arch Linux.

This is the start script I'm using:

```

#!/bin/sh

qemu-system-x86_64 \

=C2=A0=C2=A0=C2=A0 -enable-kvm \

=C2=A0=C2=A0=C2=A0 -m 2048 \

=C2=A0=C2=A0=C2=A0 -nic user,model=3Dvirtio \

=C2=A0=C2=A0=C2=A0 -drive file=3Dopenbsd63.qcow2,media=3Ddisk,if=3Dvirtio=
 \

=C2=A0=C2=A0=C2=A0 -cdrom openbsd63.iso \

=C2=A0=C2=A0=C2=A0 -display gtk

```

Running ls on image and disk:

-rw-r--r-- 1 asthma asthma 336M Oct 7 07:53 openbsd63.iso

-rw-r--r-- 1 asthma asthma 193K Oct 10 22:00 openbsd63.qcow2


This is the crash output:

qemu-system-x86_64:
/build/qemu/src/qemu-3.0.0/include/exec/memory_ldst_cached.inc.h:85:
address_space_stw_le_cached: Assertion `addr < cache->len && 2 <=3D
cache->len - addr' failed.


Running `uname -a` yields:

Linux dev 4.18.12.a-1-hardened #1 SMP PREEMPT Thu Oct 4 14:02:21 CEST
2018 x86_64 GNU/Linux

And the qemu version is: 3.0.0


Am I doing something wrong or is this a bug?


Regards,

Hristo Mihaylov
