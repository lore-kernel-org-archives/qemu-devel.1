Received: from eggs.gnu.org ([2001:4830:134:3::10]:51887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1g6tPm-0007sy-E7
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1g6tPl-0000gC-Da
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1g6tPl-0000ff-7B
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:18:49 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00C634724
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:18:48 +0000 (UTC)
Date: Mon, 1 Oct 2018 10:18:45 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20181001081845.GD25720@paraplu>
References: <20180925160248.30801-1-kchamart@redhat.com>
	<20180925160248.30801-3-kchamart@redhat.com>
	<20180926172427.05a2de94@redhat.com>
	<87zhw33t8z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhw33t8z.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com

On Thu, Sep 27, 2018 at 04:33:16PM +0200, Markus Armbruster wrote:
> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > On Tue, 25 Sep 2018 18:02:48 +0200
> > Kashyap Chamarthy <kchamart@redhat.com> wrote:

[...]

> >> +(3) Check which socket is free to allow hotplugging a CPU::
> > may be: which cpus are possible to plug (an entry with qom-path
> > property describes an existing cpu)
>
> Suggest
> 
>     (3) Find out which CPU types could be plugged, and into which sockets:

Yeah, clearer.

[...]

> >> +(4) We can see that socket 1 is free,
> 
> How?  I know, but only because I just read the documentation of
> query-hotpluggable-cpus.  Which by the way sucks.  For instance, will
> the command always return exactly one HotpluggableCPU object per socket?

About the 'how', I was not entirely sure, hence my request in the cover
letter.

> Anyway, what about this:
> 
>     The command returns an object with a "qom-path" member for each
>     present CPU.  In this case, it shows an IvyBridge-IBRS-x86_64-cpu in
>     socket 0.
> 
>     It returns an object without a "qom-path" for every possibly CPU
>     hot-plug.  In this case, it shows you can plug an
>     IvyBridge-IBRS-x86_64-cpu into socket 1, and the additional
>     properties you need to pass to device_add for that.

Crystal clear.

Many thanks for the review!

> > ... and 'arguments' provide a list of property/value pairs to create
> > corresponding cpu.
> >
> >> +    "IvyBridge-IBRS-x86_64-cpu"::
> 
> Suggest
> 
>     (4) Hot-plug an additional CPU:

[...]

-- 
/kashyap
