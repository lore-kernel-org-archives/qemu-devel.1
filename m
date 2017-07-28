Received: from eggs.gnu.org ([2001:4830:134:3::10]:41734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dazRs-0001Vh-MD
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dazRp-0006Xe-6r
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:12:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dazRo-0006XH-Td
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:12:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6S7CLfS040876
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 03:12:31 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bys7h7mqm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 03:12:31 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 28 Jul 2017 03:12:30 -0400
Date: Fri, 28 Jul 2017 15:12:25 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-2-bjsdjshi@linux.vnet.ibm.com>
	<20170727121017.3a655122@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170727121017.3a655122@gondolin>
Message-Id: <20170728071225.GC15504@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] s390x/css: use macro for
 event-information pending error recover code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

* Cornelia Huck <cohuck@redhat.com> [2017-07-27 12:10:17 +0200]:

[...]

> > diff --git a/include/hw/s390x/ioinst.h b/include/hw/s390x/ioinst.h
> > index 92d15655e4..c1d1052279 100644
> > --- a/include/hw/s390x/ioinst.h
> > +++ b/include/hw/s390x/ioinst.h
> > @@ -201,8 +201,9 @@ typedef struct CRW {
> >  #define CRW_FLAGS_MASK_A 0x0080
> >  #define CRW_FLAGS_MASK_ERC 0x003f
> >  
> > -#define CRW_ERC_INIT 0x02
> > -#define CRW_ERC_IPI  0x04
> > +#define CRW_ERC_EVENT  0x00
> 
> OK, that matches the name the Linux kernel uses.
A thief was caught by you. ;)

> 
> Do we want to add all ERCs while we're at it?
> 
> > +#define CRW_ERC_INIT   0x02
> > +#define CRW_ERC_IPI    0x04
No problem for me. I can do that by stealing again:

#define CRW_ERC_EVENT    0x00 /* event information pending */
#define CRW_ERC_AVAIL    0x01 /* available */
#define CRW_ERC_INIT     0x02 /* initialized */
#define CRW_ERC_TERROR   0x03 /* temporary error */
#define CRW_ERC_IPI      0x04 /* installed parm initialized */
#define CRW_ERC_TERM     0x05 /* terminal */
#define CRW_ERC_PERRN    0x06 /* perm. error, facility not init */
#define CRW_ERC_PERRI    0x07 /* perm. error, facility init */
#define CRW_ERC_PMOD     0x08 /* installed parameters modified */

Want the comment or not? I like them.

> >  
> >  #define CRW_RSC_SUBCH 0x3
> >  #define CRW_RSC_CHP   0x4
> 

-- 
Dong Jia Shi
