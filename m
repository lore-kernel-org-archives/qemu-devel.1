Received: from eggs.gnu.org ([2001:4830:134:3::10]:35456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcqPI-0002Ww-UU
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcqPF-0000zY-RT
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:57:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dcqPF-0000xc-LC
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:57:33 -0400
Date: Wed, 2 Aug 2017 11:57:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170802115726.1e858735@gondolin>
In-Reply-To: <20170802011518.GB24907@bjsdjshi@linux.vnet.ibm.com>
References: <20170801075727.31335-1-bjsdjshi@linux.vnet.ibm.com>
	<20170801075727.31335-2-bjsdjshi@linux.vnet.ibm.com>
	<5c4c144e-7526-71cf-cd7a-c4ca4d2eff60@linux.vnet.ibm.com>
	<20170802011518.GB24907@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/css: use macro for
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
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pmorel@linux.vnet.ibm.com

On Wed, 2 Aug 2017 09:15:18 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-08-01 17:24:10 +0200]:
> 
> > 
> > 
> > On 08/01/2017 09:57 AM, Dong Jia Shi wrote:  
> > > Let's use a macro for the ERC (error recover code) when generating a
> > > Channel Subsystem Event-information pending CRW (channel report word).
> > > 
> > > While we are at it, let's also add all other ERCs.
> > > 
> > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > ---
> > >  hw/s390x/css.c            |  2 +-
> > >  include/hw/s390x/ioinst.h | 11 +++++++++--
> > >  2 files changed, 10 insertions(+), 3 deletions(-)

(...)

> > > diff --git a/include/hw/s390x/ioinst.h b/include/hw/s390x/ioinst.h
> > > index 92d15655e4..f89019f78f 100644
> > > --- a/include/hw/s390x/ioinst.h
> > > +++ b/include/hw/s390x/ioinst.h
> > > @@ -201,8 +201,15 @@ typedef struct CRW {
> > >  #define CRW_FLAGS_MASK_A 0x0080
> > >  #define CRW_FLAGS_MASK_ERC 0x003f
> > > 
> > > -#define CRW_ERC_INIT 0x02
> > > -#define CRW_ERC_IPI  0x04
> > > +#define CRW_ERC_EVENT    0x00 /* event information pending */
> > > +#define CRW_ERC_AVAIL    0x01 /* available */
> > > +#define CRW_ERC_INIT     0x02 /* initialized */
> > > +#define CRW_ERC_TERROR   0x03 /* temporary error */
> > > +#define CRW_ERC_IPI      0x04 /* installed parm initialized */
> > > +#define CRW_ERC_TERM     0x05 /* terminal */
> > > +#define CRW_ERC_PERRN    0x06 /* perm. error, facility not init */
> > > +#define CRW_ERC_PERRI    0x07 /* perm. error, facility init */
> > > +#define CRW_ERC_PMOD     0x08 /* installed parameters modified */  
> > 
> > You have missed installed parameters restored from the PoP (above
> > you say add all other).  
> Ok. Will add:
> #define CRW_ERC_IPR      0x0A /* installed parameters restored */

Makes sense.

> 
> > 
> > Other than that.
> > 
> > LGTM
> >   
> > > 
> > >  #define CRW_RSC_SUBCH 0x3
> > >  #define CRW_RSC_CHP   0x4
> > >   
> 
