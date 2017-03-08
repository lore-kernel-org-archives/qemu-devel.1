Received: from eggs.gnu.org ([2001:4830:134:3::10]:38105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clfXc-0002sF-SG
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clfXZ-0002Si-Mg
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:38:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1clfXZ-0002SD-Gi
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:38:21 -0500
Date: Wed, 8 Mar 2017 17:38:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170308173814.GA2590@work-vm>
References: <20170307183637.21245-1-dgilbert@redhat.com>
	<20170307183637.21245-2-dgilbert@redhat.com>
	<af15f78f-774f-f657-1554-a086488cc1a9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af15f78f-774f-f657-1554-a086488cc1a9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] RAMBlocks: qemu_ram_is_shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com, pbonzini@redhat.com

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 03/07/2017 07:36 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Provide a helper to say whether a RAMBlock was created as a
> > shared mapping.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  exec.c                    | 5 +++++
> >  include/exec/cpu-common.h | 1 +
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/exec.c b/exec.c
> > index aabb035..c2cc455 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1560,6 +1560,11 @@ const char *qemu_ram_get_idstr(RAMBlock *rb)
> >      return rb->idstr;
> >  }
> > 
> > +bool qemu_ram_is_shared(RAMBlock *rb)
> > +{
> > +    return rb->flags & RAM_SHARED;
> 
> Hm, it appears to me RAM_SHARED is defined conditionally, that's within 
> #if !defined(CONFIG_USER_ONLY)
> #endif
> 
> The function however seems to be defined and using RAM_SHARED
> unconditionally. Either one or the other seems inappropriate to me.

Oops! Thanks for spotting that; I'll go and fix that.

Dave

> Regards,
> Halil
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
