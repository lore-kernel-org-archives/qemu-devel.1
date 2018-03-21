Received: from eggs.gnu.org ([2001:4830:134:3::10]:51940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eyfjU-0000Aq-BC
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eyfjQ-0000Ge-Hb
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:32:56 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180321150728.GB3898@localhost.localdomain>
References: <20180321133852.3560-1-berto@igalia.com>
	<20180321135238.GA3898@localhost.localdomain>
	<w51k1u5ikp2.fsf@maestria.local.igalia.com>
	<20180321150728.GB3898@localhost.localdomain>
Date: Wed, 21 Mar 2018 16:32:50 +0100
Message-ID: <w51h8p9igv1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] qcow2: Reset
 free_cluster_index when allocating a new refcount block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, jsnow@redhat.com

On Wed 21 Mar 2018 04:07:28 PM CET, Kevin Wolf wrote:
> I just remembered that when I looked at an image recently, I noticed
> that the refcount block wasn't in the first cluster and I disliked it,
> though mostly because it felt untidy rather than being a problem.

I don't think you can fix that in general. In my test case I'm writing
new data when the existing refcount block is already full, so we can
allocate the new one before the new data and keep everything tidy.

But if there are, say, two refcount entries available and you write four
data clusters you don't want the new refcount block in the middle of
those four clusters just to have it at the beginning :-)

> Having a qcow2 analysis script in the repo sounds like a good
> idea. John has something, too. Maybe we can check whether the two
> things complement each other and then check in a script that combines
> both (or if one provides a superset of the other, just check in that
> one).

I'll take a look.

Berto
