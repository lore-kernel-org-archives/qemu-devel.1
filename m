Received: from eggs.gnu.org ([2001:4830:134:3::10]:34658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g6u2r-00075S-GU
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g6u2n-0003LB-FR
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:59:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g6u2n-0003K8-6o
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C539D30DF71F
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:59:07 +0000 (UTC)
Date: Mon, 1 Oct 2018 10:59:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181001105904.4c155ffd@redhat.com>
In-Reply-To: <20181001081845.GD25720@paraplu>
References: <20180925160248.30801-1-kchamart@redhat.com>
	<20180925160248.30801-3-kchamart@redhat.com>
	<20180926172427.05a2de94@redhat.com>
	<87zhw33t8z.fsf@dusky.pond.sub.org>
	<20181001081845.GD25720@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] docs: Document vCPU hotplug
 procedure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, Eric Blake <eblake@redhat.com>

On Mon, 1 Oct 2018 10:18:45 +0200
Kashyap Chamarthy <kchamart@redhat.com> wrote:

> On Thu, Sep 27, 2018 at 04:33:16PM +0200, Markus Armbruster wrote:
> > Igor Mammedov <imammedo@redhat.com> writes:
> >   
> > > On Tue, 25 Sep 2018 18:02:48 +0200
> > > Kashyap Chamarthy <kchamart@redhat.com> wrote:  
> 
> [...]
> 
> > >> +(3) Check which socket is free to allow hotplugging a CPU::  
> > > may be: which cpus are possible to plug (an entry with qom-path
> > > property describes an existing cpu)  
> >
> > Suggest
> > 
> >     (3) Find out which CPU types could be plugged, and into which sockets:  
> 
> Yeah, clearer.
> 
> [...]
> 
> > >> +(4) We can see that socket 1 is free,  
> > 
> > How?  I know, but only because I just read the documentation of
> > query-hotpluggable-cpus.  Which by the way sucks.  For instance, will
> > the command always return exactly one HotpluggableCPU object per socket?  
> 
> About the 'how', I was not entirely sure, hence my request in the cover
> letter.
> 
> > Anyway, what about this:
> > 
> >     The command returns an object with a "qom-path" member for each
> >     present CPU.  In this case, it shows an IvyBridge-IBRS-x86_64-cpu in
> >     socket 0.
> > 
> >     It returns an object without a "qom-path" for every possibly CPU
> >     hot-plug.  In this case, it shows you can plug an
> >     IvyBridge-IBRS-x86_64-cpu into socket 1, and the additional
> >     properties you need to pass to device_add for that.
not really sure my English (CCed Eric) but to match 'an object' with
the rest of sentence:

 It returns an object without a "qom-path" for a possible to hot-plug CPU.
 +
 In this case, it shows you can plug an  IvyBridge-IBRS-x86_64-cpu
 into socket 1/core = 0/thread 0, where 'props' list describes
 additional properties you need to pass to device_add for hot-pluging
 that CPU.

> 
> Crystal clear.
> 
> Many thanks for the review!
> 
> > > ... and 'arguments' provide a list of property/value pairs to create
> > > corresponding cpu.
> > >  
> > >> +    "IvyBridge-IBRS-x86_64-cpu"::  
> > 
> > Suggest
> > 
> >     (4) Hot-plug an additional CPU:  
> 
> [...]
> 
