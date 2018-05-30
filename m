Received: from eggs.gnu.org ([2001:4830:134:3::10]:47845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAHx-0002a2-Qd
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAHs-0003Xr-Pf
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:13:53 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:41168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fOAHs-0003Xg-IS
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:13:48 -0400
Received: by mail-pg0-x242.google.com with SMTP id d14-v6so8807915pgv.8
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:13:48 -0700 (PDT)
Date: Thu, 31 May 2018 08:13:45 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180530231345.GT3652@lianli.shorne-pla.net>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
	<20180527141324.11937-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527141324.11937-3-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 02/20] target/openrisc: Use exit_tb instead
 of CPU_INTERRUPT_EXITTB
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

On Sun, May 27, 2018 at 09:13:06AM -0500, Richard Henderson wrote:
> No need to use the interrupt mechanisms when we can
> simply exit the tb directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>
