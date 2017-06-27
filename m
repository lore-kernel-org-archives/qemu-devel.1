Received: from eggs.gnu.org ([2001:4830:134:3::10]:57127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPrxw-0002mK-Cc
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPrxs-0003x3-B9
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPrxs-0003ue-5V
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:59:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C22FC045758
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 14:59:39 +0000 (UTC)
Date: Tue, 27 Jun 2017 11:59:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170627145930.GB12152@localhost.localdomain>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-5-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498536619-14548-5-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 04/10] migration: let MigrationState be
 a qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 27, 2017 at 12:10:13PM +0800, Peter Xu wrote:
> Let the old man "MigrationState" join the object family. Direct benefit
> is that we can start to use all the property features derived from
> current QDev, like: HW_COMPAT_* bits, command line setup for migration
> parameters (so will never need to set them up each time using HMP/QMP,
> this is really, really attractive for test writters), etc.
> 
> I see no reason to disallow this happen yet. So let's start from this
> one, to see whether it would be anything good.
> 
> Now we init the MigrationState struct statically in main() to make sure
> it's initialized after global properties are applied, since we'll use
> them during creation of the object.
> 
> No functional change at all.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
