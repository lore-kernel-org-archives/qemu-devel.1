Received: from eggs.gnu.org ([2001:4830:134:3::10]:59426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ6S2-0006A8-Hd
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 02:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ6Rz-0008Vs-F0
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 02:00:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQ6Rz-0008VL-8W
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 01:59:59 -0500
Date: Sat, 16 Dec 2017 14:59:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171216065944.GF22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-18-peterx@redhat.com>
	<20171214111602.GE14433@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171214111602.GE14433@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 17/26] qmp: add new event "request-dropped"
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

On Thu, Dec 14, 2017 at 11:16:02AM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:51PM +0800, Peter Xu wrote:
> > +##
> > +# @RequestDropReason:
> > +#
> > +# Reasons that caused one command to be dropped.
> > +#
> > +# @queue-full: the queue of request is full.
> > +#
> > +# Since: 2.12
> > +##
> > +{ 'enum': 'RequestDropReason',
> 
> qapi-schema.json calls them "commands", not "requests".  Please rename
> it CommandDropReason for consistency and update the documentation.
> 
> > +  'data': [ 'queue-full' ] }
> > +
> > +##
> > +# @REQUEST_DROPPED:
> > +#
> > +# Emitted when one QMP request is dropped due to some reason.
> > +# REQUEST_DROPPED is only emitted when the oob capability is enabled.
> 
> Please make it clear that requests can only be dropped when the oob
> capability is enabled.
> 
>   Emitted when a command is dropped due to some reason.  Commands can
>   only be dropped when the oob capability is enabled.

Will address all comments, including the other reply.

Meanwhile I'll rename REQUEST_DROPPED to COMMAND_DROPPED so no
"request" but all "command" then.  Thanks,

-- 
Peter Xu
