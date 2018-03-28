Received: from eggs.gnu.org ([2001:4830:134:3::10]:38985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f12re-000332-EN
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f12rb-0002LN-9m
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:39:10 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:45212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f12rb-0002L8-3R
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:39:07 -0400
Received: by mail-pg0-x243.google.com with SMTP id y63so510311pgy.12
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 21:39:06 -0700 (PDT)
References: <1522180547-22956-1-git-send-email-mjc@sifive.com>
	<1522180547-22956-2-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5882865f-2ce9-5f32-1b89-627cae2278f3@linaro.org>
Date: Wed, 28 Mar 2018 12:38:48 +0800
MIME-Version: 1.0
In-Reply-To: <1522180547-22956-2-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] RISC-V: Convert cpu definition to
 future model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Igor Mammedov <imammedo@redhat.com>, patches@groups.riscv.org

On 03/28/2018 03:55 AM, Michael Clark wrote:
> - Model borrowed from target/sh4/cpu.c
> - Rewrote riscv_cpu_list to use object_class_get_list
> - Dropped 'struct RISCVCPUInfo' and used TypeInfo array
> - Replaced riscv_cpu_register_types with DEFINE_TYPES
> - Marked base class as abstract
> - Fixes -cpu list
> 
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  target/riscv/cpu.c | 123 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 69 insertions(+), 54 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
