Received: from eggs.gnu.org ([2001:4830:134:3::10]:50992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZBGD-0006tT-Rp
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZBG9-0002mY-VW
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:57:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZBG9-0002l7-Po
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:57:17 -0500
Date: Wed, 10 Jan 2018 15:57:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180110075704.GG5984@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-5-peterx@redhat.com>
	<bb8239ca-8960-8bd5-5160-a65b20904d3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb8239ca-8960-8bd5-5160-a65b20904d3c@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 04/27] qobject: let
 object_property_get_str() use new API
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

On Tue, Jan 09, 2018 at 04:53:40PM -0600, Eric Blake wrote:
> On 12/19/2017 02:45 AM, Peter Xu wrote:
> > We can simplify object_property_get_str() using the new
> > qobject_get_try_str().
> > 
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  qom/object.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> I'm not opposed to your patch split (particularly since it makes
> backports easier if it just needs the new function and then your later
> uses of the new function, without touching existing uses); but I might
> have merged this with the previous patch so that the new API has a
> client right away, proving why the new API is worthwhile as part of its
> introduction.

Sure, I'll follow the rule next time.

(I can simply squash it but I got a few r-bs for separate patches
 already, so I'll keep them separated for now)

Thanks,

-- 
Peter Xu
