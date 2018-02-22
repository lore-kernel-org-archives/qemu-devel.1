Received: from eggs.gnu.org ([2001:4830:134:3::10]:60176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eosJX-00040g-Di
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eosJR-0001As-U2
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:57:39 -0500
Date: Thu, 22 Feb 2018 15:57:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180222145721.GJ4147@localhost.localdomain>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-7-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205151835.20812-7-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 06/26] block: Make path_combine() return
 the path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

Am 05.02.2018 um 16:18 hat Max Reitz geschrieben:
> Besides being safe for arbitrary path lengths, after some follow-up
> patches all callers will want a freshly allocated buffer anyway.
> 
> In the meantime, path_combine_deprecated() is added which has the same
> interface as path_combine() had before this patch. All callers to that
> function will be converted in follow-up patches.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
