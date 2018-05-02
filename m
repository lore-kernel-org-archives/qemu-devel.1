Received: from eggs.gnu.org ([2001:4830:134:3::10]:48065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvcr-0007G4-6x
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvcm-0005Sy-AV
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:33:09 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:40100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDvcm-0005ST-2i
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:33:04 -0400
Received: by mail-pg0-x22e.google.com with SMTP id l2-v6so11122764pgc.7
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 10:33:03 -0700 (PDT)
References: <20180502171853.25332-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96dc17ed-6e44-032d-0b28-f9ef855f5e73@linaro.org>
Date: Wed, 2 May 2018 10:33:00 -0700
MIME-Version: 1.0
In-Reply-To: <20180502171853.25332-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: remove useless padding in
 flock64 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 05/02/2018 10:18 AM, Laurent Vivier wrote:
> +#if defined(TARGET_ARM) && defined(TARGET_ABI32)
> +struct target_oabi_flock64 {
> +    abi_short l_type;
> +    abi_short l_whence;
>      abi_llong l_start;
>      abi_llong l_len;
> -    int  l_pid;
> +    abi_int   l_pid;
>  } QEMU_PACKED;
>  #endif

Is it possible to move this to linux-user/arm/target_structs.h?

Otherwise it all looks ok.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
