Received: from eggs.gnu.org ([2001:4830:134:3::10]:34907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eBdRR-00014O-Mr
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eBdRM-0003xw-5O
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:11:37 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:44274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1eBdRM-0003xC-0V
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:11:32 -0500
Received: by mail-ot0-x22a.google.com with SMTP id d36so7846861otf.1
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 01:11:31 -0800 (PST)
MIME-Version: 1.0
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 6 Nov 2017 17:11:30 +0800
Message-ID: <CANRm+CxGAiDBDYrtvxXwsPwt2WjiY_biMCVkvQOyAaQtv5v-UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu core file size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi all,

qemu core dump, max_core="unlimited", dump_guest_core=0, kill -11 pid
to generate a qemu core file, the Rss of qemu itself is ~40MB, the
core file is almost ~40MB in centos 6.x, but ~400MB in cents 7.x, any
idea?

Regards,
Wanpeng Li
