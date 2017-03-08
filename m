Received: from eggs.gnu.org ([2001:4830:134:3::10]:60026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clX9E-0001fg-Oh
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clX9D-0001mD-Tv
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:40:40 -0500
Date: Wed, 8 Mar 2017 09:40:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170308084030.GA5211@noname.redhat.com>
References: <20170308025428.1037-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308025428.1037-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/10] add blkdebug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 08.03.2017 um 03:54 hat Eric Blake geschrieben:
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v6
> 
> v5 was:
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03042.html
> 
> Since then:
> - Rebase to master
> - Pull in Dan's patch that splits test 97 for qcow (patch 1)
> - Address comments from Kevin (includes creating new patch 2, 6)
> - Update patches to reflect that this is now 2.10 material, since it
> missed soft freeze and is not fixing a bug

I think if patches 1 and 2 pass review, we can take at least those into
2.9. Improving test cases is okay during the freeze (and obviously
fixing them is allowed anyway).

Kevin
