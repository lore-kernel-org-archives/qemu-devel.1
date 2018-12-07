Received: from eggs.gnu.org ([2001:4830:134:3::10]:56027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVEzj-0003WV-GE
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVEzi-0008Sg-Mw
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:12:35 -0500
Date: Fri, 7 Dec 2018 13:12:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181207121225.GC5119@linux.fritz.box>
References: <20181205084308.201356-1-borntraeger@de.ibm.com>
	<e8aa64c4-4bfa-05e6-9a2f-6478330a6fd7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8aa64c4-4bfa-05e6-9a2f-6478330a6fd7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] iotests: make 235 work on s390 (and
 others)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

Am 05.12.2018 um 16:34 hat Eric Blake geschrieben:
> On 12/5/18 2:43 AM, Christian Borntraeger wrote:
> > "-machine pc" will not work all architectures. Lets fall back to the
> > default machine by not specifying it.
> > 
> > In addition we also need to specify -no-shutdown on s390 as qemu will
> > exit otherwise.
> > 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> CC: qemu-stable
> 
> > ---
> >   tests/qemu-iotests/235 | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Too late for 3.1; for that, we can just document that there are known
> iotests failures under some configurations

Thanks, applied to the block-next branch.

Kevin
