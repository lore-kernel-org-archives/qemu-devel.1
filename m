Received: from eggs.gnu.org ([2001:4830:134:3::10]:60609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evEFn-0004ba-Jh
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evEFi-0004sC-JD
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:36:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evEFi-0004rF-E4
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:35:58 -0400
Date: Mon, 12 Mar 2018 11:35:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180312033547.GB5234@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-18-peterx@redhat.com>
	<97cdc93e-1962-3279-13e7-7faac27862f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97cdc93e-1962-3279-13e7-7faac27862f2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 17/23] qapi: introduce new cmd option
 "allow-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Sat, Mar 10, 2018 at 08:27:22PM -0600, Eric Blake wrote:

[...]

> I'm a bit disappointed that tests/qapi-schema/qapi-schema-test.json doesn't
> have any "allow-oob":true commands at any point in the series. I consider
> that to be a bug, so it can be fixed by followup patch even after soft
> freeze; but won't make the lack of good testing hold up this series from
> making the release.

Sorry, obviously I missed that one.

If this series will reach master soon, I'll post separate patch for
that before release as bugfix.

If this series can't make it due to any reason, I'll append a patch to
the series when repost.

> 
> > +++ b/scripts/qapi/introspect.py
> > @@ -29,6 +29,11 @@ def to_json(obj, level=0):
> >                                 to_json(obj[key], level + 1))
> >                   for key in sorted(obj.keys())]
> >           ret = '{' + ', '.join(elts) + '}'
> > +    elif isinstance(obj, bool):
> > +        if obj:
> > +            ret = 'true'
> > +        else:
> > +            ret = 'false'
> 
> Conflicts with Marc-Andre's work to perform introspection by QLIT_*; but
> it's easy enough to adjust:
> 
> +    elif isinstance(obj, bool):
> +        ret += 'QLIT_QBOOL(%s)' % ('true' if obj else 'false')
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks,

-- 
Peter Xu
