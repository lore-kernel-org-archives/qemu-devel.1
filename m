Received: from eggs.gnu.org ([2001:4830:134:3::10]:53529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eOdVL-0005SU-Df
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eOdVG-0004hS-JK
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:53:23 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eOdVG-0004gw-CY
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:53:18 -0500
Received: by mail-pg0-x244.google.com with SMTP id y6so12725292pgp.4
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 21:53:17 -0800 (PST)
References: <1512752248-17857-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <089717fa-9e7e-fe79-3315-ccc13c01de8d@linaro.org>
Date: Mon, 11 Dec 2017 21:53:13 -0800
MIME-Version: 1.0
In-Reply-To: <1512752248-17857-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sparc: Make sure we mmap at SHMLBA
 alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, patches@linaro.org

On 12/08/2017 08:57 AM, Peter Maydell wrote:
> SPARC Linux has an oddity that it insists that mmap()
> of MAP_FIXED memory must be at an alignment defined by
> SHMLBA, which is more aligned than the page size
> (typically, SHMLBA alignment is to 16K, and pages are 8K).
> This is a relic of ancient hardware that had cache
> aliasing constraints, but even on modern hardware the
> kernel still insists on the alignment.
> 
> To ensure that we get mmap() alignment sufficient to
> make the kernel happy, change QEMU_VMALLOC_ALIGN,
> qemu_fd_getpagesize() and qemu_mempath_getpagesize()
> to use the maximum of getpagesize() and SHMLBA.
> 
> In particular, this allows 'make check' to pass on Sparc:
> we were previously failing the ivshmem tests.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
