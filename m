Received: from eggs.gnu.org ([2001:4830:134:3::10]:38620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqbyA-0006WN-VU
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqby9-0001dR-46
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:27:02 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:36123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqby8-0001co-MB
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:27:00 -0400
Received: by mail-oi0-x235.google.com with SMTP id n21-v6so13182639oig.3
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 03:27:00 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 11:26:39 +0100
Message-ID: <CAFEAcA-bvTeWRjBbNder0Ewf_27ksefr8djsWicEC2eMjyWSxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] vm-tests images disks filling up?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

I just ran into a build failure using the tests/vm/ BSD build tests,
because the NetBSD build image's disk filled up.

Looking more closely there seemed to be 9 stale build trees in
the VM's /var/tmp/qemu-test.* , which is why the disk was full
(they'd used up about 18GB between them).

The other VMs (freebsd, openbsd) also had the same problem of
/var/tmp gradually filling with stale trees, they just hadn't
quite run out of space yet...

What's the process for managing the disk space on these images?
How are stale or completed build trees deleted ?

thanks
-- PMM
