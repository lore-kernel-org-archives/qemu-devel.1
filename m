Received: from eggs.gnu.org ([2001:4830:134:3::10]:40200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fEpeX-0002df-On
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fEpeS-0007cy-Rj
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:22:37 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fEpeS-0007cc-LO
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:22:32 -0400
Received: by mail-pf0-x244.google.com with SMTP id e9so14965844pfi.4
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 22:22:32 -0700 (PDT)
Date: Sat, 5 May 2018 14:22:29 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180505052229.GC4501@lianli.shorne-pla.net>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
	<20180504054030.24527-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504054030.24527-3-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 02/13] target/openrisc: Start conversion to
 decodetree.py
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

On Thu, May 03, 2018 at 10:40:19PM -0700, Richard Henderson wrote:
> Begin with the 0x08 major opcode, the system instructions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Stafford Horne <shorne@gmail.com>
> ---
>  target/openrisc/translate.c   | 79 +++++++++++++++++++++----------------------
>  target/openrisc/Makefile.objs |  9 +++++
>  target/openrisc/insns.decode  | 28 +++++++++++++++
>  3 files changed, 76 insertions(+), 40 deletions(-)
>  create mode 100644 target/openrisc/insns.decode
 
