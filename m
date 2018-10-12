Received: from eggs.gnu.org ([2001:4830:134:3::10]:56413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gB2Gj-0000fb-Me
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gB2Ge-0006hL-O6
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:34:37 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gB2Ge-0006ge-EK
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:34:32 -0400
References: <20181009184017.15675-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5ebf18e0-0911-b785-2dea-1c353395b846@vivier.eu>
Date: Fri, 12 Oct 2018 20:34:20 +0200
MIME-Version: 1.0
In-Reply-To: <20181009184017.15675-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/sparc/signal.c: Remove
 unnecessary comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>

On 09/10/2018 20:40, Peter Maydell wrote:
> Remove a comment suggesting that we need to call tb_flush()
> after writing the SPARC signal frame trampoline insns.
> This isn't necessary in QEMU, because (even if the guest
> architecture requires explicit icache maintenance) we
> ensure that memory writes result in invalidation of
> translated code from that memory.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Found (with grep) while looking at what parts of the tree call
> tb_flush()...
> 
>  linux-user/sparc/signal.c | 4 ----

Applied to my branch linux-user-for-3.1

Thanks,
Laurent
