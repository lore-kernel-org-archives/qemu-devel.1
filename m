Received: from eggs.gnu.org ([2001:4830:134:3::10]:46178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duXyX-0004uz-IE
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duXyS-0004cI-9P
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:55:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duXyS-0004Rr-2q
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:55:04 -0400
Date: Wed, 20 Sep 2017 13:54:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170920055449.GV3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-7-git-send-email-peterx@redhat.com>
	<0888aa23-a2a9-6080-d6c0-7522c86b5eb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0888aa23-a2a9-6080-d6c0-7522c86b5eb4@redhat.com>
Subject: Re: [Qemu-devel] [RFC 06/15] monitor: move the cur_mon hack deeper
 for QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Sep 19, 2017 at 04:05:48PM -0500, Eric Blake wrote:
> On 09/14/2017 02:50 AM, Peter Xu wrote:
> > In monitor_qmp_read(), we have the hack to temporarily replace the
> > cur_mon pointer.  Now we move this hack deeper inside the QMP dispatcher
> > routine since the Monitor pointer can be passed in to that using the new
> > JSON Parser opaque field now.
> > 
> > This does not make much sense as a single patch.  However, this will be
> > a big step for the next patch, when the QMP dispatcher routine will be
> > splitted from the QMP parser.
> 
> English is weird: 'split' is the word for present, past, and past
> participle tenses; there is no word 'splitted'.

Fixed.

> 
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

-- 
Peter Xu
