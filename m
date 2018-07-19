Received: from eggs.gnu.org ([2001:4830:134:3::10]:45228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fgBj8-0007k0-Gd
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fgBj5-0003ZO-D2
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:24:26 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fgBj5-0003YZ-5Q
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:24:23 -0400
Received: by mail-pg1-x543.google.com with SMTP id g2-v6so4220632pgs.6
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 09:24:23 -0700 (PDT)
Date: Thu, 19 Jul 2018 09:24:21 -0700
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Message-ID: <20180719162421.GA23996@breakout>
References: <e16f10f5-b113-5ebe-51e9-c379ca34193d@linux.ibm.com>
	<20180717205212.GA9580@breakout>
	<c39e6566-78bb-cfe9-f0df-c6cc6ec2ad29@linux.ibm.com>
	<bdbb9588-a913-c449-415b-34a25fcbde9e@linux.ibm.com>
	<20180718185202.GA24700@breakout>
	<4ea995c1-a218-de30-1fe6-21e8e9af2bd8@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea995c1-a218-de30-1fe6-21e8e9af2bd8@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [BUG?] aio_get_linux_aio: Assertion
 `ctx->linux_aio' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu block <qemu-block@nongnu.org>

Hi Christian,

On 19.07.2018 [08:55:20 +0200], Christian Borntraeger wrote:
> 
> 
> On 07/18/2018 08:52 PM, Nishanth Aravamudan wrote:
> > On 18.07.2018 [11:10:27 -0400], Farhan Ali wrote:
> >>
> >>
> >> On 07/18/2018 09:42 AM, Farhan Ali wrote:

<snip>

> >> I am not too familiar with block device code in QEMU, so not sure if
> >> this is the right fix or if there are some underlying problems.
> > 
> > Oh this is quite embarassing! I only added the bdrv_attach_aio_context
> > callback for the file-backed device. Your fix is definitely corect for
> > host device. Let me make sure there weren't any others missed and I will
> > send out a properly formatted patch. Thank you for the quick testing and
> > turnaround!
> 
> Farhan, can you respin your patch with proper sign-off and patch description?
> Adding qemu-block.

I sent it yesterday, sorry I didn't cc everyone from this e-mail:
http://lists.nongnu.org/archive/html/qemu-block/2018-07/msg00516.html

Thanks,
Nish
