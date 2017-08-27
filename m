Received: from eggs.gnu.org ([2001:4830:134:3::10]:53622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dm58m-0000uZ-4j
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 17:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dm58h-0003QP-3K
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 17:30:44 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dm58g-0003Pu-Nx
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 17:30:38 -0400
Received: by mail-wm0-f54.google.com with SMTP id b82so12806814wmd.1
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 14:30:37 -0700 (PDT)
Received: from fiorina (ip-94-112-73-67.net.upcbroadband.cz. [94.112.73.67])
	by smtp.gmail.com with ESMTPSA id
	x45sm9404335wrb.46.2017.08.27.14.30.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 27 Aug 2017 14:30:35 -0700 (PDT)
Date: Sun, 27 Aug 2017 23:30:33 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170827233033.7afa49b9@fiorina>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC] Buffers/caches in VirtIO Balloon driver stats
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

We'd like to include information about reclaimable memory into the
statistics in VirtiO Balloon driver. Namely, we'd like to include
counters for bufferes and caches of Linux kernel. The patch itself is
pretty trivial -- no problem there. But before we do that I'd like to
get some input from the QEMU community.

1) Is there any reason not to have the stats there?

2) Considering the balloon device is multiplatform (Linux, BSD,
Windows), is there a problem with including buffers/caches? These seem
to be specific to the Linux virtual memory subsystem. Of course, other
OSes could just report zeros. Are there some internal stats on those
OSes that could be filled in? I don't now if such or similar statistic
are available on BSD. On Windows only SystemCache stat looks like
something relevant. Anyone familiar with those OSes has any suggestions?

    Tomas

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
