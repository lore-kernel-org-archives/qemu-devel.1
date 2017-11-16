Received: from eggs.gnu.org ([2001:4830:134:3::10]:41722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFDzk-0003U3-KV
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFDzh-0007en-JS
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:49:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFDzh-0007eH-Cq
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:49:49 -0500
Date: Thu, 16 Nov 2017 14:49:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171116064934.GA11689@xz-mi>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-19-peterx@redhat.com>
	<20171115105015.GE8130@stefanha-x1.localdomain>
	<20171116055654.GC30426@xz-mi> <20171116062905.GD30426@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171116062905.GD30426@xz-mi>
Subject: Re: [Qemu-devel] [RFC v3 18/27] qmp: add new event "request-dropped"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Nov 16, 2017 at 02:29:05PM +0800, Peter Xu wrote:

[...]

> > > > +#
> > > > +# @id:    If the original request contains an string-typed "id" field,
> > > > +#         it'll be put into this field.  Otherwise it'll be an empty
> > > > +#         string.
> > > 
> > > Please change:
> > > 
> > >   @id: The dropped command's string-typed "id" field.
> > 
> > Ok.
> 
> I just found this one tricky: currently we allow all kinds of "id"
> fields in QMP commands, which means that here I should allow all kinds
> of "id" fields as well rather than restrict it as "string" typed.
> 
> But I don't really know how to do that in QMP, say, what I want is
> something like:
> 
> { 'event': 'REQUEST_DROPPED' ,
>   'data': { 'id': 'object', 'reason': 'RequestDropReason' } }
>                   ^^^^^^^^
> 
> Any thoughts on how to do that the simple way?

Please ignore it.  I just noticed that we have type 'any' which I can
use.  Sorry for the noise.

-- 
Peter Xu
