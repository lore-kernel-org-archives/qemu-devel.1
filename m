Received: from eggs.gnu.org ([2001:4830:134:3::10]:56287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ebeyX-0005qz-2e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 23:05:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ebeyS-0002En-Qo
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 23:05:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ebeyS-0002DU-Kh
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 23:05:16 -0500
Date: Wed, 17 Jan 2018 12:05:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180117040511.GB11804@xz-mi>
References: <1516099892-34247-1-git-send-email-wei.w.wang@intel.com>
	<20180116121931.GC7031@xz-mi> <5A5EA1A3.2030801@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5A5EA1A3.2030801@intel.com>
Subject: Re: [Qemu-devel] [PATCH v1] migration: use s->threshold_size inside
 migration_update_counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

On Wed, Jan 17, 2018 at 09:06:43AM +0800, Wei Wang wrote:
> On 01/16/2018 08:19 PM, Peter Xu wrote:
> > On Tue, Jan 16, 2018 at 06:51:32PM +0800, Wei Wang wrote:
> > > The threshold size is changed to be recorded in s->threshold_size by
> > > commit b15df1ae5063c7c181f8f068f9eba7661b3b5e1.
> > > 
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > Could you help confirm the commit ID?  Since what I see is
> > b15df1ae50.  Otherwise:
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > And I'd prefer add:
> > 
> > Fixes: b15df1ae50 ("migration: cleanup stats update into function")
> > 
> > Thanks for the patch!
> > 
> 
> Sure. b15df1ae50 is shortcut and works too. Agree with your change.

Ouch.  I wasn't taking about shortcut or not... I must have pasted a
wrong commit ID of yours. Please forget that.  :)

-- 
Peter Xu
