Received: from eggs.gnu.org ([2001:4830:134:3::10]:36961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ6zf-0001Ts-1r
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 02:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ6zb-0001gW-Va
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 02:34:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQ6zb-0001e2-P0
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 02:34:43 -0500
Date: Sat, 16 Dec 2017 15:34:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171216073431.GH22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-20-peterx@redhat.com>
	<20171215095104.GD15187@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171215095104.GD15187@lemon>
Subject: Re: [Qemu-devel] [RFC v5 19/26] qapi: introduce new cmd option
 "allow-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Dec 15, 2017 at 05:51:04PM +0800, Fam Zheng wrote:
> On Tue, 12/05 13:51, Peter Xu wrote:
> > --- a/qapi/introspect.json
> > +++ b/qapi/introspect.json
> > @@ -259,12 +259,16 @@
> >  #
> >  # @ret-type: the name of the command's result type.
> >  #
> > +# @allow-oob: whether the command allows out-of-band execution.
> > +#             (Since: 2.11)
> 
> (Since: 2.12)

Ouch... So at last I still missed one.

Fixed.  Thanks,

-- 
Peter Xu
