Received: from eggs.gnu.org ([2001:4830:134:3::10]:59490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKfF4-00065Z-VY
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKfF1-0006pb-Ob
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:23:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dKfF1-0006pK-IA
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:23:51 -0400
Date: Tue, 13 Jun 2017 14:23:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170613062344.GE11751@pxdev.xzpeter.org>
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094729eucas1p15097f154039365d5e135f92b72aad1bf@eucas1p1.samsung.com>
	<1496828798-27548-8-git-send-email-a.perevalov@samsung.com>
	<20170613055949.GD11751@pxdev.xzpeter.org>
	<70f69591-8f94-8171-8a6b-684120723e0c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70f69591-8f94-8171-8a6b-684120723e0c@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v8 07/11] migration: add bitmap for copied
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, i.maximets@samsung.com

On Tue, Jun 13, 2017 at 09:10:46AM +0300, Alexey Perevalov wrote:
> On 06/13/2017 08:59 AM, Peter Xu wrote:
> >On Wed, Jun 07, 2017 at 12:46:34PM +0300, Alexey Perevalov wrote:
> >>This patch adds ability to track down already copied
> >>pages, it's necessary for calculation vCPU block time in
> >>postcopy migration feature, maybe for restore after
> >>postcopy migration failure.
> >>Also it's necessary to solve shared memory issue in
> >>postcopy livemigration. Information about copied pages
> >>will be transferred to the software virtual bridge
> >>(e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
> >>already copied pages. fallocate syscall is required for
> >>remmaped shared memory, due to remmaping itself blocks
> >>ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
> >>error (struct page is exists after remmap).
> >>
> >>Bitmap is placed into RAMBlock as another postcopy/precopy
> >>related bitmaps. Helpers are in migration/ram.c, due to
> >>in this file is allowing to work with RAMBlock.
> >>
> >>Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> >Hi, Alexey,
> >
> >Besides all the existing comments, I would suggest you do all the
> >copied_map things in this single patch, so that it'll be easier for
> >others to work upon your work. E.g., move the bit_set() operations
> >here as well (currently it was in followup patches, and looks like
> >that's not enough since we need to capture copied_map even for precopy
> >phase), then this single patch can ideally be separated from the whole
> >series (and then I can work upon it :-).
> >
> >Or, please just let me know if you want me to do this for you. I can
> >post this as a standalone patch, with your s-o-b if you allow.
> 
> Hello Peter,
> I'm working with this patch in another patch series too.
> (it's about QEMU's shared memory and OVS-VSWITCHD,
> vhost-user use case).
> So if you need that I could resend this patch as separate patch.
> And it will be convenient to base both my patch set and you patches
> on top of it.

That'll be great!  Then please post this as standalone patch.

Thanks,

-- 
Peter Xu
