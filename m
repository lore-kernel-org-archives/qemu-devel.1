Received: from eggs.gnu.org ([2001:4830:134:3::10]:37527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eul8f-00037h-16
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eul8b-0005TR-UK
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:30:45 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eul8b-0005T2-MR
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:30:41 -0500
Received: by mail-wm0-x241.google.com with SMTP id z9so9458275wmb.3
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 12:30:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
	<1520568765-58189-14-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f890300-ee99-e2ed-3fff-26ed8348cf3e@amsat.org>
Date: Sat, 10 Mar 2018 21:30:38 +0100
MIME-Version: 1.0
In-Reply-To: <1520568765-58189-14-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/23] RISC-V: Make some header guards
 more specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 03/09/2018 05:12 AM, Michael Clark wrote:
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/riscv/spike.h | 4 ++--
>  include/hw/riscv/virt.h  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
> index 8410430..641b70d 100644
> --- a/include/hw/riscv/spike.h
> +++ b/include/hw/riscv/spike.h
> @@ -16,8 +16,8 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -#ifndef HW_SPIKE_H
> -#define HW_SPIKE_H
> +#ifndef HW_RISCV_SPIKE_H
> +#define HW_RISCV_SPIKE_H
>  
>  typedef struct {
>      /*< private >*/
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index b91a412..3a4f23e 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -16,8 +16,8 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -#ifndef HW_VIRT_H
> -#define HW_VIRT_H
> +#ifndef HW_RISCV_VIRT_H
> +#define HW_RISCV_VIRT_H
>  
>  typedef struct {
>      /*< private >*/
> 
