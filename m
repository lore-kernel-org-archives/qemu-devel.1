Received: from eggs.gnu.org ([2001:4830:134:3::10]:59392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fzjRx-0002Tu-1F
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fzjRr-0004Qn-Dm
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:15:28 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fzjRr-0004K0-2E
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:15:23 -0400
References: <20180911140631.18481-1-alex.bennee@linaro.org>
	<20180911140631.18481-4-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8346c1bb-9cb6-4c08-66a2-b5e5a31903d4@vivier.eu>
Date: Tue, 11 Sep 2018 16:14:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180911140631.18481-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] linux-user/nios2: bump min uname
 to 4.16.0 [!HACK]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: 1791796@bugs.launchpad.net, thuth@redhat.com, Riku Voipio <riku.voipio@iki.fi>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

Le 11/09/2018 à 16:06, Alex Bennée a écrit :
> This is to work around the limitations of the buildroot
> qemu_nios2_10m50_defconfig which sets the base kernel version for
> glibc.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/nios2/target_syscall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/nios2/target_syscall.h b/linux-user/nios2/target_syscall.h
> index ca6b7e69f6..905b80d112 100644
> --- a/linux-user/nios2/target_syscall.h
> +++ b/linux-user/nios2/target_syscall.h
> @@ -2,7 +2,7 @@
>  #define TARGET_SYSCALL_H
>  
>  #define UNAME_MACHINE "nios2"
> -#define UNAME_MINIMUM_RELEASE "3.19.0"
> +#define UNAME_MINIMUM_RELEASE "4.16.0"
>  
>  struct target_pt_regs {
>      unsigned long  r8;    /* r8-r15 Caller-saved GP registers */
> 

I have no objection. Perhaps you could ask NiosII Maintainers (cc).

Laurent
