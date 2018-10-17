Received: from eggs.gnu.org ([2001:4830:134:3::10]:58969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCnEp-00034N-AN
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCnEo-00038A-L4
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:55:55 -0400
Date: Wed, 17 Oct 2018 16:55:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181017145546.GG31479@localhost.localdomain>
References: <20181016172503.27814-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016172503.27814-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] block/vdi: Don't take address of fields in
 packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 16.10.2018 um 19:25 hat Peter Maydell geschrieben:
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
> There are other places where we take the address of a packed member
> in this file for other purposes than passing it to a byteswap
> function (all the calls to qemu_uuid_*()); we leave those for now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks, applied to the block branch.

Kevin
