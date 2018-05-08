Received: from eggs.gnu.org ([2001:4830:134:3::10]:53761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG9RP-0007Cx-10
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG9RL-0000EF-Ub
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:42:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fG9RL-0000DZ-KT
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:42:27 -0400
References: <20180508185520.23757-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e561ca57-1c93-5d9e-94f8-788ee0dce39e@vivier.eu>
Date: Tue, 8 May 2018 22:42:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180508185520.23757-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Fix build Werror with gcc
 8.0.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Le 08/05/2018 à 20:55, Richard Henderson a écrit :
> Fedora 28 ships with the released gcc 8.
> 
> The Werror stems from the compiler finding a path through the second
> switch via a missing default case in which src1 is uninitialized, and
> not being able to prove that the missing default case is unreachable
> due to the first switch.
> 
> Simplify the second switch to merge default with OS_LONG,
> which returns directly.  This removes the unreachable path.
> 
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/m68k/translate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
