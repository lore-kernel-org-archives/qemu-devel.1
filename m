Received: from eggs.gnu.org ([2001:4830:134:3::10]:59670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cZPck-0000rU-IR
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cZPci-0001ZC-NA
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:13:02 -0500
Date: Fri, 3 Feb 2017 00:12:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170203000618-mutt-send-email-mst@kernel.org>
References: <20170202195601.11286-1-sw@weilnetz.de>
	<bdfbc0e6-e630-a1ac-5132-24b6a2dd6122@redhat.com>
	<a5309467-337b-2827-489d-2abbce8356e4@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5309467-337b-2827-489d-2abbce8356e4@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH] tci: Remove invalid assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On Thu, Feb 02, 2017 at 09:10:26PM +0100, Stefan Weil wrote:
> Am 02.02.2017 um 21:00 schrieb Eric Blake:
> > On 02/02/2017 01:56 PM, Stefan Weil wrote:
> > > tb_jmp_insn_offset and tb_jmp_reset_offset are pointers
> > > and cannot be used with ARRAY_SIZE.
> > > 
> > > Signed-off-by: Stefan Weil <sw@weilnetz.de>
> > > ---
> > >  tcg/tci/tcg-target.inc.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > 
> > mst posted an alternative patch:
> > https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00551.html
> 
> 
> Yes, I noticed that, too. It's not obvious that this new
> assertion will be correct, and none of the other targets
> has that kind of assertion. Only two targets use an
> assertion which detects NULL pointers, but NULL pointers
> will result in an abort anyway.
> 
> Do you think that there are reasons why TCI should use
> the assertion suggested by Michael?
> 
> Stefan

You know what this code does and I don't, not really.
I just did a monkey patch guessing at what was intended
(value is used as an array index, so we do a bounds check).

I sent the patch before I saw yours simply to fix the build in a way
that's as unintrusive as possible: args[0] seemed to come from guest so
I thought it might be prudent to do a bounds check.

So feel free to ignore mine. Here's an ack for yours

Acked-by: Michael S. Tsirkin <mst@redhat.com>


-- 
MST
