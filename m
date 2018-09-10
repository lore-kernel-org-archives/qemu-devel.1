Received: from eggs.gnu.org ([2001:4830:134:3::10]:43957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzNG2-0003DR-Qx
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzNFw-0006gh-Or
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:33:42 -0400
Date: Mon, 10 Sep 2018 16:33:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180910143323.GI4901@dhcp-200-186.str.redhat.com>
References: <20180813010729.4844-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813010729.4844-1-lbloch@janustech.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/8] Take the image size into account
 when allocating the L2 cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

Hi Leonid,

Am 13.08.2018 um 03:07 hat Leonid Bloch geschrieben:
> This series makes the qcow2 L2 cache assignment aware of the image size,
> with the intention for it to cover the entire image. The importance of
> this change is in noticeable performance improvement, especially with
> heavy random I/O. The memory overhead is not big in most cases, as only
> 1 MB of cache for every 8 GB of image size is used. For cases with very
> large images and/or small cluster sizes, or systems with limited RAM
> resources, there is an upper limit on the default L2 cache: 32 MB. To
> modify this limit one can use the already existing 'l2-cache-size' and
> 'cache-size' options. Moreover, this fixes the behavior of 'l2-cache-size',
> as it was documented as the *maximum* L2 cache size, but in practice
> behaved as the absolute size.
> 
> To compensate the memory overhead which may be increased following this
> behavior, the default cache-clean-interval is set to 10 minutes by default
> (was disabled by default before).
> 
> The L2 cache is also resized accordingly, by default, if the image is
> resized.

after digging through the most urgent part of my post-vacation backlog,
I saw this series again. It's been a while, but I don't think much is
missing, so let's get this finished now. :-)

We had some discussion in the v7 thread after you posted v8, and you
mentioned there that you'd do some changes in a v9 (at first sight, just
some test case stuff). Are you still planning to send that v9?

Kevin
