Received: from eggs.gnu.org ([2001:4830:134:3::10]:36328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJgRu-0006J7-5W
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJgRk-0000a9-Oe
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:01:22 -0500
Date: Tue, 28 Nov 2017 15:01:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128150107.4cc88a86.cohuck@redhat.com>
In-Reply-To: <71ccf8b6-faa6-f4ac-3571-24bb59a0c498@de.ibm.com>
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<131b311b-c262-3636-c7ee-1c59ee283823@de.ibm.com>
	<1ddb44db-2c5c-d64f-56e0-e4582f82b572@linux.vnet.ibm.com>
	<20171124171510.2343ccdf.cohuck@redhat.com>
	<8c18df3e-92a0-f88f-6d24-e1df051c8138@linux.vnet.ibm.com>
	<20171127135624.28052dc5.cohuck@redhat.com>
	<57f95f61-b9d9-1341-78c7-259006cb5945@linux.vnet.ibm.com>
	<20171127141929.1d692aad.cohuck@redhat.com>
	<39cb6a69-7f32-80d4-214d-26e1e81a9fd7@linux.vnet.ibm.com>
	<2933e058-0217-9696-2c52-613da8ba7a1c@linux.vnet.ibm.com>
	<20171127175607.75bd999e.cohuck@redhat.com>
	<c49e91f1-0f8a-8f6c-9784-21aa4623e2cf@linux.vnet.ibm.com>
	<20171128112233.0a1c8c04.cohuck@redhat.com>
	<377c7bcb-403b-ed66-a9fd-07793c27ea5c@linux.vnet.ibm.com>
	<20171128131448.551e16b7.cohuck@redhat.com>
	<1d81d1c1-6f82-0261-51b4-1820a10431e6@de.ibm.com>
	<99906104-4746-6474-554e-ac85bd20106d@linux.vnet.ibm.com>
	<71ccf8b6-faa6-f4ac-3571-24bb59a0c498@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, 28 Nov 2017 14:25:08 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 11/28/2017 02:17 PM, Halil Pasic wrote:

> > In the meanwhile I strongly prefer option 1 (at the ccw devices). I've just
> > sent a v2, and IMHO it shows the limitations of machine properties very well.  
> 
> option 1 is still fine with me.

I still dislike it a lot. Machine properties have their own set of
problems, but I think devices are really the wrong place for a global
property.

> 
> >   
> >>>
> >>> Halil, do you see any chance to do this for 2.12? There's plenty of
> >>> time left, and I don't think it's too hard. If not, we don't have any
> >>> other option than proposal 3, even though I don't like it a lot.
> >>>  
> > 
> > I do think we have enough time to do this right. And of course I'm willing
> > to do it right. IMHO the 3 options summarized by Connie are not the only
> > options. But if we go for reworking our QOM composition tree, it will take
> > a lot of discussion. I'm not sure all the required people have enough spare
> > time for that.
> > 
> > Halil  
> 
> I am actually not sure if we really want to have a "user-definable default css" anytime
> soon. I think it might really open a can of worms in regard to management tooling.

Fair enough, there's really no short-term use case.

> What I want now is to enable vfio-ccw for libvirt and Linux guests and for that
> we need to lift the restriction of having vfio not in FE.

This, however, worries me. I don't really consider vfio-ccw ready for
prime time yet. We still need to figure out path handling at the very
least. And I'm still not sure that our non-handling of halt/clear won't
cause major issues with e.g. a storage server error recovery.

Can we flag vfio-ccw as experimental or such in libvirt?
