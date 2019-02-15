Received: from eggs.gnu.org ([209.51.188.92]:33286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gugqv-0001ii-8c
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gugqu-000574-FO
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:41 -0500
Date: Fri, 15 Feb 2019 18:00:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190215170021.GE7941@localhost.localdomain>
References: <20190215134932.14492-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215134932.14492-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] commit: Replace commit_top_bs on failure
 after deleting the block job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 15.02.2019 um 14:49 hat Alberto Garcia geschrieben:
> If there's an error in commit_start() then the block job must be
> deleted before replacing commit_top_bs, otherwise it will fail because
> of lack of permissions. This happens since the permission system was
> introduced in 8dfba2797761d8a43744e4e6571c8175e448a478.
> 
> Fortunately this bug doesn't seem to be possible to reproduce at the
> moment without changing the code.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin
