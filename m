Received: from eggs.gnu.org ([209.51.188.92]:46877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <divyavipin.hyd@gmail.com>) id 1hGDOa-0003ne-BB
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <divyavipin.hyd@gmail.com>) id 1hGDOY-0004Lm-N9
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:00:24 -0400
Received: from mail-it1-x129.google.com ([2607:f8b0:4864:20::129]:40492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <divyavipin.hyd@gmail.com>)
	id 1hGDOX-0004Ji-87
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:00:22 -0400
Received: by mail-it1-x129.google.com with SMTP id k64so6462784itb.5
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 19:00:20 -0700 (PDT)
MIME-Version: 1.0
From: Divya Vipin <divyavipin.hyd@gmail.com>
Date: Tue, 16 Apr 2019 07:30:08 +0530
Message-ID: <CAG+jzpqx28OHiAqtc-0qBn2_0G4eX7m_=Fdtf=rLTE+aEsZN2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Programmable BAR registers in PCIe
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

Is there any way to reprogram the BAR register sizes in QEMU? The use case
is that the device is agnostic to the size of memory available in the host.
So after enumeration succeeds the first time, if the device is capable of
knowing that there is more memory provided by the host, can we change the
BAR size in QEMU?

Thanks,
Divya
