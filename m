Received: from eggs.gnu.org ([2001:4830:134:3::10]:40425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fEphF-0003a1-Oh
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fEphA-0001dd-Qn
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:25:25 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:43036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fEphA-0001d4-KN
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:25:20 -0400
Received: by mail-pg0-x242.google.com with SMTP id k11-v6so15646843pgo.10
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 22:25:20 -0700 (PDT)
Date: Sat, 5 May 2018 14:25:17 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180505052517.GD4501@lianli.shorne-pla.net>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
	<20180504054030.24527-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504054030.24527-4-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 03/13] target/openrisc: Convert branch insns
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

On Thu, May 03, 2018 at 10:40:20PM -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  target/openrisc/translate.c  | 149 +++++++++++++++++++++----------------------
>  target/openrisc/insns.decode |  12 ++++
>  2 files changed, 83 insertions(+), 78 deletions(-)
> 
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
 
