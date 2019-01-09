Received: from eggs.gnu.org ([209.51.188.92]:51079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghH4s-0001Iu-4G
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghH4r-0003cK-4c
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:51:38 -0500
Date: Wed, 9 Jan 2019 17:51:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109165111.GI4867@localhost.localdomain>
References: <20190108194552.45453-1-vsementsov@virtuozzo.com>
	<20190109112311.GB4867@localhost.localdomain>
	<5ddd78e0-90ed-a6e5-c454-f1a2e44c1a37@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ddd78e0-90ed-a6e5-c454-f1a2e44c1a37@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: add rough-block-status
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, den@openvz.org

Am 09.01.2019 um 17:42 hat Paolo Bonzini geschrieben:
> On 09/01/19 12:23, Kevin Wolf wrote:
> > Also note that this is only metadata preallocation; full preallocation
> > will still return allocated for the protocol layer and so it will always
> > be slow.
> 
> Full preallocation these days can create images with preallocated but
> known-zero blocks, I think?

That would defeat one of the main purposes of preallocation because it
would still require COW and metadata updates on the first write.

If there is demand, we could add something like preallocation=data where
data clusters are preallocated but COW/metadata updates still happen at
runtime, but so far nobody has asked for it. Not sure when you would use
it either.

Kevin
