Received: from eggs.gnu.org ([2001:4830:134:3::10]:34280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dCrB0-000648-H7
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dCrAx-0004qP-CM
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:31:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:13419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dCrAx-0004pd-4O
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:31:23 -0400
Date: Tue, 23 May 2017 01:31:13 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20170522173113.GA914@yangzhon-Virtual>
References: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
	<afc2d6a0-cefa-9609-d781-5e69d372a7bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc2d6a0-cefa-9609-d781-5e69d372a7bd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v0 0/6] move the tcg files into tcg
 directory.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: pbonzini@redhat.com, anthony.xu@intel.com, qemu-devel@nongnu.org

O Fri, May 19, 2017 at 05:14:19PM -0500, Eric Blake wrote:
> On 05/19/2017 02:30 AM, Yang Zhong wrote:
> > Move the tcg relative files into tcg directory, which will make
> > the code more clean in qemu.
> 
> Titling a patch series v0 is a bit unusual (typically, the first version
> is untitled, and the second version is titled v2; 'git send-email -v2'
> can help).  But since 0 is less than 1 or 2, I don't think it breaks any
> tools if you use that as your explicit title for a first submission,
> even if you have to respin.
> 
> > 
> > Yang Zhong (6):
> >   move tcg relative files into tcg directory
> >   move tcg relative files into tcg directory
> >   move tcg header file
> >   move tcg relative files into tcg directory
> >   move tcg relative files into tcg directory
> 
> None of your patches match the usual "topic: Short description" of other
> patches.  Furthermore, having identical titles on 4 out of 6 distinct
> patches is a nightmare for downstream backporters (which "move tcg
> relative files into tcg directory" do I have to backport to fix the bug,
> again?).  I highly suggest that every patch you submit have enough
> details in the subject line that the subject is distinct (we don't
> always succeed, but it's usually quite easy to avoid duplicates).
> 
> So, as an example, I might title a patch:
> 
> "tcg: Move tcg-runtime.c to tcg/ subdirectory"
>
Thanks for your comments, and i will send v2 patchset to commnunity accroding to your suggestions.
Please also help review my tcg accelator patchset,many thanks! 

> >   change tcg relative file's compile definition
> > 
> >  Makefile.objs                                | 1 +
> >  Makefile.target                              | 8 ++------
> >  tcg/Makefile.objs                            | 2 ++
> >  tcg-runtime.c => tcg/tcg-runtime.c           | 0
> >  tci.c => tcg/tci.c                           | 0
> >  tcg/trace-events                             | 6 ++++++
> >  translate-all.c => tcg/translate-all.c       | 2 +-
> >  translate-all.h => tcg/translate-all.h       | 0
> >  translate-common.c => tcg/translate-common.c | 0
> >  trace-events                                 | 3 ---
> 
> Thankfully, you've got git rename detection turned on, which makes for
> much nicer reviews.
> 
> >  10 files changed, 12 insertions(+), 10 deletions(-)
> >  create mode 100644 tcg/Makefile.objs
> >  rename tcg-runtime.c => tcg/tcg-runtime.c (100%)
> >  rename tci.c => tcg/tci.c (100%)
> >  create mode 100644 tcg/trace-events
> >  rename translate-all.c => tcg/translate-all.c (99%)
> >  rename translate-all.h => tcg/translate-all.h (100%)
> >  rename translate-common.c => tcg/translate-common.c (100%)
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
