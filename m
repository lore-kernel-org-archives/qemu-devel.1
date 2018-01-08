Received: from eggs.gnu.org ([2001:4830:134:3::10]:39227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYe30-0004CR-Bb
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYe1h-0002xE-Co
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:29:30 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:41129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYe1h-0002wV-0r
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:28:09 -0500
Received: by mail-pf0-x241.google.com with SMTP id j3so2951095pfh.8
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 12:28:08 -0800 (PST)
References: <1515286904-86418-1-git-send-email-riemensberger@cadami.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cefe5369-bb7b-d9c0-6e91-c47cdd60e96c@linaro.org>
Date: Mon, 8 Jan 2018 12:28:05 -0800
MIME-Version: 1.0
In-Reply-To: <1515286904-86418-1-git-send-email-riemensberger@cadami.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user/mmap.c: Avoid choosing NULL
 as start address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maximilian Riemensberger <riemensberger@cadami.net>, qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 01/06/2018 05:01 PM, Maximilian Riemensberger wrote:
> mmap() is required by the linux kernel ABI and POSIX to return a
> non-NULL address when the implementation chooses a start address for the
> mapping.
> 
> The current implementation of mmap_find_vma_reserved() can return NULL
> as start address of a mapping which leads to subsequent crashes inside
> the guests glibc, e.g. output of qemu-arm-static --strace executing a
> test binary stx_test:
> 
>     1879 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|0x20000,-1,0) = 0x00000000
>     1879 write(2,0xf6fd39d0,79) stx_test: allocatestack.c:514: allocate_stack: Assertion `mem != NULL' failed.
> 
> This patch fixes mmap_find_vma_reserved() by skipping NULL as start
> address while searching for a suitable mapping start address.
> 
> CC: Riku Voipio <riku.voipio@iki.fi>
> CC: Laurent Vivier <laurent@vivier.eu>
> CC: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Maximilian Riemensberger <riemensberger@cadami.net>
> ---
> Changes since v1:
>     - Applied feedback from Laurent Vivier

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
