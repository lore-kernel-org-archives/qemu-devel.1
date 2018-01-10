Received: from eggs.gnu.org ([2001:4830:134:3::10]:46791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZCQt-0002Q6-Uj
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZCQr-0000zy-9t
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:12:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZCQr-0000zR-2V
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:12:25 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3F91C04B94A
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 09:12:23 +0000 (UTC)
Date: Wed, 10 Jan 2018 17:12:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180110091218.GL5984@xz-mi>
References: <20180105215246.908-1-quintela@redhat.com>
	<20180110064252.GE5984@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180110064252.GE5984@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v4 00/11] Add make check tests for Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, Jan 10, 2018 at 02:42:52PM +0800, Peter Xu wrote:
> On Fri, Jan 05, 2018 at 10:52:35PM +0100, Juan Quintela wrote:
> > 
> > Hi
> > 
> > In v4:
> > 
> > Based-on: 20180105205109.683-1-quintela@redhat.com
> > 
> > Changes:
> > - rebase on top on v4 info_migrate patches
> > - Tune sleeps to make patches fast
> > - Create a deprecated test for deprecated commands (i.e. make peterxu happy)
> > - create migrate_start_postcopy function
> > - fix naming/sizes between power and x86
> > - cleanup comments to match code
> > 
> > Please, review.
> 
> I left some comments on specific patches, for the rest I think the
> series looks good to me.  Thanks,

I believe Dave would be a better person to ack, but as a potential
user of the series (who wants to use it soon), I'd like to provide my
r-b before Dave provides (possibly) more comments, so:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
