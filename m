Received: from eggs.gnu.org ([2001:4830:134:3::10]:36884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fq7VT-00033o-7k
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fq7VM-0006ec-Ue
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:55:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fq7VJ-0006dH-IA
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:55:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AFE7407606B
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 01:55:12 +0000 (UTC)
Date: Thu, 16 Aug 2018 09:55:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180816015504.GE2708@xz-mi>
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-12-peterx@redhat.com>
	<82ab9863-6c03-ccbe-e2d1-b03dcc8c636b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82ab9863-6c03-ccbe-e2d1-b03dcc8c636b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 11/13] tests: remove "0.15" prefix for
 test-qmp-cmds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Aug 15, 2018 at 03:48:57PM +0200, Thomas Huth wrote:
> On 08/15/2018 03:37 PM, Peter Xu wrote:
> > The "0.15" prefix seems useless.  Remove them.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/test-qmp-cmds.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> > index ba41a6161e..989819b26d 100644
> > --- a/tests/test-qmp-cmds.c
> > +++ b/tests/test-qmp-cmds.c
> > @@ -286,11 +286,11 @@ int main(int argc, char **argv)
> >  {
> >      g_test_init(&argc, &argv, NULL);
> >  
> > -    g_test_add_func("/0.15/dispatch_cmd", test_dispatch_cmd);
> > -    g_test_add_func("/0.15/dispatch_cmd_failure", test_dispatch_cmd_failure);
> > -    g_test_add_func("/0.15/dispatch_cmd_io", test_dispatch_cmd_io);
> > -    g_test_add_func("/0.15/dealloc_types", test_dealloc_types);
> > -    g_test_add_func("/0.15/dealloc_partial", test_dealloc_partial);
> > +    g_test_add_func("/dispatch_cmd", test_dispatch_cmd);
> > +    g_test_add_func("/dispatch_cmd_failure", test_dispatch_cmd_failure);
> > +    g_test_add_func("/dispatch_cmd_io", test_dispatch_cmd_io);
> > +    g_test_add_func("/dealloc_types", test_dealloc_types);
> > +    g_test_add_func("/dealloc_partial", test_dealloc_partial);
> 
> Most other tests use a common prefix, so maybe rather replace the "0.15"
> with "qmp-cmd" here? E.g.:
> 
>  g_test_add_func("/qmp-cmd/dispatch_cmd", test_dispatch_cmd);
> 
> ?

I'll drop this patch due to a dup in master.  That one has "/qmp"
prefix.  Thanks Thomas.

-- 
Peter Xu
