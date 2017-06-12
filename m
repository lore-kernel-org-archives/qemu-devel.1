Received: from eggs.gnu.org ([2001:4830:134:3::10]:49549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKH71-0001mm-Je
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 00:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKH6y-00018W-Hc
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 00:37:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dKH6y-00017X-BN
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 00:37:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F41383F40
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 04:37:55 +0000 (UTC)
Date: Mon, 12 Jun 2017 12:37:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170612043750.GD25059@pxdev.xzpeter.org>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-7-git-send-email-peterx@redhat.com>
	<b940fab8-7069-000a-acc7-88d70844c21c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b940fab8-7069-000a-acc7-88d70844c21c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] migration: move skip_section_footers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Fri, Jun 09, 2017 at 05:47:09AM -0500, Eric Blake wrote:
> On 06/08/2017 10:49 PM, Peter Xu wrote:
> > Move it into MigrationState, with a property binded to it. Same trick is
> 
> s/binded/bound/

Will fix. Thanks Eric. :)

> 
> > played like previous patches.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 




-- 
Peter Xu
