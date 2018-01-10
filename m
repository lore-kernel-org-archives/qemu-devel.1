Received: from eggs.gnu.org ([2001:4830:134:3::10]:49861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZBCC-0004hg-S1
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZBC8-0006wU-Vc
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:53:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZBC8-0006vW-O0
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:53:08 -0500
Date: Wed, 10 Jan 2018 15:52:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180110075257.GF5984@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-4-peterx@redhat.com>
	<3cd3f254-c72a-82ee-765b-f85690dad45a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cd3f254-c72a-82ee-765b-f85690dad45a@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 03/27] qobject: introduce
 qobject_get_try_str()
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

On Tue, Jan 09, 2018 at 04:50:39PM -0600, Eric Blake wrote:
> On 12/19/2017 02:45 AM, Peter Xu wrote:
> > A quick way to fetch string from qobject when it's a QString.
> > 
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qapi/qmp/qstring.h |  1 +
> >  qobject/qstring.c          | 11 +++++++++++
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
> > index a145c8ca00..6517d8e377 100644
> > --- a/include/qapi/qmp/qstring.h
> > +++ b/include/qapi/qmp/qstring.h
> > @@ -28,6 +28,7 @@ QString *qstring_from_substr(const char *str, int start, int end);
> >  size_t qstring_get_length(const QString *qstring);
> >  const char *qstring_get_str(const QString *qstring);
> >  const char *qstring_get_try_str(const QString *qstring);
> > +const char *qobject_get_try_str(const QObject *qstring);
> 
> The naming is consistent, so I won't reject the patch, but 'try_get_str'
> reads better than 'get_try_str'.  Of course, fixing the code base to
> read well AND be consistent is a much bigger task, and I'm not asking
> you to tackle it.

I agree.

> 
> 
> >  
> > +/**
> > + * qobject_get_try_str(): Return a pointer of the backstore string
> 
> The word "backstore" doesn't appear anywhere in qemu.git, and flags as a
> typo.  I'd prefer:
> 
> Return a pointer to the corresponding string

I'll take this one.  Thanks,

> 
> or maybe "backing string"

-- 
Peter Xu
