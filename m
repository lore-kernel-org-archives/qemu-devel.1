Received: from eggs.gnu.org ([2001:4830:134:3::10]:36646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1epAK5-0003xd-1h
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1epAK1-0006nX-Sc
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:11:24 -0500
Date: Fri, 23 Feb 2018 11:11:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180223111118.1acc94be.cohuck@redhat.com>
In-Reply-To: <9caa0a62-e2cf-837b-a037-76cbcb851b0d@de.ibm.com>
References: <20180223095406.18251-1-cohuck@redhat.com>
	<9caa0a62-e2cf-837b-a037-76cbcb851b0d@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x/sclp: remove duplicate
 MAX_AVAIL_SLOTS define
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Fri, 23 Feb 2018 11:02:15 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02/23/2018 10:54 AM, Cornelia Huck wrote:
> > It's already defined in cpu.h (to the same value) and not used in
> > the sclp code.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  include/hw/s390x/sclp.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> > index 476cbf78f2..f9db243484 100644
> > --- a/include/hw/s390x/sclp.h
> > +++ b/include/hw/s390x/sclp.h
> > @@ -35,7 +35,6 @@
> >  #define SCLP_FC_ASSIGN_ATTACH_READ_STOR         0xE00000000000ULL
> >  #define SCLP_STARTING_SUBINCREMENT_ID           0x10001
> >  #define SCLP_INCREMENT_UNIT                     0x10000
> > -#define MAX_AVAIL_SLOTS                         32
> >  #define MAX_STORAGE_INCREMENTS                  1020
> > 
> >  /* CPU hotplug SCLP codes */
> >   
> Do we need this define and s390_get_memslot_count at all after removing
> the hotplug code?
> 

Indeed. Let's kill it with fire :)
