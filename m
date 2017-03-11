Received: from eggs.gnu.org ([2001:4830:134:3::10]:38891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cmhfR-0001zb-1d
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 09:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cmhfN-0004Ys-Tg
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 09:06:45 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cmhfN-0004WO-If
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 09:06:41 -0500
References: <20170311100543.GA29669@ls3530.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b0d92171-3839-ba47-ea8f-61e443d0fa64@vivier.eu>
Date: Sat, 11 Mar 2017 15:06:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170311100543.GA29669@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/hppa: Fix typo for
 TARGET_NR_epoll_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Cc: Richard Henderson <rth@twiddle.net>

Le 11/03/2017 à 11:05, Helge Deller a écrit :
> This fixes running a dynamically linked nslookup binary on hppa with
> LD_BIND_NOW=1.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> 
> diff --git a/linux-user/hppa/syscall_nr.h b/linux-user/hppa/syscall_nr.h
> index 0f396fa..55bdf71 100644
> --- a/linux-user/hppa/syscall_nr.h
> +++ b/linux-user/hppa/syscall_nr.h
> @@ -228,7 +228,7 @@
>  #define TARGET_NR_lookup_dcookie    223
>  #define TARGET_NR_epoll_create      224
>  #define TARGET_NR_epoll_ctl         225
> -#define TARGET_NR_epill_wait        226
> +#define TARGET_NR_epoll_wait        226
>  #define TARGET_NR_remap_file_pages  227
>  #define TARGET_NR_semtimedop        228
>  #define TARGET_NR_mq_open           229
> 
