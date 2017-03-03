Received: from eggs.gnu.org ([2001:4830:134:3::10]:55585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjt4F-0002F7-2X
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjt4B-00076f-Vd
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:40:43 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjt4B-00076K-RK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:40:39 -0500
Received: by mail-qk0-x244.google.com with SMTP id n141so5947207qke.3
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 11:40:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
	<1488556233-31246-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <de6825bd-389d-5390-9834-ad139a72cfc6@amsat.org>
Date: Fri, 3 Mar 2017 16:40:35 -0300
MIME-Version: 1.0
In-Reply-To: <1488556233-31246-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/6] disas/hppa: Remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On 03/03/2017 12:50 PM, Peter Maydell wrote:
> Coverity complains (CID 1302705) that the "fr0" part of the ?: in
> fput_fp_reg_r() is dead.  This looks like cut-n-paste error from
> fput_fp_reg(); delete the dead code.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  disas/hppa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/disas/hppa.c b/disas/hppa.c
> index 43facdc..a2d371f 100644
> --- a/disas/hppa.c
> +++ b/disas/hppa.c
> @@ -1788,8 +1788,7 @@ fput_fp_reg_r (unsigned reg, disassemble_info *info)
>    if (reg < 4)
>      (*info->fprintf_func) (info->stream, "fpe%d", reg * 2 + 1);
>    else
> -    (*info->fprintf_func) (info->stream, "%sR",
> -			   reg ? fp_reg_names[reg] : "fr0");
> +    (*info->fprintf_func) (info->stream, "%sR", fp_reg_names[reg]);
>  }
>
>  static void
>
