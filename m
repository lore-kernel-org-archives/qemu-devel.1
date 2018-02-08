Received: from eggs.gnu.org ([2001:4830:134:3::10]:34474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejowF-0004Pp-GD
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejowA-0002oT-Ih
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:20:43 -0500
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:39694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejowA-0002nw-C6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:20:38 -0500
Received: by mail-pg0-x22d.google.com with SMTP id w17so1766998pgv.6
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:20:38 -0800 (PST)
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-12-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b1d5d225-7a48-160b-2d24-3f2fb601a09a@linaro.org>
Date: Thu, 8 Feb 2018 08:20:34 -0800
MIME-Version: 1.0
In-Reply-To: <1518053328-34687-12-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 11/23] RISC-V Linux User Emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/07/2018 05:28 PM, Michael Clark wrote:
> +/* not RISC-V exception codes - this is for qemu user-mode */
> +#define QEMU_USER_EXCP_FAULT               0xd

Any reason to define this instead of using RISCV_EXCP_LOAD_ADDR_MIS/ACCESS_FAULT?

Otherwise this looks fine.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
