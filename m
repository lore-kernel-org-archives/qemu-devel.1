Received: from eggs.gnu.org ([2001:4830:134:3::10]:50425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSlBT-0004GD-Ex
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSlBS-0000h7-IL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:21:39 -0400
Date: Wed, 5 Jul 2017 22:21:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170705142124.GA13548@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-4-eblake@redhat.com>
	<20170704070643.GB10298@lemon.lan>
	<6aafcf61-7923-23c1-496d-6f2c195149d1@redhat.com>
	<20170705120725.GF29382@lemon.lan>
	<aed7bd2b-b923-4fb9-8f13-2a996d8e4b4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aed7bd2b-b923-4fb9-8f13-2a996d8e4b4e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/15] block: Add flag to avoid wasted
 work in bdrv_is_allocated()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

On Wed, 07/05 09:01, Eric Blake wrote:
> On 07/05/2017 07:07 AM, Fam Zheng wrote:
> >>>
> >>> Sorry for bikeshedding.
> >>
> >> Not a problem, I also had some double-takes in writing my own code
> >> trying to remember which way I wanted the 'allocation' boolean to be
> >> set, so coming up with a more intuitive name/default state in order to
> >> help legibility is worth it.  Do any of my above suggestions sound better?
> >>
> > 
> > I'd vote for "mapping" because it has a close connection with offset (as in
> > BDRV_BLOCK_OFFSET_VALID).
> > 
> > Or simply call it "offset" and if false, never return BDRV_BLOCK_OFFSET_VALID.
> 
> Well, there ARE drivers that WANT to return BDRV_BLOCK_OFFSET_VALID
> regardless of the state of the boolean (namely, any driver that also
> returns BDRV_BLOCK_RAW, to hint that this is a passthrough and the query
> should be repeated at the next BDS in the chain).  So stating that
> 'offset' is false MUST preclude BDRV_BLOCK_OFFSET_VALID is a bit too
> strong, but I can probably come up with appropriate wording that meets
> in the middle ground (if 'offset' is true, then make all efforts to
> include BDRV_BLOCK_OFFSET_VALID in the return if that is possible; if it
> is false, then omitting the flag in order to get a larger pnum is
> acceptable)).

Yes you are totally right, I thought that too after replied.

Fam
