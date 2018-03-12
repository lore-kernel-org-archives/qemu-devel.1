Received: from eggs.gnu.org ([2001:4830:134:3::10]:39353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evQP0-0004Ob-Cw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evQOz-0001Yy-JD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:34:22 -0400
Date: Mon, 12 Mar 2018 17:34:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180312163407.GI31537@localhost.localdomain>
References: <20180312150218.1314-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312150218.1314-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] luks: Implement .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Am 12.03.2018 um 16:02 hat Kevin Wolf geschrieben:
> This series implements the .bdrv_co_create callback for luks, adds an
> image creation test for it and contains some bonus fixes for bugs that
> the test triggered.
> 
> v2:
> - Use QCryptoBlockCreateOptionsLUKS as the base type for
>   BlockdevCreateOptionsLUKS [Dan]
> - Use INT64_MAX instead of UINT64_MAX as the maximum image size [Eric]
> - Use iter_time=10 in tests where the creation succeeds [Dan]

Thanks for the review, applied to the block branch now.

Kevin
