Received: from eggs.gnu.org ([2001:4830:134:3::10]:47574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoYz3-00060I-Ta
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoYyz-0006fc-PC
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:19:13 -0500
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:41214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eoYyz-0006ei-Gt
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:19:09 -0500
Received: by mail-pf0-x22f.google.com with SMTP id a17so987688pff.8
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 10:19:09 -0800 (PST)
References: <1519093616-10563-1-git-send-email-cota@braap.org>
	<1519093616-10563-2-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <512f6e39-9aa0-7e4f-fad4-7085d499ae65@linaro.org>
Date: Wed, 21 Feb 2018 10:19:05 -0800
MIME-Version: 1.0
In-Reply-To: <1519093616-10563-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 1/2] translator: merge max_insns into
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 02/19/2018 06:26 PM, Emilio G. Cota wrote:
> @@ -68,6 +69,7 @@ typedef struct DisasContextBase {
>      target_ulong pc_next;
>      DisasJumpType is_jmp;
>      unsigned int num_insns;
> +    int max_insns;
>      bool singlestep_enabled;
>  } DisasContextBase;

We really should pick the same type for max_insns and num_insns, which ever
type we settle on.  I can't see how we can go wrong with unsigned...


r~
