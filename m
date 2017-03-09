Received: from eggs.gnu.org ([2001:4830:134:3::10]:48083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikofeng@connect.hku.hk>) id 1cltlx-0002N5-N0
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikofeng@connect.hku.hk>) id 1cltlw-00048b-5p
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:50:09 -0500
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:36487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nikofeng@connect.hku.hk>)
	id 1cltlw-000488-0u
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:50:08 -0500
Received: by mail-qk0-x22b.google.com with SMTP id 1so108253600qkl.3
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 00:50:07 -0800 (PST)
MIME-Version: 1.0
From: "FENG, Jiasheng" <nikofeng@connect.hku.hk>
Date: Thu, 9 Mar 2017 16:49:26 +0800
Message-ID: <CAGd9JPiCvSpZ6wGT-Fci+f7odP4t9SHUwSw3vqOMDVWdyJeR3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] QEMU MicroCheckpointing Pause & Resume Latency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Heming Cui <heming@cs.hku.hk>, Wang Cheng <wangch.will@gmail.com>, "CHEN, XUSHENG" <chenxus@connect.hku.hk>, "YE,
	Chen" <u3534845@connect.hku.hk>

Dear QEMU Development Team,


It is my honor to contact with you.



I am a postgraduate student from University of Hong Kong. Currently I am
working on a project related to QEMU MicroCheckpointing and I have
encountered a performance issue during checkpoint pause & resume.



Please kindly refer to migration/checkpoint.c file, in function
capture_checkpoint, I proceeded a test to see the time consumption between
vm_stop_force_state and vm_start. I found out that even if the system is
idle, there are still 12-20ms latency recorded ( mem=3D2G, vCPU=3D4 ).
Moreover, latency will be increased while more cpus equipped by my virtual
machine. I have done some research on that and I realized that it is
related to the Memory Barrier in KVM kernel. Each cpu will proceed a
smp_wmb() request during pause & resume and it takes about  3-5ms to finish
the request ( mem=3D2G, vCPU=3D4 ).



Therefore, I would like to ask 3 questions regarding on the above issue:


1. What is your consideration with calling smp_wmb() in checkpoint period;

2. Is it any other solution to minimize the latency to improve the
performance in checkpoint period;

3. Is smp_wmb() able to be safely disabled during the checkpoint period



Really appreciate your help with my problems and hope to receive your
feedback soon.



Thanks again for your contribution to QEMU and it is such a masterpiece.



Thanks and best regards,

Niko Jiasheng Feng

University of Hong Kong

--=20
*Niko Jiasheng *
*Feng **Computer Science(General Stream), Faculty of Engineering, The
University of Hong Kong*
Contact:  =EF=BC=88852=EF=BC=8997908620
Address: Pokfulam Road, The University of Hong Kong
Email:      nikofeng@hku.hk / niko_jiasheng@163.com
