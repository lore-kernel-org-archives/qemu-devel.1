Received: from eggs.gnu.org ([2001:4830:134:3::10]:43509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehFUB-0001Cd-Hl
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehFU6-00089e-TJ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:05:07 -0500
Date: Thu, 1 Feb 2018 15:04:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180201150454.38c280d9.cohuck@redhat.com>
In-Reply-To: <0542bcf4-fc37-cf4a-6bd1-4dafa3533772@redhat.com>
References: <20180131181742.2037-1-cohuck@redhat.com>
	<20180131181742.2037-3-cohuck@redhat.com>
	<0542bcf4-fc37-cf4a-6bd1-4dafa3533772@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] s390x/cpumodel: allow zpci features
 in qemu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de

On Thu, 1 Feb 2018 13:31:46 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 31.01.2018 19:17, Cornelia Huck wrote:
> > AEN can be provided unconditionally, ZPCI should be turned on
> > manually.
> > 
> > With -cpu qemu,zpci=on, a 4.15 guest kernel can now successfully
> > detect virtio-pci devices under tcg.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/cpu_models.c   | 6 ++++++
> >  target/s390x/gen-features.c | 3 +++
> >  2 files changed, 9 insertions(+)
> > 

> > diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> > index 0570f597ec..c7083ed4a8 100644
> > --- a/target/s390x/gen-features.c
> > +++ b/target/s390x/gen-features.c
> > @@ -574,6 +574,7 @@ static uint16_t qemu_LATEST[] = {
> >      S390_FEAT_INTERLOCKED_ACCESS_2,
> >      S390_FEAT_MSA_EXT_4,
> >      S390_FEAT_MSA_EXT_3,
> > +    S390_FEAT_ADAPTER_EVENT_NOTIFICATION,  
> 
> Minor nit, according to the order in target/s390x/cpu_features_def.h,
> this should go before FEAT_MSA_EXT_3 (yes, the order of EXT3/EXT4 is
> messed up)

Will reorder.

> 
> >  };
> >  
> >  /* add all new definitions before this point */
> > @@ -582,6 +583,8 @@ static uint16_t qemu_MAX[] = {
> >      S390_FEAT_STFLE_53,
> >      /* generates a dependency warning, leave it out for now */
> >      S390_FEAT_MSA_EXT_5,
> > +    /* only with CONFIG_PCI */
> > +    S390_FEAT_ZPCI,
> >  };
> >  
> >  /****** END FEATURE DEFS ******/
> >   
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks!
