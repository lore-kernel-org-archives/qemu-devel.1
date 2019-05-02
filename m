Received: from eggs.gnu.org ([209.51.188.92]:42115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM6rc-0002HD-12
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM6ra-0005dt-5p
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:14:43 -0400
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a5dcdddb-a243-a657-c054-6d46964ebeb6@vivier.eu>
Date: Thu, 2 May 2019 10:14:18 +0200
MIME-Version: 1.0
In-Reply-To: <c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On 01/05/2019 01:29, Alistair Francis wrote:
> Fix this warning when building with GCC9 on Fedora 30:
> In function ‘strncpy’,
>     inlined from ‘fill_psinfo’ at /home/alistair/qemu/linux-user/elfload.c:3208:12,
>     inlined from ‘fill_note_info’ at /home/alistair/qemu/linux-user/elfload.c:3390:5,
>     inlined from ‘elf_core_dump’ at /home/alistair/qemu/linux-user/elfload.c:3539:9:
> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 16 equals destination size [-Werror=stringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/elfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a26021f8..d08fe23466 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2872,7 +2872,7 @@ struct target_elf_prpsinfo {
>      target_gid_t pr_gid;
>      target_pid_t pr_pid, pr_ppid, pr_pgrp, pr_sid;
>      /* Lots missing */
> -    char    pr_fname[16];           /* filename of executable */
> +    char    pr_fname[16] QEMU_NONSTRING; /* filename of executable */
>      char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
>  };
>  
> 


Applied to my linux-user branch.

Thanks,
Laurent
