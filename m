Received: from eggs.gnu.org ([2001:4830:134:3::10]:60348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cnl6T-00064I-6A
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cnl6Q-0003lE-3h
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:59:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cnl6P-0003l1-Td
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:58:58 -0400
Date: Tue, 14 Mar 2017 19:58:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170314115835.GD12964@pxdev.xzpeter.org>
References: <1489345956-29167-1-git-send-email-mst@redhat.com>
	<20170313030201.GH17299@pxdev.xzpeter.org>
	<c8991a52-3cb5-b16a-6979-36c46d197aa8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8991a52-3cb5-b16a-6979-36c46d197aa8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] memory: use 128 bit in info mtree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Tue, Mar 14, 2017 at 11:26:19AM +0100, Paolo Bonzini wrote:
> 
> 
> On 13/03/2017 04:02, Peter Xu wrote:
> > On Sun, Mar 12, 2017 at 09:12:43PM +0200, Michael S. Tsirkin wrote:
> >> info mtree is doing 64 bit math to figure out
> >> addresses from offsets, this does not work ncorrectly
> >> incase of overflow.
> >>
> >> Overflow usually indicates a guest bug, so this is unusual
> >> but reporting correct addresses makes it easier to discover
> >> what is going on.
> > 
> > A tiny issue would be that we will always dump 128 bits even if
> > nothing went wrong. IMHO That's slightly awkward. Not sure whether
> > that will confuse people since they should be thinking why we need
> > that on 64bit systems...
> > 
> > Do you like below one instead? It'll keep the old interface, but just
> > warn user explicity when something wrong happens, and it's much easier
> > and obvious imho (along with a tiny cleanup):
> > 
> > (the code is not tested even for compile)
> 
> Looks good, can you submit it formally?

Sure! Will do.

-- peterx
