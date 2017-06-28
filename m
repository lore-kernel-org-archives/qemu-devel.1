Received: from eggs.gnu.org ([2001:4830:134:3::10]:35169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQHxJ-0003Dy-0M
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQHxI-0007aP-99
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:44:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dQHxI-0007a9-3C
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:44:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 08AA87CE09
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 18:44:47 +0000 (UTC)
Date: Wed, 28 Jun 2017 15:44:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170628184441.GL12152@localhost.localdomain>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-8-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498536619-14548-8-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 07/10] migration: move
 skip_configuration out
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

On Tue, Jun 27, 2017 at 12:10:16PM +0800, Peter Xu wrote:
> It was in SaveState but now moved to MigrationState altogether, reverted
> its meaning, then renamed to "send_configuration". Again, using
> HW_COMPAT_2_3 for old PC/SPAPR machines, and accel_register_prop() for
> xen_init().
> 
> Removing savevm_skip_configuration().
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
