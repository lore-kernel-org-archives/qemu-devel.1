Received: from eggs.gnu.org ([2001:4830:134:3::10]:43308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTFz9-0003NW-Mx
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTFz4-0004P8-S7
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:42:43 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:61154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cTFz4-0004Ox-J1
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:42:38 -0500
References: <20170116223140.18634-1-glaubitz@physik.fu-berlin.de>
	<20170116223140.18634-2-glaubitz@physik.fu-berlin.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <349b1d3b-074d-f827-2d4c-b1f9f9b05a0d@vivier.eu>
Date: Mon, 16 Jan 2017 23:42:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170116223140.18634-2-glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Update sh4 syscall definitions
 to match Linux 4.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, qemu-devel@nongnu.org

Le 16/01/2017 à 23:31, John Paul Adrian Glaubitz a écrit :
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
>  linux-user/sh4/syscall_nr.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/linux-user/sh4/syscall_nr.h b/linux-user/sh4/syscall_nr.h
> index e99f73589d..d6c1e059f6 100644
> --- a/linux-user/sh4/syscall_nr.h
> +++ b/linux-user/sh4/syscall_nr.h
> @@ -372,3 +372,17 @@
>  #define TARGET_NR_process_vm_writev     366
>  #define TARGET_NR_kcmp                  367
>  #define TARGET_NR_finit_module          368
> +#define TARGET_NR_sched_getattr         369
> +#define TARGET_NR_sched_setattr         370
> +#define TARGET_NR_renameat2             371
> +#define TARGET_NR_seccomp               372
> +#define TARGET_NR_getrandom             373
> +#define TARGET_NR_memfd_create          374
> +#define TARGET_NR_bpf                   375
> +#define TARGET_NR_execveat              376
> +#define TARGET_NR_userfaultfd           377
> +#define TARGET_NR_membarrier            378
> +#define TARGET_NR_mlock2                379
> +#define TARGET_NR_copy_file_range       380
> +#define TARGET_NR_preadv2               381
> +#define TARGET_NR_pwritev2              382
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
