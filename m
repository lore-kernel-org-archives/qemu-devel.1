Received: from eggs.gnu.org ([2001:4830:134:3::10]:54905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLgQb-0003pw-Lq
	for qemu-devel@nongnu.org; Wed, 23 May 2018 22:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLgQW-0004NB-QU
	for qemu-devel@nongnu.org; Wed, 23 May 2018 22:56:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLgQW-0004N3-LD
	for qemu-devel@nongnu.org; Wed, 23 May 2018 22:56:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A2E04067F19
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 02:56:28 +0000 (UTC)
Date: Thu, 24 May 2018 10:56:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180524025623.GC756@xz-mi>
References: <20180522035629.30428-1-peterx@redhat.com>
	<20180522035629.30428-2-peterx@redhat.com>
	<101fcf93-23b4-a628-13cd-8cb2a169fbc4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <101fcf93-23b4-a628-13cd-8cb2a169fbc4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qemu-error: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Wed, May 23, 2018 at 10:47:29AM -0500, Eric Blake wrote:
> On 05/21/2018 10:56 PM, Peter Xu wrote:
> > I stole the printk_once() macro.
> > 
> > I always wanted to be able to print some error directly if there is a
> > buffer to dump, however we can't use error_report() where the code path
> > can be triggered by DDOS attack.  To avoid that, we can introduce a
> > print-once-like function for it.  Meanwhile, we also introduce the
> > corresponding helper for warn_report().
> > 
> > CC: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/qemu/error-report.h | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> > 
> > diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> > index e1c8ae1a52..3e6e84801f 100644
> > --- a/include/qemu/error-report.h
> > +++ b/include/qemu/error-report.h
> > @@ -44,6 +44,32 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> >   void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> >   void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> > +/* Similar to error_report(), but it only prints the message once. */
> > +#define error_report_once(fmt, ...)             \
> > +    ({                                          \
> > +        static bool __print_once;               \
> 
> You're still using the reserved namespace.  I asked you to fix that on v1;
> it's disappointing when a later revision doesn't make changes requested by a
> reviewers, without also offering a counter-argument for why the request does
> not need to be considered.

I am sorry.  It's totally because I forgot that one!  (It rarely
happens since I note them down in most cases, but there must be
something that even interrupted the procedure when I took notes...)

I will repost with another one soon.  Sorry again.

-- 
Peter Xu
