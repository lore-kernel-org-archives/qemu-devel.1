Received: from eggs.gnu.org ([2001:4830:134:3::10]:48645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft4At-0003v8-3N
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft4Ap-0005n2-3e
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:58:19 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ft4Ao-0005mW-Tg
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:58:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id c6-v6so566849pls.4
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 21:58:14 -0700 (PDT)
References: <20180823222215.13781-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7862ca2e-d802-be4c-8d72-b049ded4669a@linaro.org>
Date: Thu, 23 Aug 2018 21:58:11 -0700
MIME-Version: 1.0
In-Reply-To: <20180823222215.13781-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: move TargetFdTrans functions
 to their own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 08/23/2018 03:22 PM, Laurent Vivier wrote:
> This will ease to move out syscall functions from syscall.c
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/Makefile.objs |    2 +-
>  linux-user/fd-trans.c    | 1408 ++++++++++++++++++++++++++++++++++++
>  linux-user/fd-trans.h    |   97 +++
>  linux-user/syscall.c     | 1448 +-------------------------------------
>  4 files changed, 1507 insertions(+), 1448 deletions(-)
>  create mode 100644 linux-user/fd-trans.c
>  create mode 100644 linux-user/fd-trans.h

Thanks for this.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
