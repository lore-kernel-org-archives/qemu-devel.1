Received: from eggs.gnu.org ([2001:4830:134:3::10]:56419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGLCk-0000VW-TZ
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGLCh-0001E7-Ox
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:39:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cGLCh-0001Dz-JW
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:39:19 -0500
Date: Mon, 12 Dec 2016 15:39:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161212073915.GC3725@lemon>
References: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
	<20161212033512.GA3725@lemon>
	<908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
Subject: Re: [Qemu-devel] experience with SDL2, event loop & main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: QEMU Developer <Qemu-devel@nongnu.org>

On Mon, 12/12 09:18, Liviu Ionescu wrote:
> 
> > On 12 Dec 2016, at 05:35, Fam Zheng <famz@redhat.com> wrote:
> > 
> > Isn't it possible to notify the main thread with an EventNotifier and process
> > the deferred events in its handler?
> 
> ideally, the SDL main loop might be re-implemented asynchronously, for example
> using a pipe to pass the events, and in this case the SDL would be just a
> regular client of the main I/O loop.
> 
> any idea how difficult would be to push any changes to SDL?

Not sure I understand this question, could you be more specific?

Fam
