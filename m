Received: from eggs.gnu.org ([2001:4830:134:3::10]:37771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duE3b-0006Mt-Pc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duE3W-0000k5-Ss
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:39:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duE3W-0000jp-Ma
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:38:58 -0400
Date: Tue, 19 Sep 2017 10:38:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170919103851.50fd0237.cohuck@redhat.com>
In-Reply-To: <20170919022142.GB5274@bjsdjshi@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-2-pasic@linux.vnet.ibm.com>
	<20170919022142.GB5274@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] s390x/css: introduce css data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, 19 Sep 2017 10:21:42 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-13 13:50:26 +0200]:
> 
> [...]
> 
> > diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> > index 0653d3c9be..79acaf99b7 100644
> > --- a/include/hw/s390x/css.h
> > +++ b/include/hw/s390x/css.h
> > @@ -75,6 +75,29 @@ typedef struct CMBE {
> >      uint32_t reserved[7];
> >  } QEMU_PACKED CMBE;
> > 
> > +typedef enum CcwDataStreamOp {
> > +    CDS_OP_R = 0,
> > +    CDS_OP_W = 1,
> > +    CDS_OP_A = 2  
> 
> Nit:
> 
> typedef enum CcwDataStreamOp {
>     CDS_OP_R, /* read */
>     CDS_OP_W, /* write */
>     CDS_OP_A  /* advance */
> } CcwDataStreamOp;
> 
> (I just keep translating 'A' as append in my mind...)

Adding comments makes sense. Done.

> 
> > +} CcwDataStreamOp;
> > +  
> [...]
> 
> > +static inline uint16_t ccw_dstream_avail(CcwDataStream *cds)
> > +{
> > +    return ccw_dstream_good(cds) ?  ccw_dstream_residual_count(cds) : 0;  
>                                      ^^
> Nit.

Fixed.

> 
> > +}  
> 
> [...]
> 
> With or w/o responses the nit picks:
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 

Thanks!
