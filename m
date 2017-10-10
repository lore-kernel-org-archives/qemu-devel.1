Received: from eggs.gnu.org ([2001:4830:134:3::10]:37800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1xbs-0007A7-Jz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1xbp-00087s-IR
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:42:24 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:54862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1xbp-00087X-C9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:42:21 -0400
Received: by mail-pf0-x233.google.com with SMTP id m28so12869017pfi.11
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 09:42:21 -0700 (PDT)
References: <20171010151811.19935-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <70503bef-87c2-e642-3890-fadf4fc5e4a5@linaro.org>
Date: Tue, 10 Oct 2017 09:42:17 -0700
MIME-Version: 1.0
In-Reply-To: <20171010151811.19935-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nios2: define tcg_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Marek Vasut <marex@denx.de>, thuth@redhat.com, qemu-stable@nongnu.org

On 10/10/2017 08:18 AM, Paolo Bonzini wrote:
> This should be done by all target and, since commit 53f6672bcf
> ("gen-icount: use tcg_ctx.tcg_env instead of cpu_env", 2017-06-30),
> is causing the NIOS2 target to hang.
> 
> This is because the test for "should I exit to the main loop"
> was being done with the correct offset to the icount decrementer,
> but using TCG temporary 0 (the frame pointer) rather than the
> env pointer.
> 
> Cc: qemu-stable@nongnu.org
> Cc: Marek Vasut <marex@denx.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/nios2/translate.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
