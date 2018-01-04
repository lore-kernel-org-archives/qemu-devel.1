Received: from eggs.gnu.org ([2001:4830:134:3::10]:56788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWsxN-0002Pp-V5
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWsxK-00052i-Kp
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:00:25 -0500
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:39898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWsxK-00051A-9m
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:00:22 -0500
Received: by mail-pg0-x22c.google.com with SMTP id 81so22135pgf.6
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 16:00:21 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-12-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a7b9b418-3824-f112-d7f1-23e8ce182859@linaro.org>
Date: Wed, 3 Jan 2018 16:00:17 -0800
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-12-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 11/21] RISC-V HTIF Console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 01/02/2018 04:44 PM, Michael Clark wrote:
> +    /*
> +     * Find the static and dynamic symbol tables and their string
> +     * tables in the the mapped binary. The sh_link field in symbol
> +     * table section headers gives the section index of the string
> +     * table for that symbol table.
> +     */
> +    shdr = (Elf64_Shdr *)(ep->maddr + ep->ehdr->e_shoff);

This fails to do any byte swapping such that this code works on a big-endian
host.  You should use the routines in "hw/elf_ops.h" as adjusted by "hw/loader.h".


r~
