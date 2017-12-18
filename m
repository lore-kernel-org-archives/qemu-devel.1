Received: from eggs.gnu.org ([2001:4830:134:3::10]:58090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQs5h-0005sC-Hs
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQs5c-00044R-NH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:52:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQs5c-00043V-GW
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:52:04 -0500
Date: Mon, 18 Dec 2017 17:51:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171218095145.GS22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-27-peterx@redhat.com>
	<20171214144712.GO14433@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171214144712.GO14433@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 26/26] tests: qmp-test: add oob test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Dec 14, 2017 at 02:47:12PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:52:00PM +0800, Peter Xu wrote:
> > +    /* Try a fake capability, it should fail. */
> > +    resp = qmp("{ 'execute': 'qmp_capabilities', "
> > +               "  'arguments': { 'enable': [ 'cap-does-not-exist' ] } }");
> > +    g_assert(qdict_haskey(resp, "error"));
> 
> Missing QDECREF(resp) here and throughout the rest of the function.

I believe I missed four QDECREF()s.

> 
> Besides that:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Hope my counting is correct, then I'll add the r-b.  Thanks!

-- 
Peter Xu
