Received: from eggs.gnu.org ([2001:4830:134:3::10]:53976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eSBRS-0006Ff-N3
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 19:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eSBRR-0005JI-Ux
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 19:44:02 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171222014229-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
	<20171221223704-mutt-send-email-mst@kernel.org>
	<CAFEAcA8-Pe4gVJcKnGXAwia8Y4FD=3r=E-EZuqcX68UZeLoXLg@mail.gmail.com>
	<20171222014229-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Thu, 21 Dec 2017 21:44:00 -0300
Message-ID: <CAAdtpL6Kg_Hx5bgbRNTXcD_+ymzM9X6ziC5XM-Oi27O1rxvKjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, "open list:Block layer core" <qemu-block@nongnu.org>

>> > Done and pushed - I dropped the conflicting patch.
>>
>> Have you also dropped the other one Philippe says depends on it?

Now than I could take time to check, dropping this single patch was
correct and inoffensive, since conflicting patch from Mao Zhongyi is
doing exactly the same change (e01d6a415be).

But better safe than sorry :) I'll resend the "remove obsolete
PCIDevice->init()" patch later to you Michael since it makes more sens
it enters thru the PCI tree than the Block tree.

Sorry again for any trouble caused,

Phil.
