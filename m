Received: from eggs.gnu.org ([2001:4830:134:3::10]:45935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTG8Y-0002Y3-NH
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTG8U-000747-Rw
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:52:26 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:63055)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cTG8U-00073h-IG
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:52:22 -0500
References: <20170116224915.19430-1-glaubitz@physik.fu-berlin.de>
	<20170116224915.19430-2-glaubitz@physik.fu-berlin.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f2217600-2979-c186-d24a-d0ac7b158ae9@vivier.eu>
Date: Mon, 16 Jan 2017 23:52:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170116224915.19430-2-glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Update m68k syscall
 definitions to match Linux 4.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, qemu-devel@nongnu.org

Le 16/01/2017 à 23:49, John Paul Adrian Glaubitz a écrit :
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
>  linux-user/m68k/syscall_nr.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/m68k/syscall_nr.h b/linux-user/m68k/syscall_nr.h
> index 4b50fb29b6..d239551b34 100644
> --- a/linux-user/m68k/syscall_nr.h
> +++ b/linux-user/m68k/syscall_nr.h
> @@ -376,3 +376,6 @@
>  #define TARGET_NR_userfaultfd           373
>  #define TARGET_NR_membarrier            374
>  #define TARGET_NR_mlock2                375
> +#define TARGET_NR_copy_file_range       376
> +#define TARGET_NR_preadv2               377
> +#define TARGET_NR_pwritev2              378
> 
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
