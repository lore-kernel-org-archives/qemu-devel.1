Received: from eggs.gnu.org ([2001:4830:134:3::10]:54056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cyqvt-0000qv-15
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cyqvs-0001uy-5n
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:25:57 -0400
Date: Fri, 14 Apr 2017 10:25:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170414022544.GA13992@lemon>
References: <20170314023933.12118-1-famz@redhat.com>
	<63a9a137-2709-f936-7c7a-f11ace8fdc51@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a9a137-2709-f936-7c7a-f11ace8fdc51@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 0/3] block: Backdoor to
 skip image locking in qemu-io/qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Cc: John Snow <jsnow@redhat.com>

On Thu, 04/13 21:14, John Snow wrote:
> 
> 
> On 03/13/2017 10:39 PM, Fam Zheng wrote:
> > Hi Kevin,
> > 
> > This tries to capture your idea to add a explicit command option in qemu-io and
> > qemu-img for user to specify "expect inconsistent data when reading image".
> > It's stored as a BDRV_O_ flag internally, I don't know if there is a cleaner
> > way or not.
> > 
> > It's depended on by image locking series because several test cases need to be
> > updated to use this flag.
> > 
> > Fam
> > 
> > Fam Zheng (3):
> >   block: Introduce BDRV_O_UNSAFE_READ
> >   qemu-img: Add --unsafe-read option to subcommands
> >   qemu-io: Add --unsafe-read option
> > 
> >  block/block-backend.c |   2 +-
> >  include/block/block.h |   1 +
> >  qemu-img.c            | 148 ++++++++++++++++++++++++++++++++++++++------------
> >  qemu-io.c             |  28 +++++++---
> >  4 files changed, 137 insertions(+), 42 deletions(-)
> > 
> 
> Month old with no replies or ping, DOA?

Yes, ping? :)

I reckon RFC patches were less prioritized in the happy busy freeze. But if no
objection shows up, this series will be integrated in the next version of imgae
locking series.

Fam
