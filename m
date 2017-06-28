Received: from eggs.gnu.org ([2001:4830:134:3::10]:46272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ6vO-000231-TB
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ6vL-0002BZ-T4
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:58:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dQ6vL-0002A6-NS
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:58:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0A0D3DBDD
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 06:58:02 +0000 (UTC)
Date: Wed, 28 Jun 2017 14:57:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170628065758.GG14652@pxdev.xzpeter.org>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-2-git-send-email-peterx@redhat.com>
	<20170627145507.GY12152@localhost.localdomain>
	<a5b994d8-3e87-379b-65b6-f7c7e6946a80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5b994d8-3e87-379b-65b6-f7c7e6946a80@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 01/10] machine: export
 register_compat_prop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 27, 2017 at 10:05:54AM -0500, Eric Blake wrote:
> On 06/27/2017 09:55 AM, Eduardo Habkost wrote:
> 
> >> + *
> >> + * The property values set using this function must be always valid and
> >> + * never report setter errors, as they property have
> > 
> > Typo (my fault, sorry).  It should be "the property have", or "the
> > property will have".
> > 
> 
> "the property will have"

Thanks Eduardo & Eric for reviewing. I suppose this series will go
through Juan's tree if finally proper? Anyway, please anyone let me
know if we need a repost.

> 
> > With this fixed (which may be done manually by the maintainer when
> > applying):
> > 
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Peter Xu
