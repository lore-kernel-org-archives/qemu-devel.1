Received: from eggs.gnu.org ([2001:4830:134:3::10]:48032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAIc-0003CD-RJ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAIX-0003mX-P7
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:14:34 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:41172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fOAIX-0003lx-IS
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:14:29 -0400
Received: by mail-pg0-x243.google.com with SMTP id d14-v6so8808487pgv.8
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:14:29 -0700 (PDT)
Date: Thu, 31 May 2018 08:14:26 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180530231426.GU3652@lianli.shorne-pla.net>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
	<20180527141324.11937-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527141324.11937-4-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 03/20] target/openrisc: Fix
 singlestep_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Sun, May 27, 2018 at 09:13:07AM -0500, Richard Henderson wrote:
> We failed to store to cpu_pc before raising the exception,
> which caused us to re-execute the same insn that we stepped.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>
