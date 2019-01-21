Received: from eggs.gnu.org ([209.51.188.92]:55802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glg35-0001GV-Gn
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:20:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glg34-00016Y-Qz
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:19:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glg34-000165-Ky
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:19:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so24875201wrp.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:19:58 -0800 (PST)
References: <1548097698-28951-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1548097698-28951-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a414c064-daca-42e4-76fb-8cde4895274a@redhat.com>
Date: Mon, 21 Jan 2019 21:19:56 +0100
MIME-Version: 1.0
In-Reply-To: <1548097698-28951-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/6] target/mips: nanoMIPS: Remove an
 unused macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: smarkovic@wavecomp.com, arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 1/21/19 8:08 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Remove a macro that is never used.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/mips/translate.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index fb2c42c..aad760c 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -18393,7 +18393,6 @@ enum {
>  
>  #define NANOMIPS_EXTRACT_RD(op) ((op >> 7) & 0x7)
>  #define NANOMIPS_EXTRACT_RS(op) ((op >> 4) & 0x7)
> -#define NANOMIPS_EXTRACT_RS2(op) uMIPS_RS(op)
>  #define NANOMIPS_EXTRACT_RS1(op) ((op >> 1) & 0x7)
>  #define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
>  #define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
> 
