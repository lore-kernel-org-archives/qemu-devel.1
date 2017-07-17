Received: from eggs.gnu.org ([2001:4830:134:3::10]:36968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dWwNB-00008s-GZ
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dWwN8-0004I0-7t
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:07:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dWwN8-0004Gi-1l
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:06:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B60984E4D6
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:06:56 +0000 (UTC)
Date: Mon, 17 Jul 2017 11:06:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170717030657.GS27284@pxdev.xzpeter.org>
References: <1499842423-21101-1-git-send-email-peterx@redhat.com>
	<20170712190558.GK6020@localhost.localdomain>
	<20170714050423.GM27284@pxdev.xzpeter.org>
	<20170714160110.GF6020@localhost.localdomain>
	<20170714163210.GE2091@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170714163210.GE2091@work-vm>
Subject: Re: [Qemu-devel] [PATCH 0/3] migration: export cap/params to qdev
 props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>

On Fri, Jul 14, 2017 at 05:32:10PM +0100, Dr. David Alan Gilbert wrote:
> * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > On Fri, Jul 14, 2017 at 01:04:23PM +0800, Peter Xu wrote:
> > > On Wed, Jul 12, 2017 at 04:05:58PM -0300, Eduardo Habkost wrote:
> > > > On Wed, Jul 12, 2017 at 02:53:40PM +0800, Peter Xu wrote:
> > > > [...]
> > > > > These properties should only be used for debugging/testing purpose,
> > > > > and we should not guarantee any interface compatibility for them (just
> > > > > like HMP).
> > > > 
> > > > If we don't guarantee compatibility, the property names need to
> > > > be prefixed with "x-".
> > > 
> > > Indeed. Sorry I missed that.
> > > 
> > > But I'd say it is slightly awkward to add "x-" for all these (for me,
> > > "x-" means more like "this is not stable and experimental, use it
> > > carefully", while this does not suite for this series). Maybe I can
> > > just remove this sentence in commit log (I think I am just a little
> > > bit frightened by the compatibility problems)...
> > 
> > "x-" in property names doesn't mean "experimental", but just "not
> > part of the stable interface".  If you have the tiniest doubt
> > about command-line compatibility, I think it won't hurt to use
> > "x-".
> 
> We have:
>     DEFINE_PROP_MIG_CAP("xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> 
> so we could easily do:
>     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> 
> to ensure that all of the things we expose as props here have
> that added fealing of uncertainty but don't change what migration
> parameters see.

I was thinking to ask either you or Juan on what you would like for
this, looks like I got the answer now. :-) Let me add "x-" to them.

> 
> 
> (It's a shame we have to have those lists manually, there are so
> many manual places for each parameter and capability)

Temporarily I think it's still okay. But indeed you are right.

-- 
Peter Xu
