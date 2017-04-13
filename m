Received: from eggs.gnu.org ([2001:4830:134:3::10]:60677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyahR-0007Rn-6p
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyahO-0005wu-2z
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:05:57 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170413090210.GA5095@noname.redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<5cb5f7fb-aadd-d8b5-7cf5-d677db045105@redhat.com>
	<w51fuhdkdbg.fsf@maestria.local.igalia.com>
	<b1a0b5a7-4528-eba8-630e-dd80bc8c26d2@redhat.com>
	<w51y3v4vijw.fsf@maestria.local.igalia.com>
	<20170413090210.GA5095@noname.redhat.com>
Date: Thu, 13 Apr 2017 11:05:49 +0200
Message-ID: <w51vaq8vfrm.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] Proposed qcow2 extension:
 subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On Thu 13 Apr 2017 11:02:10 AM CEST, Kevin Wolf <kwolf@redhat.com> wrote:
> I think you still need it if you don't want to look at the refcount
> blocks for every write. When you take an internal snapshot, you just
> increase the refcount of the L2 tables at first and keep the contents
> the same, including the subcluster information. On the first write to
> the cluster, like with normal images you need to copy the whole
> cluster, and whether this is the case is determined with the COPIED
> flag. (The copy can actually keep unallocated/zeroed subclusters that
> way, but data has to be copied for the whole cluster.)
>
> Of course, in all cases the COPIED flag is just an optimisation
> because it's always possible to look at the refcount blocks, but I
> don't think there is any difference between subclustered and
> traditional images in this respect.

Exactly :)

Berto
