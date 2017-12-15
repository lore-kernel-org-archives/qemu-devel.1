Received: from eggs.gnu.org ([2001:4830:134:3::10]:60019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ePr00-0006Wl-OI
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ePqzw-0002TV-P3
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:30:04 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ePqzw-0002Os-Ev
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:30:00 -0500
References: <1513345976-22958-1-git-send-email-peter.maydell@linaro.org>
	<1513345976-22958-3-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7fe00926-39b9-f0eb-0bc3-29188f767308@vivier.eu>
Date: Fri, 15 Dec 2017 15:29:40 +0100
MIME-Version: 1.0
In-Reply-To: <1513345976-22958-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: Don't use
 CMSG_ALIGN(sizeof struct cmsghdr)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Bruno Haible <bruno@clisp.org>, patches@linaro.org

Le 15/12/2017 à 14:52, Peter Maydell a écrit :
> The Linux struct cmsghdr is already guaranteed to be sufficiently
> aligned that CMSG_ALIGN(sizeof struct cmsghdr) is always equal
> to sizeof struct cmsghdr. Stop doing the unnecessary alignment
> arithmetic for host and target cmsghdr.
> 
> This follows kernel commit 1ff8cebf49ed9e9ca2 and brings our
> TARGET_CMSG_* macros back into line with the kernel ones,
> as well as making them easier to understand.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/syscall_defs.h | 6 +++---
>  linux-user/syscall.c      | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
