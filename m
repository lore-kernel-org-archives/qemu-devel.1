Received: from eggs.gnu.org ([2001:4830:134:3::10]:44394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f13QL-00077G-R9
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f13QI-0007e3-M8
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:15:01 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:42443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f13QI-0007du-Ed
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:14:58 -0400
Received: by mail-ot0-x242.google.com with SMTP id v23-v6so1334183oth.9
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 22:14:58 -0700 (PDT)
References: <1522197746-26020-1-git-send-email-mjc@sifive.com>
	<1522197746-26020-2-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e2a518fd-34ef-537a-b8b4-efbd8e61ca6a@linaro.org>
Date: Wed, 28 Mar 2018 13:14:45 +0800
MIME-Version: 1.0
In-Reply-To: <1522197746-26020-2-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] RISC-V: Workaround for critical
 mstatus.FS MTTCG bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 03/28/2018 08:42 AM, Michael Clark wrote:
> This change is a workaround for a bug where mstatus.FS
> is not correctly reporting dirty after operations that
> modify floating point registers. This a critical bug
> or RISC-V in QEMU as it results in floating point
> register file corruption when running SMP Linux due to
> task migration and possibly uniprocessor Linux if
> more than one process is using the FPU.
> 
> This workaround will return dirty if mstatus.FS is
> switched from off to initial or clean. According to
> the specification it is legal for an implementation
> to return only off, or dirty.
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/op_helper.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

In case the more extensive fix waits until 2.13,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
