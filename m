Received: from eggs.gnu.org ([2001:4830:134:3::10]:53618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCmwO-0001sm-PY
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCmwN-0008HM-TE
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:36:52 -0400
Date: Wed, 17 Oct 2018 16:36:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181017143643.GF31479@localhost.localdomain>
References: <20181016170938.29303-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016170938.29303-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] block/vhdx: Don't take address of fields
 in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Jeff Cody <codyprime@gmail.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 16.10.2018 um 19:09 hat Peter Maydell geschrieben:
> Taking the address of a field in a packed struct is a bad idea, because
> it might not be actually aligned enough for that pointer type (and
> thus cause a crash on dereference on some host architectures). Newer
> versions of clang warn about this. Avoid the bug by not using the
> "modify in place" byte swapping functions.
> 
> There are a few places where the in-place swap function is
> used on something other than a packed struct field; we convert
> those anyway, for consistency.
> 
> Patch produced with scripts/coccinelle/inplace-byteswaps.cocci.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Usual disclaimer: produced with "make check" only, but purely
> automated conversion should be safe.

More relevant, qemu-iotests for vhdx passes, too. I don't think "make
check" would run any of the modified code.

Thanks, applied to the block branch

Kevin
