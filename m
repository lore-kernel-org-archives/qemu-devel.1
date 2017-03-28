Received: from eggs.gnu.org ([2001:4830:134:3::10]:60035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1csxSf-0003Si-7a
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1csxSb-0003Zb-5F
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:11:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1csxSa-0003ZF-V8
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:11:21 -0400
Date: Tue, 28 Mar 2017 23:11:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170328231039-mutt-send-email-mst@kernel.org>
References: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
	<bb0868d1-5c56-45e5-8b6c-ee08e77dfeaa@weilnetz.de>
	<fbb1c7da-1c51-8ee5-b94d-62fd17c068e0@redhat.com>
	<DM2PR21MB0060647969F7193B509AE8AF9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
	<c95a9ea9-dce2-d6e9-9328-5deebec63950@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95a9ea9-dce2-d6e9-9328-5deebec63950@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9] virtio: fix vring_align() on
 64-bit windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Mar 28, 2017 at 10:02:10PM +0200, Stefan Weil wrote:
> Am 28.03.2017 um 20:56 schrieb Andrew Baumann:
> > > From: Eric Blake [mailto:eblake@redhat.com]
> > > Sent: Tuesday, 28 March 2017 11:52
> > > 
> > > On 03/28/2017 01:38 PM, Stefan Weil wrote:
> > > > Am 25.03.2017 um 00:19 schrieb Andrew Baumann:
> > > > > long is 32-bits on 64-bit windows, which caused the top half of the
> > > > > address to be truncated; this patch changes it to use the
> > > > > QEMU_ALIGN_UP macro which does not suffer the same problem
> > > > > 
> > > > > Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> > > > > Reviewed-by: Eric Blake <eblake@redhat.com>
> > > > > ---
> > > 
> > > > Eric added "for-2.9" to the subject line of v2, but now it was
> > > > missing again for v3.
> > > > 
> > > > Is this needed for 2.9?
> > > 
> > > Yes, it's a correctness bug that avoids miscompilation on 64-bit targets
> > > where long is 32 bits (which, at the moment, is really just Windows).
> > 
> > I agree, this should be in 2.9. I dropped the tag by accident.
> > 
> > > > I wonder why I never before noticed
> > > > a problem or got a bug report for this issue.
> > > 
> > > Probably because so few people are testing on native Windows, and it
> > > doesn't affect other platforms.
> > 
> > In addition to that, you only notice it on virtio devices mapped above the 32-bit limit...
> > 
> > Andrew
> > 
> 
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> 
> I added this patch to my queue. Peter, do you still accept pull requests
> for 2.9? I'm still waiting for a review of another bug fix for Windows
> (http://patchwork.ozlabs.org/patch/743416/). How long do I have time
> to get bug fixes for Windows into 2.9?
> 
> Of course I would not mind if you pulled this one directly (see
> http://patchwork.ozlabs.org/patch/743410/).
> 
> Stefan

I'm doing a pull request a bit later today - I can pick this one up
if you prefer. If yes, pls send your ack.

-- 
MST
