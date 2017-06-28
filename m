Received: from eggs.gnu.org ([2001:4830:134:3::10]:45757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ6s8-0001IG-Ty
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ6s5-0001VT-U5
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:54:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dQ6s5-0001VH-O9
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:54:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E77B37EBDB
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 06:54:39 +0000 (UTC)
Date: Wed, 28 Jun 2017 14:54:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170628065434.GF14652@pxdev.xzpeter.org>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-7-git-send-email-peterx@redhat.com>
	<9f1a393d-9cef-e18a-3336-91ded86f6afa@redhat.com>
	<20170627133644.GW12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170627133644.GW12152@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v6 06/10] migration: move only_migratable
 to MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 27, 2017 at 10:36:44AM -0300, Eduardo Habkost wrote:
> On Tue, Jun 27, 2017 at 06:15:37AM -0500, Eric Blake wrote:
> > On 06/26/2017 11:10 PM, Peter Xu wrote:
> > > One less global variable, and it does only matter with migration.
> > > 
> > > We keep the old "--only-migratable" option, but also now we support:
> > > 
> > >   -global migration.only-migratable=true
> > 
> > Does command line introspection work to see that this new spelling is
> > available?  If not, what else can we do to let libvirt learn that the
> > new form is preferred?
> 
> "only-migratable" will appear on the output of
> "device-list-properties typename=migration".  But although I think
> implementing this using global properties internally is nice, I'm unsure
> about making -global the recommended interface to configure this.

Could I ask why it may not good to use "-global" to configure it?

Actually if we can merge this series, there is planned work to expose
more migration parameters to the user, like: migration.postcopy,
migration.compression, migration.speed, etc. So before I post similar
patches like this to export more things, I would like to know whether
there is possible issue with it in general.  Thanks,

-- 
Peter Xu
