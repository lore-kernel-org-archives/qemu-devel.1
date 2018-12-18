Received: from eggs.gnu.org ([2001:4830:134:3::10]:57920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZ37v-0003bX-0z
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 19:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZ37r-0002Qc-1l
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 19:20:46 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZ37q-0002Q2-RI
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 19:20:42 -0500
Received: by mail-wm1-x341.google.com with SMTP id p6so704662wmc.1
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 16:20:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181217170000.4884-1-aleksandar.markovic@rt-rk.com>
	<20181217170000.4884-2-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2f3231a7-1c60-2b1a-5694-77f8b4323a7e@amsat.org>
Date: Tue, 18 Dec 2018 01:20:39 +0100
MIME-Version: 1.0
In-Reply-To: <20181217170000.4884-2-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] MAINTAINERS: target/mips: Add MIPS
 files under default-configs directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org, smarkovic@wavecomp.com, amarkovic@wavecomp.com

On 12/17/18 5:59 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Add following files as maintained within the main MIPS target
> section in MAINTAINERS:
> 
> default-configs/mips64el-linux-user.mak
> default-configs/mips64-linux-user.mak
> default-configs/mipsn32el-linux-user.mak
> default-configs/mipsn32-linux-user.mak
> default-configs/mipsel-linux-user.mak
> default-configs/mips-linux-user.mak
> default-configs/mips64el-softmmu.mak
> default-configs/mips64-softmmu.mak
> default-configs/mipsel-softmmu.mak
> default-configs/mips-softmmu.mak
> default-configs/mips-softmmu-common.mak
> 
> Future nanoMIPS user mode will also have its .mak file, and
> because of that "*mips*" was used instead of *mips*" as a

... instead of "mips*"

('*' -> '"')

> shorthand in the new item in MAINTAINERS.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 83c127f0d6..c052523373 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -206,6 +206,7 @@ M: Aleksandar Markovic <amarkovic@wavecomp.com>
>  R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: target/mips/
> +F: default-configs/*mips*
>  F: hw/mips/
>  F: hw/misc/mips_*
>  F: hw/intc/mips_gic.c
> 
