Received: from eggs.gnu.org ([2001:4830:134:3::10]:50659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fmw53-0005NY-Rd
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fmw53-0002dl-3O
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:06:57 -0400
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:45585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1fmw52-0002cX-PO
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:06:57 -0400
Received: by mail-ua0-x22c.google.com with SMTP id k8-v6so14964121uaq.12
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 00:06:56 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Tue, 7 Aug 2018 15:06:55 +0800
Message-ID: <CAB3eZftOpC9tj4SrRKX=s40md+UjSCC-X=+NC89aV=EVs_XbUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How to discard one range which overlap with backing
 file and its children img?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

I have image A & B, and A is backing file of B.

After I mount A to /dev/nbd0 and I write from position 0~999 in nbd0.

Then create B and set A as backing file of B.

I mount B on /dev/nbd1 and I can saw the data from pos:0~999 because A is
B's backing file. That's reasonable.


But I want to discard range 0~500 in B. I expect there's no data in 0~500
after discard and re-mount B next time.

But the data is still in A.

How can I discard range 0~500?
