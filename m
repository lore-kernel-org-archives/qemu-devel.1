Received: from eggs.gnu.org ([209.51.188.92]:43429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHknd-0006cS-Dr
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkYL-0001kV-Sw
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:51 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkYL-0001j1-Kw
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:49 -0400
Received: by mail-pg1-x543.google.com with SMTP id z9so3581615pgu.10
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:36:49 -0700 (PDT)
References: <20190420072236.12347-1-shahab.vahedi@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9059f1f6-fb28-7291-72e4-ae0fd3d4cca9@linaro.org>
Date: Fri, 19 Apr 2019 21:36:44 -1000
MIME-Version: 1.0
In-Reply-To: <20190420072236.12347-1-shahab.vahedi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] cputlb: Fix io_readx() to respect the
 access_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shahab Vahedi <shahab.vahedi@gmail.com>, "open list:Overall" <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 4/19/19 9:22 PM, Shahab Vahedi wrote:
> This change adapts io_readx() to its input access_type. Currently
> io_readx() treats any memory access as a read, although it has an
> input argument "MMUAccessType access_type". This results in:
> 
> 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> 2) Considering only entry->addr_read as the tlb_addr
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
> 
> Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> ---
> Changelog:
> v3
>   - Only handle read/fetch. There must be no write access.
> 
> v2
>   - Extra space before closing parenthesis is removed
> 
> v1
>   - Initial submit
> 
>  accel/tcg/cputlb.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
