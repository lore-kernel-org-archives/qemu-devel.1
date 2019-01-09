Received: from eggs.gnu.org ([209.51.188.92]:56718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghHMZ-0007xM-IJ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghHMX-00045k-DN
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:09:55 -0500
Date: Wed, 9 Jan 2019 18:09:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109170929.GJ4867@localhost.localdomain>
References: <20190108194552.45453-1-vsementsov@virtuozzo.com>
	<20190109112311.GB4867@localhost.localdomain>
	<5ddd78e0-90ed-a6e5-c454-f1a2e44c1a37@redhat.com>
	<20190109165111.GI4867@localhost.localdomain>
	<61f6ac4d-91ab-f9cb-67e5-e0f5ce17524d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61f6ac4d-91ab-f9cb-67e5-e0f5ce17524d@redhat.com>
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

Am 09.01.2019 um 17:55 hat Paolo Bonzini geschrieben:
> On 09/01/19 17:51, Kevin Wolf wrote:
> > Am 09.01.2019 um 17:42 hat Paolo Bonzini geschrieben:
> >> On 09/01/19 12:23, Kevin Wolf wrote:
> >>> Also note that this is only metadata preallocation; full preallocation
> >>> will still return allocated for the protocol layer and so it will always
> >>> be slow.
> >>
> >> Full preallocation these days can create images with preallocated but
> >> known-zero blocks, I think?
> > 
> > That would defeat one of the main purposes of preallocation because it
> > would still require COW and metadata updates on the first write.
> 
> Sorry I mean at the protocol level, like FALLOC_FL_ZERO_RANGE.  It would
> still require metadata updates on the filesystem level, unlike "real"
> full preallocation, but no qcow2 metadata updates.

preallocation=full doesn't do that. preallocation=falloc is more like
it, though that is just posix_fallocate(), not FALLOC_FL_ZERO_RANGE. But
when called on a new file, it might result in the same thing? Not sure.

Kevin
