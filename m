Received: from eggs.gnu.org ([2001:4830:134:3::10]:47508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPJxL-0002OE-Ro
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 22:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPJxG-0002bk-Vs
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 22:40:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPJxG-0002bA-Pg
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 22:40:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE0914E4C4
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 02:40:45 +0000 (UTC)
Date: Mon, 26 Jun 2017 10:40:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170626024041.GG3936@pxdev.xzpeter.org>
References: <1498193206-18007-1-git-send-email-peterx@redhat.com>
	<1498193206-18007-4-git-send-email-peterx@redhat.com>
	<20170623213529.GD10776@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170623213529.GD10776@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v5 03/10] vl: clean up global property
 registerations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Jun 23, 2017 at 06:35:29PM -0300, Eduardo Habkost wrote:
> On Fri, Jun 23, 2017 at 12:46:39PM +0800, Peter Xu wrote:
> > It's not that clear on how the global properties are registered to
> > global_props (and also its priority relationship). Let's provide a
> > single function to be called in main() for that, with comment to explain
> > it a bit.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  vl.c | 29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/vl.c b/vl.c
> > index 4452d7a..cdd2ec8 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2969,6 +2969,25 @@ static int qemu_read_default_config_file(void)
> >      return 0;
> >  }
> >  
> > +static void user_register_compat_props(void)
> > +{
> > +    qemu_opts_foreach(qemu_find_opts("global"),
> > +                      global_init_func, NULL, NULL);
> 
> I suggest using "compat props" only when referring to global properties
> registered for internal use (because they help us ensure command-line
> compatibility).  User-provided global properties are just "global
> properties", not "compat props".

Agree. Fixing up. Thanks,

-- 
Peter Xu
