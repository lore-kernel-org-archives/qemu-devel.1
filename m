Received: from eggs.gnu.org ([2001:4830:134:3::10]:42858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dtrdX-0003T8-In
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dtrdU-0001OW-Bs
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:42:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dtrdU-0001Ea-4z
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:42:36 -0400
Date: Mon, 18 Sep 2017 10:42:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170918104229.4eadb172.cohuck@redhat.com>
In-Reply-To: <5626693c-d7be-7c21-37e3-27625e9fbf2b@de.ibm.com>
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
	<20170913132752.8484-2-pasic@linux.vnet.ibm.com>
	<20170914162603.1cdabd09.cohuck@redhat.com>
	<0b42ef59-4366-175f-8dc7-bc3ed02e2fb4@linux.vnet.ibm.com>
	<20170915092758.16ea52fc.cohuck@redhat.com>
	<5626693c-d7be-7c21-37e3-27625e9fbf2b@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Mon, 18 Sep 2017 10:30:32 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/15/2017 09:27 AM, Cornelia Huck wrote:
> > On Thu, 14 Sep 2017 18:50:29 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> On 09/14/2017 04:26 PM, Cornelia Huck wrote:  
> >>> On Wed, 13 Sep 2017 15:27:51 +0200
> >>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:  
> >   
> >>>> +static Property ccw_tester_properties[] = {
> >>>> +    DEFINE_PROP_UINT16("cu_type", CcwTesterDevice, cu_type,
> >>>> +                        0x3831),    
> >>>
> >>> 0x4711 would be nice :)    
> >>
> >> I don't understand the joke/pun/whatever if there is one,
> >> but I'm fine with changing this too.  
> > 
> > https://en.wikipedia.org/wiki/4711
> > 
> > That's my default if I need a four-digit number :)
> >   
> >>  
> >>>
> >>> If we want to follow up on that testdev idea (and I think we should),
> >>> it might make sense to have a proper type reserve to prevent accidental
> >>> clashes.    
> >>
> >> I agree. Although I would still keep the cu_type configurable,
> >> because it might make sense to test a particular 'real' driver
> >> (and not a test driver like here). I haven't really thought
> >> this through, but it was an idea I had while agonizing over
> >> not having a proper type reserved.
> >>
> >> I suppose you did something like that for virtio, or? I'm in dark
> >> when it comes to the question what process do we/I have to go to
> >> get a type,for example 0x4711, reserved.  
> > 
> > 4711 is more a joke :) It might be worth trying the same channels as
> > for virtio-ccw.
> > 
> > Christian should know more about that.  
> 
> Getting a new number was very easy (because it is attached to a machine type
> number). I I remember correctly, only numerical values are uses, so maybe
> we can use ffff as there will never be such a real value?
> 

Yes, that sounds like the easiest way to do that.
