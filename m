Received: from eggs.gnu.org ([2001:4830:134:3::10]:49799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBjze-0006By-Tj
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBjze-0005Zw-0m
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:43:38 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fBjzd-0005Zm-Of
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:43:37 -0400
Received: by mail-lf0-x243.google.com with SMTP id r125-v6so31722347lfe.2
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 09:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-8-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-8-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Apr 2018 16:43:10 +0000
Message-ID: <CAKmqyKOLpTz=_h1qCR4oCt-VvwHjgCmob9bg48UyX2Xti223mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 07/35] RISC-V: Make some header guards
 more specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, patches@groups.riscv.org, palmer@sifive.com, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Wed, Apr 25, 2018 at 4:57 PM Michael Clark <mjc@sifive.com> wrote:

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   include/hw/riscv/spike.h | 4 ++--
>   include/hw/riscv/virt.h  | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)

> diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
> index 8410430..641b70d 100644
> --- a/include/hw/riscv/spike.h
> +++ b/include/hw/riscv/spike.h
> @@ -16,8 +16,8 @@
>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>    */

> -#ifndef HW_SPIKE_H
> -#define HW_SPIKE_H
> +#ifndef HW_RISCV_SPIKE_H
> +#define HW_RISCV_SPIKE_H

>   typedef struct {
>       /*< private >*/
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index b91a412..3a4f23e 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -16,8 +16,8 @@
>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>    */

> -#ifndef HW_VIRT_H
> -#define HW_VIRT_H
> +#ifndef HW_RISCV_VIRT_H
> +#define HW_RISCV_VIRT_H

>   typedef struct {
>       /*< private >*/
> --
> 2.7.0
