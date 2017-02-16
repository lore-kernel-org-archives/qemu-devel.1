Received: from eggs.gnu.org ([2001:4830:134:3::10]:49122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1ceMzU-0004dg-0m
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1ceMzQ-0003g8-LI
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:24:59 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:59473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1ceMzQ-0003dt-EK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:24:56 -0500
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <20170216142227.27448-10-laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:24:47 +0100
Content-Transfer-Encoding: 7bit
Message-Id: <5481FC59-2533-43BF-A2EE-C1A9496AFF11@physik.fu-berlin.de>
References: <20170216142227.27448-1-laurent@vivier.eu>
	<20170216142227.27448-10-laurent@vivier.eu>
Subject: Re: [Qemu-devel] [PULL 09/14] linux-user: Update m68k syscall
 definitions to match Linux 4.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Patchwork has cut off my name again!

Could you please override that?

It's "John Paul Adrian Glaubitz".

Thanks!

> On Feb 16, 2017, at 3:22 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> 
> From: Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Message-Id: <20170116224915.19430-2-glaubitz@physik.fu-berlin.de>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> linux-user/m68k/syscall_nr.h | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/m68k/syscall_nr.h b/linux-user/m68k/syscall_nr.h
> index 4b50fb2..d239551 100644
> --- a/linux-user/m68k/syscall_nr.h
> +++ b/linux-user/m68k/syscall_nr.h
> @@ -376,3 +376,6 @@
> #define TARGET_NR_userfaultfd           373
> #define TARGET_NR_membarrier            374
> #define TARGET_NR_mlock2                375
> +#define TARGET_NR_copy_file_range       376
> +#define TARGET_NR_preadv2               377
> +#define TARGET_NR_pwritev2              378
> -- 
> 2.9.3
