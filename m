Received: from eggs.gnu.org ([2001:4830:134:3::10]:39564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1d2x7I-00056w-RU
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1d2x7E-0004Is-Vu
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:50:40 -0400
Received: from lekensteyn.nl ([178.21.112.251]:36313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter@lekensteyn.nl>) id 1d2x7E-0004Gb-Kn
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:50:36 -0400
Date: Tue, 25 Apr 2017 11:50:27 +0200
From: Peter Wu <peter@lekensteyn.nl>
Message-ID: <20170425095027.GB11840@al>
References: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
	<4ea264eb-128c-569a-264c-8ffa3956dca2@redhat.com>
	<CAC2QTZYq4v+zcYQ3LrkWrYdZYEVwYe1kjpfh30+kKe+p+Z3-vg@mail.gmail.com>
	<b45474c4-e4f6-6509-adcd-31aee92fd62c@redhat.com>
	<CAC2QTZbvyKNFjLhaDn_tWzeF=X2kkNpq=2wws_yBLkhFbiBJBA@mail.gmail.com>
	<CAC2QTZbz1isnu-SKRoe8PcEfzV5Yz5Rf82_7zTXqvEKB7NUJJQ@mail.gmail.com>
	<e91d0cfe-407a-ab3b-ee9a-e32d570668a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e91d0cfe-407a-ab3b-ee9a-e32d570668a4@redhat.com>
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
Cc: Ashijeet Acharya <ashijeetacharya@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Apr 24, 2017 at 05:19:48PM -0400, John Snow wrote:
> 
> 
> On 04/23/2017 05:03 AM, Ashijeet Acharya wrote:
> > Hi,
> > 
> > Great news!
> > I have almost completed this task and the results are looking
> > promising. I have not yet attended to the DMG files having bz2
> > compressed chunks but that should be easy and pretty similar to my
> > approach for zlib compressed files. So, no worries there.
> > 
> > For testing I am first converting the images to raw format and then
> > comparing the resulting image with the one converted using v2.9.0 DMG
> > driver and after battling for 2 days with my code, it finally prints
> > "Images are identical." According to John, that should be pretty
> > conclusive and I completely agree.
> > 
> 
> Yes, comparing a sample.dmg against a raw file generated from the 2.9.0
> qemu-img tool should be reasonably good evidence that you have not
> altered the behavior of the tool.
> 
> > Now, the real thing I wanted to ask was, if someone is aware of a DMG
> > file which has a chunk size above 64 MiB so that I can test those too.
> > If yes, please share the download link with me.
> > Currently I am testing the ones posted by Peter Wu while submitting
> > his DMG work in 2014.
> > Here -> https://lists.nongnu.org/archive/html/qemu-devel/2014-12/msg03606.html
> > 
> 
> Are any of those over 64MB? I assume you're implying that they aren't.
> 
> Maybe Peter knows?...

I don't know DMG with bzip2-compressed chunks over 64M. Looking through
more recent files, there is this log for "Install macOS Sierra
10.12(16A323)-B.dmg" which contains only zlib-compressed or raw data
where the uncompressed size (in the MISH block) is always at most 1MiB:
https://github.com/Lekensteyn/dmg2img/issues/1#issuecomment-273662984

In an Xcode_7.2.dmg file, the situation was similar, only zlib or raw
and also with a max uncompressed size of 1MiB (actually, an exact size
of 1MiB in both cases based on "sectorCount").

Perhaps bzip2-compressed chunks are not so common for larger disk images
since zlib is faster.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
