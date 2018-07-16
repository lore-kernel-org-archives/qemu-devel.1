Received: from eggs.gnu.org ([2001:4830:134:3::10]:51121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffDCB-00078N-K0
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 19:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffDC8-0006g9-Ig
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 19:46:23 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:44188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ffDC8-0006cV-Ao
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 19:46:20 -0400
Received: by mail-pf0-x244.google.com with SMTP id k21-v6so2166621pff.11
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 16:46:19 -0700 (PDT)
References: <20180716195349.29959-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ad6f21d0-430e-7d3c-b2c7-e1c00c862558@linaro.org>
Date: Mon, 16 Jul 2018 16:46:16 -0700
MIME-Version: 1.0
In-Reply-To: <20180716195349.29959-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix ELF load alignment error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Alexander Graf <agraf@suse.de>

On 07/16/2018 12:53 PM, Laurent Vivier wrote:
> When we try to use some targets on ppc64, it can happen the target
> doesn't support the host page size to align ELF load sections and
> fails with:
> 
>   ELF load command alignment not page-aligned
> 
> Since commit a70daba3771 ("linux-user: Tell guest about big host
> page sizes") the host page size is used to align ELF sections, but
> this doesn't work if the alignment required by the load section is
> smaller than the host one.  For these cases, we continue to use the
> TARGET_PAGE_SIZE instead of the host one.
> 
> I have tested this change on ppc64, and it fixes qemu linux-user for:
>   s390x, m68k, i386, arm, aarch64, hppa
> and I have tested it doesn't break the following targets:
>   x86_64, mips64el, sh4
> mips and mipsel abort, but I think for another reason.
...
>      loaddr = -1, hiaddr = 0;
> +    info->alignment |=  0;

Plain assignment for initialization.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
