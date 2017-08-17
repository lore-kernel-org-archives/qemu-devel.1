Received: from eggs.gnu.org ([2001:4830:134:3::10]:45812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diGuZ-0000Dk-Pi
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diGuW-0004Sz-KR
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:16:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1diGuW-0004QC-Dp
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:16:16 -0400
Date: Thu, 17 Aug 2017 11:16:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170817111609.4beac270.cohuck@redhat.com>
In-Reply-To: <96918c60-9133-064a-d289-d13562a5f551@redhat.com>
References: <1502861458-30270-1-git-send-email-thuth@redhat.com>
	<96918c60-9133-064a-d289-d13562a5f551@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/ipl: The s390-ipl device is not
 hot-pluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 17 Aug 2017 11:05:35 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 16.08.2017 07:30, Thomas Huth wrote:
> > The s390-ipl device can not be created by the user, since it is meant only
> > to  be instantiated once internally to load the ROMs and kernel. If the user
> > tries to do a "device_add s390-ipl" via the monitor later, QEMU aborts with
> > a "ROM images must be loaded at startup" error message.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  hw/s390x/ipl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index cc36003..0d06fc1 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -442,6 +442,8 @@ static void s390_ipl_class_init(ObjectClass *klass, void *data)
> >      dc->reset = s390_ipl_reset;
> >      dc->vmsd = &vmstate_ipl;
> >      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +    /* Reason: Loads the ROMs and thus can only be used one time - internally */
> > +    dc->user_creatable = false;
> >  }
> >  
> >  static const TypeInfo s390_ipl_info = {
> >   
> 
> Late but still
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Not too late for me to add the tag :)

Thanks!
