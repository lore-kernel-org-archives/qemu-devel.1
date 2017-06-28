Received: from eggs.gnu.org ([2001:4830:134:3::10]:46616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ6yg-0003JV-ED
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ6yb-0003NO-UM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:01:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dQ6yb-0003NG-Op
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:01:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8306D3B74D
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 07:01:24 +0000 (UTC)
Date: Wed, 28 Jun 2017 15:01:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170628070117.GH14652@pxdev.xzpeter.org>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-5-git-send-email-peterx@redhat.com>
	<20170627144718.GX12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170627144718.GX12152@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 27, 2017 at 11:47:18AM -0300, Eduardo Habkost wrote:
> On Tue, Jun 27, 2017 at 12:10:13PM +0800, Peter Xu wrote:
> [...]
> > +
> > +static const TypeInfo migration_type = {
> > +    .name = TYPE_MIGRATION,
> > +    .parent = TYPE_DEVICE,
> 
> As TYPE_MIGRATION isn't really a device and we're using TYPE_DEVICE just
> to reuse the global property system, maybe we should add a comment here
> explaining that?
> 
> It would also be interesting to explain the TYPE_DEVICE features we do
> not use.  e.g.: the device is not created using qdev_create(), it is
> never attached to any bus, and it is never realized.
> 
> (But I don't think this should require a series respin.  The comment may
> be sent as a follow-up patch.)

Sure. Let me prepare another patch for it upon the series. Thanks,

-- 
Peter Xu
