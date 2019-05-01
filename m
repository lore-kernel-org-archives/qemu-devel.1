Received: from eggs.gnu.org ([209.51.188.92]:48661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLq17-0001sT-UL
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLq10-0006fK-AC
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:15:22 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:43533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLq0y-0006eg-ND
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:15:18 -0400
Received: by mail-pl1-x629.google.com with SMTP id n8so8237276plp.10
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:15:16 -0700 (PDT)
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <035c917e-be1c-1cda-6b1b-337fa804a69b@linaro.org>
Date: Wed, 1 May 2019 07:15:12 -0700
MIME-Version: 1.0
In-Reply-To: <c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "kraxel@redhat.com" <kraxel@redhat.com>, "alistair23@gmail.com" <alistair23@gmail.com>

On 4/30/19 4:29 PM, Alistair Francis wrote:
> @@ -2872,7 +2872,7 @@ struct target_elf_prpsinfo {
>      target_gid_t pr_gid;
>      target_pid_t pr_pid, pr_ppid, pr_pgrp, pr_sid;
>      /* Lots missing */
> -    char    pr_fname[16];           /* filename of executable */
> +    char    pr_fname[16] QEMU_NONSTRING; /* filename of executable */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
