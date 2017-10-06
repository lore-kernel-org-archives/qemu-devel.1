Received: from eggs.gnu.org ([2001:4830:134:3::10]:44144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0RZy-0005GU-T2
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0RZy-0005RP-2R
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:18:10 -0400
Date: Fri, 6 Oct 2017 14:17:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171006121755.GC4325@localhost.localdomain>
References: <20171005190248.5537-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171005190248.5537-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] block: Avoid copy-on-read assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

Am 05.10.2017 um 21:02 hat Eric Blake geschrieben:
> During my quest to switch block status to be byte-based, John
> forced me to evaluate whether we have a situation during
> copy-on-read where we could exceed BDRV_REQUEST_MAX_BYTES [1].
> Sure enough, we have a number of pre-existing bugs in the
> copy-on-read code.  Fix those, along with adding a test.
> 
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-copy-on-read-v3
> 
> Since v2 (available at [2]):
> - add a new patch to fix an iotests wart
> - tweak patch 5 (now 6) to skip rather than fail on limited memory [patchew]
> - tweak patch 2 condition for legibility [Stefan]
> - add R-b

Thanks, applied to the block branch.

Kevin
