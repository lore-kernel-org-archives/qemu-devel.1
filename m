Received: from eggs.gnu.org ([2001:4830:134:3::10]:61000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMvsl-0004xB-K4
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMvsf-00072Q-So
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:11:03 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:36953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gMvsf-00071n-KG
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:10:57 -0500
References: <1542202628-6538-1-git-send-email-stefan.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bbd30407-51c9-1719-f3e3-baf22d7ebe7f@vivier.eu>
Date: Wed, 14 Nov 2018 15:09:50 +0100
MIME-Version: 1.0
In-Reply-To: <1542202628-6538-1-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Update MIPS specific prctl()
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: smarkovic@wavecomp.com, riku.voipio@iki.fi, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, aurelien@aurel32.net

On 14/11/2018 14:37, Stefan Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Perform needed checks before actual prctl() PR_SET_FP_MODE and
> PR_GET_FP_MODE work based on kernel implementation. Also, update
> necessary hflags.
> 
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>

I think it's better if you send the patch with the email address of the
S-o-b.

> ---
>  linux-user/syscall.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

If you plan to do a MIPS p-r before the next RC, don't hesitate to add
this patch to it (my linux-user queue is empty for the moment).

Thanks,
Laurent
