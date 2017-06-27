Received: from eggs.gnu.org ([2001:4830:134:3::10]:33351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPqfl-0004rP-Fh
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPqfi-0006yy-AB
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:36:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPqfi-0006yT-4V
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:36:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B30305AFC8
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 13:36:48 +0000 (UTC)
Date: Tue, 27 Jun 2017 10:36:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170627133644.GW12152@localhost.localdomain>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-7-git-send-email-peterx@redhat.com>
	<9f1a393d-9cef-e18a-3336-91ded86f6afa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f1a393d-9cef-e18a-3336-91ded86f6afa@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 27, 2017 at 06:15:37AM -0500, Eric Blake wrote:
> On 06/26/2017 11:10 PM, Peter Xu wrote:
> > One less global variable, and it does only matter with migration.
> > 
> > We keep the old "--only-migratable" option, but also now we support:
> > 
> >   -global migration.only-migratable=true
> 
> Does command line introspection work to see that this new spelling is
> available?  If not, what else can we do to let libvirt learn that the
> new form is preferred?

"only-migratable" will appear on the output of
"device-list-properties typename=migration".  But although I think
implementing this using global properties internally is nice, I'm unsure
about making -global the recommended interface to configure this.

-- 
Eduardo
