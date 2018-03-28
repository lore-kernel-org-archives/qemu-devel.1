Received: from eggs.gnu.org ([2001:4830:134:3::10]:40622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <syjzwjj@gmail.com>) id 1f134u-0007Qz-CM
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <syjzwjj@gmail.com>) id 1f134t-0007oR-2v
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:52:51 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:44885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <syjzwjj@gmail.com>) id 1f134s-0007o0-QD
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:52:51 -0400
Received: by mail-lf0-x22e.google.com with SMTP id g203-v6so1527582lfg.11
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 21:52:50 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5byg546L5L+K5p2w?= <syjzwjj@gmail.com>
Date: Wed, 28 Mar 2018 12:52:48 +0800
Message-ID: <CANo6bw894eLKejh2hxFkgRMQPfc4h1Cs9BeFg10gd0tKc+iNSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] cpu_memory_rw_debug function is too slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello, I found that use cpu_memory_rw_debug in tcg mode when qemu access
guest virtual address is too slow, can I choose to use some other more fast
function ?
