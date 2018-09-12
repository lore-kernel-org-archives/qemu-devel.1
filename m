Received: from eggs.gnu.org ([2001:4830:134:3::10]:57001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1g04TR-00084j-Tt
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1g04TR-0002pD-A7
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:42:25 -0400
Date: Wed, 12 Sep 2018 08:42:15 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180912124215.GT22117@localhost.localdomain>
References: <cover.1536642773.git.jcody@redhat.com>
	<570e8585c94d6f1bd7406ce5d35f68a82b6ea28c.1536642773.git.jcody@redhat.com>
	<10f55c86-32dc-957a-c050-32a58baaddbd@redhat.com>
	<20180911183700.GQ22117@localhost.localdomain>
	<20180912103856.GC5846@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912103856.GC5846@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/rbd: Attempt to parse legacy
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

On Wed, Sep 12, 2018 at 12:38:56PM +0200, Kevin Wolf wrote:
> Am 11.09.2018 um 20:37 hat Jeff Cody geschrieben:
> > On Tue, Sep 11, 2018 at 02:22:31PM -0400, John Snow wrote:
> > > Once we load the image, will the header get rewritten into a compliant
> > > format?
> > 
> > Hmm - I think in some code paths, but not all.  I don't think the answer is
> > 'yes' universally, alas.
> 
> Can't we explicitly call BdrvChildRole.update_filename() for all parents
> when we open a legacy filename? We'd just need to add the callback to
> child_file, which would propagate it to the parents of the format layer,
> and then just opening the image with a legacy backing file link once
> would fix the problem for this image.
>

Yes, that is a good idea.  I will spin a v5 with that added.
