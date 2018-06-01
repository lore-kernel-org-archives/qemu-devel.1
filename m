Received: from eggs.gnu.org ([2001:4830:134:3::10]:59032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOecD-0001BM-Mm
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOec9-0005Sq-Nb
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:36:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fOec9-0005R1-DN
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:36:45 -0400
References: <20180601073050.8054-1-richard.henderson@linaro.org>
	<20180601073050.8054-2-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b1a28b17-72a4-0500-8cdf-8d5f7c8896fb@vivier.eu>
Date: Fri, 1 Jun 2018 09:36:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180601073050.8054-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/33] linux-user: Split out do_syscall1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 01/06/2018 à 09:30, Richard Henderson a écrit :
> There was supposed to be a single point of return for do_syscall
> so that tracing works properly.  However, there are a few bugs
> in that area.  It is significantly simpler to simply split out
> an inner function to enforce this.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 89 +++++++++++++++++++++++++++-----------------
>  1 file changed, 54 insertions(+), 35 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
