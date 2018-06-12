Received: from eggs.gnu.org ([2001:4830:134:3::10]:39195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fSrU0-0004Gn-0O
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fSrTw-0001yp-Mj
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:09:43 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fSrTw-0001yR-Eo
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:09:40 -0400
Received: by mail-pf0-x243.google.com with SMTP id b74-v6so247256pfl.5
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 15:09:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180611125633.32755-1-peter.maydell@linaro.org>
	<20180611125633.32755-2-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a0916aa8-a78d-4cf7-15e1-4d17aad6da08@twiddle.net>
Date: Tue, 12 Jun 2018 12:09:33 -1000
MIME-Version: 1.0
In-Reply-To: <20180611125633.32755-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] cpu-defs.h: Document CPUIOTLBEntry
 'addr' field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/11/2018 02:56 AM, Peter Maydell wrote:
> The 'addr' field in the CPUIOTLBEntry struct has a rather non-obvious
> use; add a comment documenting it (reverse-engineered from what
> the code that sets it is doing).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/exec/cpu-defs.h |  9 +++++++++
>  accel/tcg/cputlb.c      | 12 ++++++++++++
>  2 files changed, 21 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
