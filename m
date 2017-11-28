Received: from eggs.gnu.org ([2001:4830:134:3::10]:34196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eJVKU-00075p-Kv
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 21:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eJVKR-0002AN-Eg
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 21:08:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50972
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eJVKR-0002AA-8R
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 21:08:55 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAS28qx4120324
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 21:08:54 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2egwjtatmx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 21:08:53 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 21:08:53 -0500
Date: Tue, 28 Nov 2017 10:08:47 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <131b311b-c262-3636-c7ee-1c59ee283823@de.ibm.com>
	<1ddb44db-2c5c-d64f-56e0-e4582f82b572@linux.vnet.ibm.com>
	<20171124171510.2343ccdf.cohuck@redhat.com>
	<8c18df3e-92a0-f88f-6d24-e1df051c8138@linux.vnet.ibm.com>
	<20171127135624.28052dc5.cohuck@redhat.com>
	<57f95f61-b9d9-1341-78c7-259006cb5945@linux.vnet.ibm.com>
	<20171127141929.1d692aad.cohuck@redhat.com>
	<39cb6a69-7f32-80d4-214d-26e1e81a9fd7@linux.vnet.ibm.com>
	<2933e058-0217-9696-2c52-613da8ba7a1c@linux.vnet.ibm.com>
	<20171127175607.75bd999e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171127175607.75bd999e.cohuck@redhat.com>
Message-Id: <20171128020847.GM5859@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

* Cornelia Huck <cohuck@redhat.com> [2017-11-27 17:56:07 +0100]:

> On Mon, 27 Nov 2017 16:09:09 +0100
> Boris Fiuczynski <fiuczy@linux.vnet.ibm.com> wrote:
> 
> > On 11/27/2017 03:13 PM, Halil Pasic wrote:
> > > 
> > > 
> > > On 11/27/2017 02:19 PM, Cornelia Huck wrote:  
> > >> On Mon, 27 Nov 2017 14:11:57 +0100
> > >> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > >>  
> > >>> On 11/27/2017 01:56 PM, Cornelia Huck wrote:  
> > >>>> On Fri, 24 Nov 2017 17:39:04 +0100
> > >>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > >>>>      
> > >>>>> On 11/24/2017 05:15 PM, Cornelia Huck wrote:  
> > >>  
> > >>>>>> (Unless we simply make this a "default cssid" prop after all - then it
> > >>>>>> would be more than just a simple indication for libvirt...)
> > >>>>>>        
> > >>>>>
> > >>>>> We are now talking about the "cssid-unrestricted" property. The default
> > >>>>> cssid is not something I would like to do any time soon.  
> > >>>>
> > >>>> What's so bad about this? As said above, I think it would be much more
> > >>>> useful. If libvirt can detect r/o vs. r/w for properties, we can simply
> > >>>> start out with a r/o variant now...
> > >>>>      
> > >>>
> > >>> I'm not sure I understand you. Are you proposing the following:
> > >>> Drop the restriction, but don't indicate this via a read only
> > >>> "cssid-unrestricted" device property but via a "default-css"
> > >>> read only machine property.
> > >>>
> > >>> Libvirt then should know that if "default-css" is present then
> > >>> we don't have this virtual into 0xfe and non virtual into 0xfd
> > >>> restriction any more.  
> > >>
> > >> Yes.
> > >>  
> > > 
> > > @Boris:
> > > Does this work for you? Technically it's equivalent to having
> > > "cssid-unrestricted" at machine level.
> > > 
> > > I don't really like the idea of indicating unrestricted via
> > > something mostly unrelated (at least for me it ain't obvious that
> > > having the id of the default css exposed means we got rid of the
> > > limitation.). But I'm tied of discussing this, so I'm willing to
> > > compromise.
> > > 
> > > Halil
> > >   
> > I agree with Christian that we should not throw the "setting of a 
> > default cssid" together with "unrestricted cssid" and than use read/only 
> > and read/write to distinguish between the two!
> > 
> 
> OK, let's step back and summarize a bit.
> 
> Current situation:
> - virtual devices must go into 0xfe, non-virtual devices must go into
>   non-0xfe
> - 0xfe is the default cssid; non-mcss-e OSs see only devices in there
> - to expose non-virtual devices to today's guests, you need to use the
>   squash-mcss parameter, which tries to put non-virtual devices into
>   the same place in css 0xfe
When squashing, everything will be squashed to css 0 which is the
deafult css in this case.

[No effect to the conclusions below, but better to clarify.:-]

> 
> This is problematic in various ways (potential for incomprehensible
> errors, amongst others), so we agreed that the way to go is to drop the
> virtual-vs-non-virtual cssid restrictions and allow any device in any
> css image.
> 
> Now, we need a way for libvirt to detect this, so that it knows that it
> can put e.g. vfio-ccw devices in the same css image as virtio devices.
> 
> Proposal 1: Use a device attribute to show that the device can be put
> anywhere. This approach feels wrong to me (the non-restriction is not a
> property of the individual device, but of the whole css resp. the
> machine), so I would continue to veto this.
> 
> Proposal 2: Export the default cssid as a machine property. If this
> property exists, it also implies that devices can be put into any css
> image (although it makes the most sense to put them into the default
> css image as indicated by the property). Can be made r/w later if it is
> too much for 2.12.
> 
> Proposal 3: Add a machine property that indicates cssids are not
> restricted. Later, optionally add a second property that exposes the
> default cssid and makes it configurable.
> 
> Personally, I prefer 2 (especially as this also allows to find out
> where the best place to put devices for non-mcss-e enabled guests is),
> but I could live with 3 as well (if making this r/w later would be
> problematic for libvirt.)
> 
> (In every case, we would deprecate and later remove the squash
> parameter.)
> 
> [As an aside, how hard is it to make the default cssid configurable? At
> a glance, it does not seem too bad to me.]
> 

-- 
Dong Jia Shi
