Received: from eggs.gnu.org ([2001:4830:134:3::10]:58004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXSat-0003uh-Jr
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXSas-0001tK-Rt
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:31:19 -0400
Date: Tue, 18 Jul 2017 15:31:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170718133108.GA4320@noname.str.redhat.com>
References: <20170718003422.4497-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718003422.4497-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/2] qemu-img: Check for backing image
 if specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

Am 18.07.2017 um 02:34 hat John Snow geschrieben:
> We do not currently guarantee that QEMU will or will not open a
> backing file when creating a new overlay file. Presently, QEMU will
> not open that file if you provide a filesize, because it has no reason
> to want to open it in that case.
> 
> This series makes the contract more explicit: if '-u' is provided to
> create, we will not open the backing image regardless, erroring out if
> a size was not provided.
> 
> In the other case, if '-u' is not provided, we now endeavor to open the
> backing image if possible to check that it exists. For now, if a size
> is provided and the image does not exist, QEMU will only warn to maintain
> compatibility with legacy behavior.
> 
> In the future, QEMU may treat the operation as a failure if '-u' was not
> provided.
> 
> Tests are amended primarily to pass the '-u' flag where it makes sense;
> which is when creating overlays for objects already open by QEMU. These
> will now generally fail to succeed because of image locking. In this
> case, they only warn instead of fail, but this keeps the output cleaner.
> 
> Test 111 is updated to accommodate a new error message.
> 082, 085, 139, 156 and 158 add '-u' just to suppress warnings.

Thanks, applied to the block branch.

Kevin
