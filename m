Received: from eggs.gnu.org ([2001:4830:134:3::10]:60803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dOGSn-00054c-3f
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dOGSk-00005p-10
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45051)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dOGSj-000057-RT
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:44:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 616852EF183
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 04:44:51 +0000 (UTC)
Date: Fri, 23 Jun 2017 12:44:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170623044446.GD3936@pxdev.xzpeter.org>
References: <1498031528-1990-1-git-send-email-peterx@redhat.com>
	<1498031528-1990-3-git-send-email-peterx@redhat.com>
	<20170621122311.GC3928@thinpad.lan.raisama.net>
	<20170622042530.GB3936@pxdev.xzpeter.org>
	<20170622172852.GC20956@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170622172852.GC20956@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4 02/10] accel: introduce
 AccelClass.global_props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jun 22, 2017 at 02:28:52PM -0300, Eduardo Habkost wrote:
> On Thu, Jun 22, 2017 at 12:25:30PM +0800, Peter Xu wrote:
> > On Wed, Jun 21, 2017 at 09:23:11AM -0300, Eduardo Habkost wrote:
> > > On Wed, Jun 21, 2017 at 03:52:00PM +0800, Peter Xu wrote:
> [...]
> > > > diff --git a/vl.c b/vl.c
> > > > index 59fea15..4452d7a 100644
> > > > --- a/vl.c
> > > > +++ b/vl.c
> > > > @@ -4571,6 +4571,7 @@ int main(int argc, char **argv, char **envp)
> > > >              exit (i == 1 ? 1 : 0);
> > > >      }
> > > >  
> > > 
> > > I suggest a comment here warning about global property
> > > registration ordering.  e.g.:
> > > 
> > >  /*
> > >   * Ordering of global property registration matters:
> > >   * - machine compat_props should override accelerator-specific
> > >   *   globals.
> > >   * - user-provided globals (-global, and global properties
> > >   *   derived from other command-line options like -cpu) should
> > >   *   override machine compat_props and accelerator-specific
> > >   *   globals.
> > >   */
> > 
> > I have a standalone patch (next one) to unify these three places and
> > added some comment. Would that suite?
> 
> Sorry, I didn't see that patch when I was reviewing this one.  It looks
> good to me.  Thanks!

Got it. Let me respin to fix the other places.  Thanks!

-- 
Peter Xu
