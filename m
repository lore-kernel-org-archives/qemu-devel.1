Received: from eggs.gnu.org ([2001:4830:134:3::10]:59041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZ3EM-0005aG-73
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 19:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZ3EJ-0007PR-00
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 19:27:26 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZ3EI-0007P2-PE
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 19:27:22 -0500
Received: by mail-wr1-x444.google.com with SMTP id x10so14115790wrs.8
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 16:27:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181217170000.4884-1-aleksandar.markovic@rt-rk.com>
	<20181217170000.4884-3-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fc24859f-6b19-0d56-ac2d-ee938d5d51cb@amsat.org>
Date: Tue, 18 Dec 2018 01:27:19 +0100
MIME-Version: 1.0
In-Reply-To: <20181217170000.4884-3-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: target/mips: Add filter
 for mips in email subjects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org, smarkovic@wavecomp.com, amarkovic@wavecomp.com

Hi Aleksandar,

On 12/17/18 5:59 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Add ability to redirect mails (sent to qemu-devel) containing
> "mips" in the subject line to MIPS maintainers and reviewers.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c052523373..3dda82d31e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -219,6 +219,7 @@ F: tests/tcg/mips/
>  F: disas/mips.c
>  F: disas/nanomips.h
>  F: disas/nanomips.cpp
> +K: ^Subject:.*(?i)mips?

Why the trailing quantifier '?'?
This matches:
semipermeable
semiprecious
semiprivate
semiprofessional

>  
>  Moxie
>  M: Anthony Green <green@moxielogic.com>
> 
