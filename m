Received: from eggs.gnu.org ([2001:4830:134:3::10]:33915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhcwhu@gmail.com>) id 1dqQfJ-0006Fw-Is
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 17:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhcwhu@gmail.com>) id 1dqQfI-0001e4-Q4
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 17:18:17 -0400
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:36030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhcwhu@gmail.com>) id 1dqQfI-0001cL-Hp
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 17:18:16 -0400
Received: by mail-lf0-x235.google.com with SMTP id m199so8111453lfe.3
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 14:18:15 -0700 (PDT)
MIME-Version: 1.0
From: Huaicheng Li <lhcwhu@gmail.com>
Date: Fri, 8 Sep 2017 16:17:32 -0500
Message-ID: <CANr0WEe-r-eXMt2sZuVSVGs5Zk1h+_BhmW30sCptzi2oeZUduQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] irqfd for QEMU NVMe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi all,

I'm writing to ask if it's possible to use irqfd mechanism in QEMU's NVMe
virtual controller implementation. My search results show that back in
2015, there is a discussion on improving QEMU NVMe performance by utilizing
eventfd for guest-to-host notification, thus i guess irqfd should also work
? If so, could you briefly describe how to do that and how much can we save
for the host-to-guest notification path by using irqfd?

Thanks for your time.

Best,
Huaicheng
