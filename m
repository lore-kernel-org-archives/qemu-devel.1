Received: from eggs.gnu.org ([2001:4830:134:3::10]:39060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgDc-0006OY-M1
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgDZ-0003fS-1R
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:56:12 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZgDY-0003f6-R2
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:56:08 -0500
Received: by mail-wm0-x22d.google.com with SMTP id r141so33440239wmg.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 07:56:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1ebabcf0e1af7a81774fef22f7e765089fb2685d.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
	<1ebabcf0e1af7a81774fef22f7e765089fb2685d.1484929304.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 15:55:04 +0000
Message-ID: <CAFEAcA_C+0As5a50Yii22qZ91g3cQswaVvmv_Bnn8ad87-e2Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 3/7] Move target_memory_rw_debug
 function.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 January 2017 at 16:30, Julian Brown <julian@codesourcery.com> wrote:
> This patch moves the target_memory_rw_debug function to
> include/exec/cpu-all.h, so that it can be used by the ARM semihosting
> code as well as the gdbstub code. (I tried Peter Maydell's suggestion
> of include/qom/cpu.h as a location for the function, but that raised
> uncomfortably-many dependency problems for my taste).
>
> Signed-off-by: Julian Brown <julian@codesourcery.com>
> ---
>  gdbstub.c              | 11 -----------
>  include/exec/cpu-all.h | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 11 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
