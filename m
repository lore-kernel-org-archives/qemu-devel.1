Received: from eggs.gnu.org ([2001:4830:134:3::10]:35827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDXbo-0000Jt-2s
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDXbk-0004Ek-TA
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:26:44 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35879)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gDXbk-0004CA-Fz
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:26:40 -0400
References: <20181019161715.12122-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7d7f51e2-49fa-7fc9-4d6d-153fa9cff5c5@vivier.eu>
Date: Fri, 19 Oct 2018 18:26:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181019161715.12122-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Remove dead error-checking code
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

Le 19/10/2018 à 18:17, Peter Maydell a écrit :
> Remove some dead code spotted by Coverity (CID 1009855,
> 1390854, 1390847). The underlying cause in all these cases
> is the same: QEMU's put_user operations can't result in
> errors, but the kernel's equivalent does. So when code
> was copied from the kernel signal-frame-setup/teardown
> code, checks on error flags that were needed in the kernel
> became dead code for us.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/m68k/signal.c  | 3 ---
>  linux-user/sh4/signal.c   | 4 ----
>  linux-user/sparc/signal.c | 2 --
>  3 files changed, 9 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
