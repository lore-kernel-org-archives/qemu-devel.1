Received: from eggs.gnu.org ([209.51.188.92]:59720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hB8E4-0000xy-CX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 21:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hB8E1-0006xJ-Ty
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 21:28:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:40973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hB8Dp-0006cP-5Y
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 21:28:29 -0400
Received: by mail-pl1-x634.google.com with SMTP id d1so3679156plj.8
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 18:28:16 -0700 (PDT)
References: <20190401220752.22577-1-stephen.checkoway@oberlin.edu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <af4fdce2-10f2-de5d-d2b9-93b86e9443a6@linaro.org>
Date: Tue, 2 Apr 2019 08:28:10 +0700
MIME-Version: 1.0
In-Reply-To: <20190401220752.22577-1-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] capstone: Support capstone/capstone.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-devel@nongnu.org

On 4/2/19 5:07 AM, Stephen Checkoway wrote:
> Starting with version 4 of capstone, the header files live in the
> `$prefix/include/capstone` directory.
> 
> This modifies the configure script to check for <capstone/capstone.h> if
> <capstone.h> cannot be found.
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
>  configure                | 9 +++++++++
>  include/disas/capstone.h | 4 ++++
>  2 files changed, 13 insertions(+)

Thanks.  We should probably update our submodule to the v4 release as well.


r~
