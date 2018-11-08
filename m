Received: from eggs.gnu.org ([2001:4830:134:3::10]:53431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKgac-00005w-8E
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKgab-00084Q-Cx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:27:02 -0500
Date: Thu, 8 Nov 2018 10:26:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181108092640.GA6006@linux.fritz.box>
References: <20181011072135.588-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011072135.588-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/3] file-posix: Simplifications on
 image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 11.10.2018 um 09:21 hat Fam Zheng geschrieben:
> v5: Address Max's comments (Thanks for reviewing):
>     - Clean up after test done.
>     - Add rev-by to patch 1 and 2.
> 
> v4: Fix test on systems without OFD. [Patchew]
> 
> The first patch reduces chances of QEMU crash in unusual (but not unlikely)
> cases especially when used by Libvirt (see commit message).
> 
> The second patch halves fd for images.
> 
> The third adds some more test for patch one (would have caught the regression
> caused by v2).

Thanks, applied to the block branch.

Kevin
