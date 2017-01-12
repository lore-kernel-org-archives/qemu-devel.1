Received: from eggs.gnu.org ([2001:4830:134:3::10]:53274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRYK8-0000us-Ln
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 00:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRYK5-0001uX-KR
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 00:53:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRYK5-0001uQ-EY
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 00:53:17 -0500
Date: Thu, 12 Jan 2017 13:53:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170112055310.GL4450@pxdev.xzpeter.org>
References: <1482307137-5106-1-git-send-email-peterx@redhat.com>
	<1482307137-5106-3-git-send-email-peterx@redhat.com>
	<9c2b7dcd-c3dd-054a-cf4f-2eaaec084cf4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c2b7dcd-c3dd-054a-cf4f-2eaaec084cf4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] memory: hmp: dump flat view for
 'info mtree'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com

On Wed, Jan 11, 2017 at 06:13:11PM +0100, Paolo Bonzini wrote:
> 
> 
> On 21/12/2016 08:58, Peter Xu wrote:
> > Dumping flat view will be useful to debug the memory rendering logic,
> > also it'll be much easier with it to know what memory region is handling
> > what address range.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> This is useful, but dumping both makes the output very long.  What about
> adding a -f option to "info mtree"?

Sure. :)

After I confirm how I should improve on the first patch, I'll cook
another version for the series with "-f".

Thanks,

-- peterx
