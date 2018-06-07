Received: from eggs.gnu.org ([2001:4830:134:3::10]:40066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fR1Ec-0006xI-SG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fR1EZ-0007ec-Jz
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:10:14 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fR1EZ-0007Gv-A2
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:10:11 -0400
References: <20180607184844.30126-1-richard.henderson@linaro.org>
	<20180607184844.30126-2-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <943b1ac4-171c-dfb6-c0c4-c458d69184b4@vivier.eu>
Date: Thu, 7 Jun 2018 22:10:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180607184844.30126-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] linux-user/alpha: Fix epoll syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 07/06/2018 à 20:48, Richard Henderson a écrit :
> These were named incorrectly, going so far as to invade strace.list.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/alpha/syscall_nr.h | 6 +++---
>  linux-user/strace.list        | 9 ---------
>  2 files changed, 3 insertions(+), 12 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
