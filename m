Received: from eggs.gnu.org ([2001:4830:134:3::10]:41309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJWC-00041M-BO
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJW8-00069Z-7P
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:24:08 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:41805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emJW7-000692-Ti
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:24:04 -0500
References: <mvm7es7sds9.fsf@suse.de> <mvm8tcmqdp3.fsf@suse.de>
	<mvmbmhdosb9.fsf_-_@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <459e8c24-719e-7c0a-9c8f-86e98b5802d4@vivier.eu>
Date: Thu, 15 Feb 2018 14:23:59 +0100
MIME-Version: 1.0
In-Reply-To: <mvmbmhdosb9.fsf_-_@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: Implement ioctl cmd
 TIOCGPTPEER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@linaro.org>

Le 29/01/2018 à 11:47, Andreas Schwab a écrit :
> With glibc 2.27 the openpty function prefers the TIOCGPTPEER ioctl.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
> v2: handle host with old kernel headers
> v3: fix sparc typos
> ---
>  linux-user/aarch64/termbits.h    | 2 ++
>  linux-user/alpha/termbits.h      | 1 +
>  linux-user/arm/termbits.h        | 1 +
>  linux-user/cris/termbits.h       | 1 +
>  linux-user/hppa/termbits.h       | 2 ++
>  linux-user/i386/termbits.h       | 1 +
>  linux-user/ioctls.h              | 3 +++
>  linux-user/m68k/termbits.h       | 1 +
>  linux-user/microblaze/termbits.h | 1 +
>  linux-user/mips/termbits.h       | 1 +
>  linux-user/nios2/termbits.h      | 2 ++
>  linux-user/openrisc/termbits.h   | 2 ++
>  linux-user/ppc/termbits.h        | 1 +
>  linux-user/s390x/termbits.h      | 1 +
>  linux-user/sh4/termbits.h        | 1 +
>  linux-user/sparc/termbits.h      | 1 +
>  linux-user/sparc64/termbits.h    | 1 +
>  linux-user/syscall.c             | 9 +++++++++
>  linux-user/tilegx/termbits.h     | 1 +
>  linux-user/x86_64/termbits.h     | 1 +
>  20 files changed, 34 insertions(+)

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
