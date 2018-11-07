Received: from eggs.gnu.org ([2001:4830:134:3::10]:44253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gKQAE-0000VI-FH
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gKQAB-00021B-0l
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:54:42 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:38768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gKQA9-0001we-86
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:54:38 -0500
Received: by mail-ot1-x334.google.com with SMTP id f24so15172543otl.5
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 07:54:32 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Wed,  7 Nov 2018 09:54:02 -0600
Message-Id: <20181107155405.24013-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 0/3] Fix/add vmstate handling in some I2C code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

These changes allow SMBus access while doing a state transfer.
Seems like a good idea to me in general.

I have these queued for the SMBus IPMI driver work, of course.
