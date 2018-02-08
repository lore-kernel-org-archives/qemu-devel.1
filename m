Received: from eggs.gnu.org ([2001:4830:134:3::10]:57421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejfxB-0005VP-71
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 01:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejfx5-00048N-6n
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 01:45:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ejfx5-00045l-2B
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 01:44:59 -0500
Date: Thu, 8 Feb 2018 14:44:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180208064441.GA2677@xz-mi>
References: <20180124053957.29145-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 00/23] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jan 24, 2018 at 01:39:34PM +0800, Peter Xu wrote:
> This version should have addressed all comments in previous one, also
> fixed another race condition after I addressed all the comments (a new
> race condition introduced by addressing the comments...).  For some
> more details of the race condition, please see the last entry of
> change log, and please refer to patch 9 for the code change.
> 
> I removed RFC tag from this version.  Please review.  Thanks.

It's still a month there until the soft freeze of 2.12, but I would
still like to have a gentle ping for this series in case there will be
further surprises.  Hopefully, this series can catch the train for 2.12.

I'll respin the postcopy recovery series very soon.  Thanks,

-- 
Peter Xu
