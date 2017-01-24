Received: from eggs.gnu.org ([2001:4830:134:3::10]:48452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVzvL-0005Nu-Pf
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVzvL-0002LM-0W
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:10:07 -0500
Date: Tue, 24 Jan 2017 20:09:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170124120957.GC13714@lemon.Home>
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
	<20170122142959.GA12419@lemon.Home>
	<ff2fd02a-09ea-a28f-eb6e-e1858efff552@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2fd02a-09ea-a28f-eb6e-e1858efff552@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] scsi-generic and BLKSECTGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mreitz@redhat.com, kwolf@redhat.com
Cc: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, 01/24 12:23, Paolo Bonzini wrote:
> 
> 
> On 22/01/2017 15:29, Fam Zheng wrote:
> > On Fri, 01/20 17:25, Eric Farman wrote:
> >> Changes:
> >>  v2->v3:
> >>   - Move byte/sector conversions to patch 2 [Fam Zheng]
> >>   - Rename "max_sectors" when holding a byte value [Fam Zheng]
> >>  v1->v2:
> >>   - Patch 3, make hdev_get_max_transfer_length return bytes [Fam Zheng]
> > 
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> 
> Looks good, who's merging this? :)

All I know is not me :) Adding Kevin and Max who maintain block/file-posix.c.

Fam
