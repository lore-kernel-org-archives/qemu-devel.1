Received: from eggs.gnu.org ([2001:4830:134:3::10]:59113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1edvVR-0002DE-Nk
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1edvVN-0003QU-Jg
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:08:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1edvVN-0003QD-DC
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:08:37 -0500
Message-ID: <1516702111.31897.2.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 23 Jan 2018 11:08:31 +0100
In-Reply-To: <1516372482.3278.29.camel@redhat.com>
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<20180119051926.GI30352@umbus.fritz.box>
	<6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
	<1516372482.3278.29.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org

On Fri, 2018-01-19 at 15:34 +0100, Andrea Bolognani wrote:
> > > This won't solve the libvirt problem we were discussing, because it
> > > needs an existing instance of the object.  libvirt wants to know the
> > > machine properties *without* instantiating an instance.
> > 
> > My patch works with types, it creates an instance for a short time itself,
> > this is why it does not do a thing for "pseries" as it is not a type and
> > prints properties for the "pseries-2.12-machine" type.
> 
> Yeah, I took this for a spin and can confirm that it's pretty much
> exactly what I was thinking about. The fact that the QMP command
> instantiates objects behind the scenes is not an issue, at least
> from libvirt's point of view: device-list-properties does the same
> thing and we already use it quite happily; what matters is that we
> can call this, along with all the other capabilities-collecting
> QMP commands, in one go and on a single QEMU instance.

David, I know you're busy with linux.conf.au, but it would be
really helpful if you could carve out five minutes to look over
Alexey's proposal again, with my reply above in mind, and let us
know whether it looks a reasonable design. Doesn't have to be a
review, just a quick feedback on the high-level idea.

I'm moving forward with the libvirt implementation of pSeries
capabilities and I would have to start implementing support for
this new QMP command, well, pretty much... Right now :) But I'd
rather not start at all if I'm just going to have to scrap
everything later.

Thanks.

-- 
Andrea Bolognani / Red Hat / Virtualization
