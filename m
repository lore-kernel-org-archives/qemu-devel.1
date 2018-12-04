Received: from eggs.gnu.org ([2001:4830:134:3::10]:34146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gU9aC-0005HZ-Jq
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gU9XT-0004C9-T5
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:10:56 -0500
Date: Tue, 4 Dec 2018 12:10:41 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181204121041.GT14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-14-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-14-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 13/18] xen: purge 'blk' and 'ioreq' from
 function names in dataplane/xen-qdisk.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Nov 21, 2018 at 03:12:06PM +0000, Paul Durrant wrote:
> This is a purely cosmetic patch that purges remaining use of 'blk' and
> 'ioreq' in local function names.
> 
> No functional change.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

I don't think it's a good idee to use function names that could be use
elsewhere, don't have a namespace. It makes it more difficult to figure
out which function is called by just searching for the function name.

Could you had a prefix?
Maybe xendisk_ or xen_disk or xen_qdisk or xen_block or ..., so we can
have xendisk_start_request, or xendisk_request_start. I don't have a
preference beside staying away from generic names.

Thanks,

-- 
Anthony PERARD
