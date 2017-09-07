Received: from eggs.gnu.org ([2001:4830:134:3::10]:44806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpwHh-0004Hi-Uq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpwHd-00077u-5h
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:51:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpwHc-00076O-WD
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:51:49 -0400
Date: Thu, 7 Sep 2017 14:51:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907145140.5e7e0b19.cohuck@redhat.com>
In-Reply-To: <f5f34674-74d4-48b3-bde1-13605c746ad1@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-12-david@redhat.com>
	<2c620927-0406-2fc1-895c-09ffc2e44a4e@linux.vnet.ibm.com>
	<6b3e9c2b-4cb7-fdf8-5f9b-ff7ebbf52d1e@linaro.org>
	<f5f34674-74d4-48b3-bde1-13605c746ad1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/19] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, qemu-devel@nongnu.org, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com

On Thu, 7 Sep 2017 14:49:49 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 06.09.2017 23:20, Richard Henderson wrote:
> > On 09/06/2017 11:16 AM, Matthew Rosato wrote:  
> >> On 09/04/2017 11:43 AM, David Hildenbrand wrote:  
> >>> Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
> >>> guest tries to bring these CPUs up but fails), because we don't support
> >>> multiple CPUs on s390x under TCG.
> >>>
> >>> Let's bail out if more than 1 is specified, so we don't raise people's
> >>> hope. Make it a define, so we can easily bump it up later.
> >>>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> ---  
> >>
> >> Makes sense.  Ran the described environment without this patch (errors)
> >> and again with this patch (graceful exit w/ message).
> >>
> >> Tested-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>  
> > 
> > Can someone review
> > 
> >   http://patchwork.ozlabs.org/patch/760010/
> >   
> 
> Yes, we also discovered that patch during review of v1.
> 
> > which does at least start to add the SIGP support.
> > 
> > Once tcg can bring up 2 cpus, I see no reason it couldn't bring up N.  I don't
> > see the point of the define.
> >   
> 
> Conny requested a define. So it boils down to
> 
> a) no define just as in v1
> b) a define like S390_TCG_SMP_SUPPORTED
> 
> What do you suggest?

FWIW, I'd prefer b).

> 
> > 
> > r~
> >   
> 
> 
