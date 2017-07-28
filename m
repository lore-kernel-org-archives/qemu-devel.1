Received: from eggs.gnu.org ([2001:4830:134:3::10]:49586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dazfH-0000Q1-V1
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dazfE-0001LP-S4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:26:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dazfE-0001Kl-Ls
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:26:24 -0400
Date: Fri, 28 Jul 2017 09:26:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170728092620.13cc75ce@gondolin>
In-Reply-To: <20170728071225.GC15504@bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-2-bjsdjshi@linux.vnet.ibm.com>
	<20170727121017.3a655122@gondolin>
	<20170728071225.GC15504@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

On Fri, 28 Jul 2017 15:12:25 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2017-07-27 12:10:17 +0200]:

> > Do we want to add all ERCs while we're at it?
> >   
> > > +#define CRW_ERC_INIT   0x02
> > > +#define CRW_ERC_IPI    0x04  
> No problem for me. I can do that by stealing again:
> 
> #define CRW_ERC_EVENT    0x00 /* event information pending */
> #define CRW_ERC_AVAIL    0x01 /* available */
> #define CRW_ERC_INIT     0x02 /* initialized */
> #define CRW_ERC_TERROR   0x03 /* temporary error */
> #define CRW_ERC_IPI      0x04 /* installed parm initialized */
> #define CRW_ERC_TERM     0x05 /* terminal */
> #define CRW_ERC_PERRN    0x06 /* perm. error, facility not init */
> #define CRW_ERC_PERRI    0x07 /* perm. error, facility init */
> #define CRW_ERC_PMOD     0x08 /* installed parameters modified */
> 
> Want the comment or not? I like them.

Yes, just do it.

> 
> > >  
> > >  #define CRW_RSC_SUBCH 0x3
> > >  #define CRW_RSC_CHP   0x4  
> >   
> 
