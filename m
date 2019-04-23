Received: from eggs.gnu.org ([209.51.188.92]:40650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIw2m-0007E0-NS
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIvpO-0004gr-6M
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:51:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIvpM-0004bm-6N
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:51:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so176732wml.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 06:51:14 -0700 (PDT)
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556018982-3715-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eee78a60-109c-6604-7f12-046ccc34d25b@redhat.com>
Date: Tue, 23 Apr 2019 15:51:12 +0200
MIME-Version: 1.0
In-Reply-To: <1556018982-3715-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/8] target/mips: Clean up lmi_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 4/23/19 1:29 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Remove several minor checkpatch warnings and errors.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/lmi_helper.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/mips/lmi_helper.c b/target/mips/lmi_helper.c
> index fb1245b..6c645cf 100644
> --- a/target/mips/lmi_helper.c
> +++ b/target/mips/lmi_helper.c
> @@ -21,9 +21,11 @@
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
>  
> -/* If the byte ordering doesn't matter, i.e. all columns are treated
> -   identically, then this union can be used directly.  If byte ordering
> -   does matter, we generally ignore dumping to memory.  */
> +/*
> + * If the byte ordering doesn't matter, i.e. all columns are treated
> + * identically, then this union can be used directly.  If byte ordering
> + * does matter, we generally ignore dumping to memory.
> + */
>  typedef union {
>      uint8_t  ub[8];
>      int8_t   sb[8];
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
