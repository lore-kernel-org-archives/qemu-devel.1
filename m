Received: from eggs.gnu.org ([2001:4830:134:3::10]:52100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fs9pv-0004Cx-UU
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fs9dM-0000pN-V2
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:36:00 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fs9dK-0000mE-PO
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:35:56 -0400
References: <20180818190118.12911-1-richard.henderson@linaro.org>
	<20180818190118.12911-7-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <cfe15e0a-eb3f-a814-2f56-36e4822b8471@vivier.eu>
Date: Tue, 21 Aug 2018 18:35:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180818190118.12911-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 06/16] linux-user: Propagate goto
 unimplemented to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 18/08/2018 à 21:01, Richard Henderson a écrit :
> There is no point in listing a syscall if you want the same effect as
> not listing it.  In one less trivial case, the goto was demonstrably
> not reachable.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 144 +------------------------------------------
>  1 file changed, 1 insertion(+), 143 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
