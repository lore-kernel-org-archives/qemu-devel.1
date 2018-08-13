Received: from eggs.gnu.org ([2001:4830:134:3::10]:49923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fp1xC-0007jI-GW
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fp1xB-000760-G1
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:47:30 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:40427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fp1xB-00075u-8u
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:47:29 -0400
Received: by mail-qt0-x22f.google.com with SMTP id h4-v6so15871849qtj.7
	for <qemu-devel@nongnu.org>; Sun, 12 Aug 2018 18:47:29 -0700 (PDT)
MIME-Version: 1.0
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 13 Aug 2018 09:46:48 +0800
Message-ID: <CAKXe6S+OzWE92HJW-wiR3ynJmak_F556qrg5Kpn6goPn3LYDhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Question about dirty page statistics for live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, liqiang02@corp.netease.com

Hello Dave, Juan and all,

It is useful to get the dirty page rates in guest to evaluate the guest
loads
so that we can make a decide to live migrate it or not. So I think we can
add a on-demand qmp for showing the dirty page rates.

I found someone has done this work in here:
-->https://github.com/grivon/yabusame-qemu-dpt
and here:
https://github.com/btrplace/qemu-patch

But seems not go to the upstream.

I want to know your opinions about adding this qmp.

Thanks,
Li Qiang
