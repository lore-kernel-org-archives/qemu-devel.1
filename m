Received: from eggs.gnu.org ([2001:4830:134:3::10]:34929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fT64f-0004tH-32
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fT64b-0005wq-0u
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:44:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fT64a-0005uB-QO
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:44:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F14FE3084037
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 13:44:27 +0000 (UTC)
Date: Wed, 13 Jun 2018 10:44:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613134423.GP7451@localhost.localdomain>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org>
	<20180611184016.GR7451@localhost.localdomain>
	<20180611233342.36a35911@igors-macbook-pro.local>
	<871sdcxzej.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sdcxzej.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, pkrempa@redhat.com, Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>

On Tue, Jun 12, 2018 at 09:00:20AM +0200, Markus Armbruster wrote:
> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > On Mon, 11 Jun 2018 15:40:16 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> >> On Mon, Jun 11, 2018 at 02:01:52PM +0200, Markus Armbruster wrote:
> >> > * Eduardo, why does "info numa" have no QMP equivalent?
> >> 
> >> Nobody ever asked for one, which seems to qualify as "only for
> >> human users".
> >> 
> >> Should we add an equivalent QMP command even if we don't expect
> >> anybody to use it?
> 
> The hard requirement for QMP from day one was "provide everything
> machine clients need".  To avoid speculation and endless arguments about
> what might be needed / not needed, we resolved to approximate this by
> "provide everything, except stuff that's *clearly* of no use to
> machines".
> 
> When you think a command is such an exception, you should explain why in
> its commit message.

It's not an exception nor it needs to be one.  I was just not
aware of the above approximation.


> 
> Note that HMP need not provide the functionality in the exact same
> packaging.  For instance, it's fine to have building blocks in QMP, and
> just a high-level command in HMP.  However, the latter must be
> implemented with the building blocks to make it obvious that QMP
> provides the same functionality.
> 
> For additional references, see
> Message-ID: <87d0x1p6go.fsf@dusky.pond.sub.org>
> https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg02176.html
> 
> > we inderectly can fetch numa info via QMP, using 
> >   query-hotpluggable-cpus
> > for CPU mapping and
> >   query-memory-devices
> > for (NV|PC)-dimm devices, however there is no QMP way for getting
> > for numa mapping of initial RAM nor configured numa nodes
> > (not counting querying CLI options).
> 
> Sounds like most of the building blocks are already there.  The
> "obviousness" isn't.
> 
> > So perhaps we need info 'numa' equivalent for QMP which would give
> > the same amount of information as HMP in one query.
> 
> I'd appreciate patches to get us to "QMP has the building blocks, and
> HMP is implemented with them".

Agreed.

-- 
Eduardo
