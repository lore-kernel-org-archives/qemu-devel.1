Received: from eggs.gnu.org ([2001:4830:134:3::10]:56019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e5Bwt-00064j-Ml
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e5Bwq-0002jd-KS
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e5Bwq-0002iQ-EJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:37:24 -0400
Date: Thu, 19 Oct 2017 15:37:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171019143715.GI2281@work-vm>
References: <20171018174013.22709-1-dgilbert@redhat.com>
	<20171018174013.22709-5-dgilbert@redhat.com>
	<20171019143342.GF130425@orkuz.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019143342.GF130425@orkuz.home>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] migration: migrate-continue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Denemark <jdenemar@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, wangjie88@huawei.com, quintela@redhat.com, peterx@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

* Jiri Denemark (jdenemar@redhat.com) wrote:
> On Wed, Oct 18, 2017 at 18:40:10 +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > A new qmp command allows the caller to continue from a given
> > paused state.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ...
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index b56f95db64..3b50afa6e8 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -877,6 +877,23 @@
> >  { 'command': 'migrate_cancel' }
> >  
> >  ##
> > +# @migrate-continue:
> > +#
> > +# Continue migration when it's in a paused state.
> > +#
> > +# @state: The state the migration is currently expected to be in
> > +#
> > +# Returns: nothing on success
> > +# Since: 2.11
> > +# Example:
> > +#
> > +# -> { "execute": "migrate-continue" , "arguments":
> > +#      { "state": "pause-before-device" } }
> 
> This example still uses the old name, it should be
> 
>      -> { "execute": "migrate-continue" , "arguments":
>           { "state": "pre-switchover" } }

oops, thanks; fixed.

Dave

> > +# <- { "return": {} }
> > +##
> > +{ 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
> > +
> > +##
> >  # @migrate_set_downtime:
> >  #
> >  # Set maximum tolerated downtime for migration.
> 
> Jirka
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
