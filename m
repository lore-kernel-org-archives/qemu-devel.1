Received: from eggs.gnu.org ([2001:4830:134:3::10]:45591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1eq5AC-000371-BC
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 17:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1eq5A9-000388-88
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 17:53:00 -0500
Received: from mx.cs.uchicago.edu ([128.135.164.214]:53682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <huaicheng@cs.uchicago.edu>)
	id 1eq5A9-00037m-0O
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 17:52:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx.cs.uchicago.edu (Postfix) with ESMTP id 149DC60847
	for <qemu-devel@nongnu.org>; Sun, 25 Feb 2018 16:52:56 -0600 (CST)
Received: from mx.cs.uchicago.edu ([127.0.0.1])
	by localhost (mx.cs.uchicago.edu [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5d33mGydVmoc for <qemu-devel@nongnu.org>;
	Sun, 25 Feb 2018 16:52:55 -0600 (CST)
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com
	[209.85.217.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.cs.uchicago.edu (Postfix) with ESMTPSA id 347455FE6E
	for <qemu-devel@nongnu.org>; Sun, 25 Feb 2018 16:52:55 -0600 (CST)
Received: by mail-ua0-f178.google.com with SMTP id m43so9349762uah.1
	for <qemu-devel@nongnu.org>; Sun, 25 Feb 2018 14:52:55 -0800 (PST)
MIME-Version: 1.0
From: Huaicheng Li <huaicheng@cs.uchicago.edu>
Date: Sun, 25 Feb 2018 16:52:14 -0600
Message-ID: <CANr0WEcfzA7aibMaGeKC2RVr=s2g0z4-R6ZaSjKtRFQiSu4XLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU GSoC 2018 Project Idea (Apply polling to QEMU
 NVMe)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi all,

The project would be about utilizing shadow doorbell buffer features in
NVMe 1.3 to enable QEMU side polling for virtualized NVMe device, thus
achieving comparable performance as in virtio-dataplane.

**Why not virtio?**
The reason is many industrial/academic researchers uses QEMU NVMe as a
performance platform for research/product prototyping. NVMe interface is
better in the rich features it provides than virtio interface. If we can
make QEMU NVMe performance competent with virtio, it will benefit a lot of
communities.

**Doable?**
NVMe spec 1.3 introduces a shadow doorbell buffer which is aimed for
virtual NVMe controller optimizations. QEMU can certainly utilize this
feature to reduce or even eliminate VM-exits triggered by doorbell writes.

I remember there were some discussions back in 2015 about this, but I don't
see it finally done. For this project, I think we can go in three steps:
(1). add the shadow doorbell buffer support into QEMU NVMe emulation, this
will reduce # of VM-exits. (2). replace current timers used by QEMU NVMe
with a separate polling thread, thus we can completely eliminate VM-exits.
(3). Even further, we can adapt the architecture to use one polling thread
for each NVMe queue pair, thus it's possible to provide more performance.
(step 3 can be left for next year if the workload is too much for 3 months).

Actually, I have an initial implementation over step (1)(2) and would like
to work more on it to push it upstream. More information is in this papper,
(Section 3.1 and Figure 2-left),
http://ucare.cs.uchicago.edu/pdf/fast18-femu.pdf

Comments are welcome.

Thanks.

Best,
Huaicheng
