Received: from eggs.gnu.org ([2001:4830:134:3::10]:45855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ1XB-00036E-R4
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ1XB-0006P2-6y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:34:13 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:43783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eZ1XB-0006OC-0i
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:34:13 -0500
Received: by mail-wm0-x242.google.com with SMTP id g1so5217923wmg.2
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 13:34:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-3-git-send-email-mjc@sifive.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-3-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Jan 2018 13:33:41 -0800
Message-ID: <CAKmqyKMeBU7WWRz23HJn7N_PRzK2+QNAdZNPAwP6zku2qFrmEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 02/21] RISC-V ELF Machine Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Tue, Jan 2, 2018 at 4:44 PM, Michael Clark <mjc@sifive.com> wrote:
> Define RISC-V ELF machine EM_RISCV 243
>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  include/elf.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/elf.h b/include/elf.h
> index e8a515c..8e457fc 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -112,6 +112,8 @@ typedef int64_t  Elf64_Sxword;
>
>  #define EM_UNICORE32    110     /* UniCore32 */
>
> +#define EM_RISCV        243     /* RISC-V */
> +
>  /*
>   * This is an interim value that we will use until the committee comes
>   * up with a final number.
> --
> 2.7.0
>
>
