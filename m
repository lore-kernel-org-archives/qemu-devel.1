Received: from eggs.gnu.org ([2001:4830:134:3::10]:57463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d2suD-00085i-MW
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 01:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d2suC-00079j-La
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 01:20:53 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:34188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1d2suC-000798-FV
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 01:20:52 -0400
Received: by mail-oi0-x235.google.com with SMTP id x184so160312967oia.1
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 22:20:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e91d0cfe-407a-ab3b-ee9a-e32d570668a4@redhat.com>
References: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
	<4ea264eb-128c-569a-264c-8ffa3956dca2@redhat.com>
	<CAC2QTZYq4v+zcYQ3LrkWrYdZYEVwYe1kjpfh30+kKe+p+Z3-vg@mail.gmail.com>
	<b45474c4-e4f6-6509-adcd-31aee92fd62c@redhat.com>
	<CAC2QTZbvyKNFjLhaDn_tWzeF=X2kkNpq=2wws_yBLkhFbiBJBA@mail.gmail.com>
	<CAC2QTZbz1isnu-SKRoe8PcEfzV5Yz5Rf82_7zTXqvEKB7NUJJQ@mail.gmail.com>
	<e91d0cfe-407a-ab3b-ee9a-e32d570668a4@redhat.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Tue, 25 Apr 2017 10:50:51 +0530
Message-ID: <CAC2QTZaxvkug1xDadmOhrKCF0XkWWy1OgbTkCpp+ee2oY9ooMw@mail.gmail.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Wu <peter@lekensteyn.nl>

>> For testing I am first converting the images to raw format and then
>> comparing the resulting image with the one converted using v2.9.0 DMG
>> driver and after battling for 2 days with my code, it finally prints
>> "Images are identical." According to John, that should be pretty
>> conclusive and I completely agree.
>>
>
> Yes, comparing a sample.dmg against a raw file generated from the 2.9.0
> qemu-img tool should be reasonably good evidence that you have not
> altered the behavior of the tool.
>
>> Now, the real thing I wanted to ask was, if someone is aware of a DMG
>> file which has a chunk size above 64 MiB so that I can test those too.
>> If yes, please share the download link with me.
>> Currently I am testing the ones posted by Peter Wu while submitting
>> his DMG work in 2014.
>> Here -> https://lists.nongnu.org/archive/html/qemu-devel/2014-12/msg03606.html
>>
>
> Are any of those over 64MB? I assume you're implying that they aren't.

No, they are not. Because none of them crash while converting with
using the qemu-img tool as in 2.9.0(as it has a limitation of 64MiB).

>
> Maybe Peter knows?...

Yes, I contacted him and he has been of great help so far :-)

Ashijeet
