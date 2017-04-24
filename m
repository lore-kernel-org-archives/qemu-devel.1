Received: from eggs.gnu.org ([2001:4830:134:3::10]:50967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d2lOp-0007SS-0E
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 17:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d2lOl-000204-Mg
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 17:19:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1d2lOl-0001yu-GI
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 17:19:55 -0400
References: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
	<4ea264eb-128c-569a-264c-8ffa3956dca2@redhat.com>
	<CAC2QTZYq4v+zcYQ3LrkWrYdZYEVwYe1kjpfh30+kKe+p+Z3-vg@mail.gmail.com>
	<b45474c4-e4f6-6509-adcd-31aee92fd62c@redhat.com>
	<CAC2QTZbvyKNFjLhaDn_tWzeF=X2kkNpq=2wws_yBLkhFbiBJBA@mail.gmail.com>
	<CAC2QTZbz1isnu-SKRoe8PcEfzV5Yz5Rf82_7zTXqvEKB7NUJJQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e91d0cfe-407a-ab3b-ee9a-e32d570668a4@redhat.com>
Date: Mon, 24 Apr 2017 17:19:48 -0400
MIME-Version: 1.0
In-Reply-To: <CAC2QTZbz1isnu-SKRoe8PcEfzV5Yz5Rf82_7zTXqvEKB7NUJJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] DMG chunk size independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Wu <peter@lekensteyn.nl>



On 04/23/2017 05:03 AM, Ashijeet Acharya wrote:
> Hi,
> 
> Great news!
> I have almost completed this task and the results are looking
> promising. I have not yet attended to the DMG files having bz2
> compressed chunks but that should be easy and pretty similar to my
> approach for zlib compressed files. So, no worries there.
> 
> For testing I am first converting the images to raw format and then
> comparing the resulting image with the one converted using v2.9.0 DMG
> driver and after battling for 2 days with my code, it finally prints
> "Images are identical." According to John, that should be pretty
> conclusive and I completely agree.
> 

Yes, comparing a sample.dmg against a raw file generated from the 2.9.0
qemu-img tool should be reasonably good evidence that you have not
altered the behavior of the tool.

> Now, the real thing I wanted to ask was, if someone is aware of a DMG
> file which has a chunk size above 64 MiB so that I can test those too.
> If yes, please share the download link with me.
> Currently I am testing the ones posted by Peter Wu while submitting
> his DMG work in 2014.
> Here -> https://lists.nongnu.org/archive/html/qemu-devel/2014-12/msg03606.html
> 

Are any of those over 64MB? I assume you're implying that they aren't.

Maybe Peter knows?...

> Expect v1 soon...
> 
> Ashijeet
> 
