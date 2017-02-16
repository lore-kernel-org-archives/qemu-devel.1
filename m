Received: from eggs.gnu.org ([2001:4830:134:3::10]:51775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ceUTO-0002z1-N4
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 17:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ceUTN-0001Y6-75
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 17:24:22 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:33048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1ceUTM-0001XB-VT
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 17:24:21 -0500
Received: by mail-it0-x241.google.com with SMTP id e137so6511704itc.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:24:20 -0800 (PST)
MIME-Version: 1.0
From: ashish mittal <ashmit602@gmail.com>
Date: Thu, 16 Feb 2017 14:24:19 -0800
Message-ID: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

Hi,

I am getting the following error with checkpatch.pl

ERROR: externs should be avoided in .c files
#78: FILE: block/vxhs.c:28:
+QemuUUID qemu_uuid __attribute__ ((weak));

Is there any way to get around this, or does it mean that I would have
to add a vxhs.h just for this one entry?

Thanks,
Ashish
