Received: from eggs.gnu.org ([2001:4830:134:3::10]:56077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eyhQO-0004kF-3u
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eyhQK-0003LJ-Vz
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:21:20 -0400
Date: Wed, 21 Mar 2018 18:20:39 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20180321172039.GB13477@grep.be>
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-2-vsementsov@virtuozzo.com>
	<af833096-cbc3-24db-0cf0-a446f231c5fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af833096-cbc3-24db-0cf0-a446f231c5fd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] nbd/server: refactor
 nbd_negotiate_meta_query for several namespaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, nbd list <nbd@other.debian.org>

On Wed, Mar 21, 2018 at 09:56:36AM -0500, Eric Blake wrote:
> no further qemu patches are submitted.  Is it worth me proposing a doc
> change to demonstrate what the difference would look like, along with
> corresponding qemu changes to match, to decide if including it in 2.12 is
> worth it?

If you're willing to spend the effort, I won't stop you :-) but I think the
pain of parsing a string once (during negotiation) is not that bad, and
I'm not too bothered about it.

Put otherwise, I'm not convinced that the downside (which I agree
exists) outweighs the downside of having to introduce yet another
command, or add some ugliness for backwards compat reasons.

But hey, go ahead, prove me wrong ;-)

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab
