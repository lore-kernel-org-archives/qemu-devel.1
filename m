Received: from eggs.gnu.org ([2001:4830:134:3::10]:38027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1db05N-0003T7-SM
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1db05N-0006e9-5D
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:53:25 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-23-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <981abfd8-09f6-39f7-0921-8b87020b5b6c@vivier.eu>
Date: Fri, 28 Jul 2017 09:53:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-23-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 22/47] MAINTAINERS: add missing M68k entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Le 28/07/2017 à 07:35, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14109f4513..06b092bf85 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -156,6 +156,7 @@ M: Laurent Vivier <laurent@vivier.eu>
>  S: Maintained
>  F: target/m68k/
>  F: disas/m68k.c
> +F: default-configs/m68k-softmmu.mak

I think *-softmmu.mak would better fit under a machine section, but I
agree it is easier to manage by adding it here, so:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Laurent
