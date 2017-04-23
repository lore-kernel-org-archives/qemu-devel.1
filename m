Received: from eggs.gnu.org ([2001:4830:134:3::10]:43511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d2DQD-0008Az-TQ
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 05:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d2DQC-0001ix-Vj
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 05:03:09 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:35347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1d2DQC-0001ij-QR
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 05:03:08 -0400
Received: by mail-oi0-x22e.google.com with SMTP id j201so136135999oih.2
	for <qemu-devel@nongnu.org>; Sun, 23 Apr 2017 02:03:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAC2QTZbvyKNFjLhaDn_tWzeF=X2kkNpq=2wws_yBLkhFbiBJBA@mail.gmail.com>
References: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
	<4ea264eb-128c-569a-264c-8ffa3956dca2@redhat.com>
	<CAC2QTZYq4v+zcYQ3LrkWrYdZYEVwYe1kjpfh30+kKe+p+Z3-vg@mail.gmail.com>
	<b45474c4-e4f6-6509-adcd-31aee92fd62c@redhat.com>
	<CAC2QTZbvyKNFjLhaDn_tWzeF=X2kkNpq=2wws_yBLkhFbiBJBA@mail.gmail.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sun, 23 Apr 2017 14:33:07 +0530
Message-ID: <CAC2QTZbz1isnu-SKRoe8PcEfzV5Yz5Rf82_7zTXqvEKB7NUJJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] DMG chunk size independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi,

Great news!
I have almost completed this task and the results are looking
promising. I have not yet attended to the DMG files having bz2
compressed chunks but that should be easy and pretty similar to my
approach for zlib compressed files. So, no worries there.

For testing I am first converting the images to raw format and then
comparing the resulting image with the one converted using v2.9.0 DMG
driver and after battling for 2 days with my code, it finally prints
"Images are identical." According to John, that should be pretty
conclusive and I completely agree.

Now, the real thing I wanted to ask was, if someone is aware of a DMG
file which has a chunk size above 64 MiB so that I can test those too.
If yes, please share the download link with me.
Currently I am testing the ones posted by Peter Wu while submitting
his DMG work in 2014.
Here -> https://lists.nongnu.org/archive/html/qemu-devel/2014-12/msg03606.html

Expect v1 soon...

Ashijeet
