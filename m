Received: from eggs.gnu.org ([2001:4830:134:3::10]:54398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ejOgV-00053T-29
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ejOgU-0004UE-3l
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:18:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1ejOgT-0004Qw-Uy
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:18:42 -0500
Message-ID: <1518005911.11875.3.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 07 Feb 2018 13:18:31 +0100
In-Reply-To: <8d3a65e6-e62b-6506-fb43-bb83f5ee7828@ozlabs.ru>
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<871si6vt8n.fsf@dusky.pond.sub.org>
	<e3aca639-0c5c-8d10-a9f4-05a62284fb10@ozlabs.ru>
	<87r2q3n8oe.fsf@dusky.pond.sub.org>
	<8d3a65e6-e62b-6506-fb43-bb83f5ee7828@ozlabs.ru>
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Markus Armbruster <armbru@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 2018-02-05 at 14:30 +1100, Alexey Kardashevskiy wrote:
> On 02/02/18 18:37, Markus Armbruster wrote:
> > > > Likewise for properties created differently (say with a different type)
> > > > in non-default configuration.  We can hope that no such beasts exist.
> > > > Since properties get created by code, and code can do anything, we're
> > > > reduced to hope.  Data is so much easier to reason about than code.
> > > > 
> > > > Three building blocks: instantiate, qom-list, destroy.  Do we want the
> > > > building blocks, or do we want their combination qom-list-properties?
> > > 
> > > Building blocks as QEMU internal helpers to split my
> > > qmp_qom_list_properties() into? These are not going to be huge and
> > > "destroy" is literally object_unref(obj) which does not seem very useful.
> > > Or I missed the point here?
> > 
> > My question is whether the QMP interface should provide the building
> > blocks, or only compositions.
> 
> instantiate but not realize? Not sure we have users for that.

We already have scaffolding for dealing with device-list-properties
in libvirt, so the implementation of qom-list-properties proposed
by Alexey would probably be able to reuse a lot of code and could
be integrated very quickly. So there's that.

Would there be any other known use case for providing the building
blocks?

-- 
Andrea Bolognani / Red Hat / Virtualization
