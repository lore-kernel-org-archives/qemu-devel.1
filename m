Received: from eggs.gnu.org ([2001:4830:134:3::10]:34556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekA5s-0002ry-0Z
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekA5r-0005uT-8M
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:56:04 -0500
Date: Fri, 9 Feb 2018 15:55:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180209145537.GF3998@localhost.localdomain>
References: <20180209144222.8937-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209144222.8937-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Use g_try_realloc() in
 qcow2_expand_zero_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 09.02.2018 um 15:42 hat Alberto Garcia geschrieben:
> g_realloc() aborts the program if it fails to allocate the required
> amount of memory. We want to detect that scenario and return an error
> instead, so let's use g_try_realloc().
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin
