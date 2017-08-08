Received: from eggs.gnu.org ([2001:4830:134:3::10]:50362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfCqM-0004px-Ig
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfCqI-0003j4-9i
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:19:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfCqI-0003i4-2n
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:19:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAEE75F795
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 22:19:10 +0000 (UTC)
Date: Wed, 9 Aug 2017 01:18:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170809011652-mutt-send-email-mst@kernel.org>
References: <20170808203900.7661-1-jfreimann@redhat.com>
	<f10f4722-1d0b-0793-c837-5915ed70d65a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f10f4722-1d0b-0793-c837-5915ed70d65a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10? v2 0/5] tests/pxe-test: add
 testcase using vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org, victork@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, stefanha@redhat.com, marcandre.lureau@redhat.com

On Tue, Aug 08, 2017 at 04:05:56PM -0500, Eric Blake wrote:
> On 08/08/2017 03:38 PM, Jens Freimann wrote:
> > This implements a testcase for pxe-test using the vhost-user interface. Spawn a
> > vhost-user-bridge process and connect it to the qemu process.
> > 
> > To make the testcase work we need to apply a few patches before the actual testcase:
> > - Patch 1 disables debug output of vhost-user-bridge
> > - Patch 2 fixes passing a file descriptor to -netdev.  This was broken since the
> >   mcast option was introduced. 
> 
> Is this a regression worthy of fixing in rc3?  Or are we okay with this
> entire series waiting for 2.11.

I'd say patches 2-4 at least are bugfixes. Is patch 5 worth including?
I'm split on this, to me it does seem very important that we include
a proper testcase for vhost-user, otherwise it's possible that downstreams
ship a non-working version.

I'll think about it over night.

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
