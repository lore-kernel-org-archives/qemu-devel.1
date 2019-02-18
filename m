Received: from eggs.gnu.org ([209.51.188.92]:40270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gvlyX-0003Q3-ER
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gvlyU-0008TR-Tk
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:41:01 -0500
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-2-armbru@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a8aa118f-419c-580b-bb9f-38fbabbe4606@redhat.com>
Date: Mon, 18 Feb 2019 17:40:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190218125615.18970-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/10] pflash: Rename pflash_t to
 PFlashCFI01, PFlashCFI02
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org

On 02/18/19 13:56, Markus Armbruster wrote:
> flash.h's incomplete struct pflash_t is completed both in
> pflash_cfi01.c and in pflash_cfi02.c.  The complete types are
> incompatible.

O_o

> This can hide type errors, such as passing a pflash_t
> created with pflash_cfi02_register() to pflash_cfi01_get_memory().
> 
> Furthermore, POSIX reserves typedef names ending with _t.
> 
> Rename the two structs to PFlashCFI01 and PFlashCFI02.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/vexpress.c        |  8 ++--
>  hw/block/pflash_cfi01.c  | 87 +++++++++++++++++++++-------------------
>  hw/block/pflash_cfi02.c  | 67 ++++++++++++++++---------------
>  hw/i386/pc_sysfw.c       |  2 +-
>  hw/mips/mips_malta.c     |  2 +-
>  hw/xtensa/xtfpga.c       | 10 ++---
>  include/hw/block/flash.h | 53 ++++++++++++++----------
>  7 files changed, 122 insertions(+), 107 deletions(-)

I didn't check larger contexts in the modified files. I also didn't look
for typos or try to verify the patch by recreating it from scratch, and
by comparison. I read through the posted patch and it looks OK to me.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
