Received: from eggs.gnu.org ([2001:4830:134:3::10]:36398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eS40j-0004Ck-F6
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eS40g-0007sP-EK
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:47:57 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:37799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eS40g-0007rt-7v
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:47:54 -0500
Received: by mail-pl0-x242.google.com with SMTP id s3so11258871plp.4
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 08:47:54 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171221160558.14151-1-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9620330b-0f2c-84d6-4358-e8b7385d097e@twiddle.net>
Date: Thu, 21 Dec 2017 08:47:49 -0800
MIME-Version: 1.0
In-Reply-To: <20171221160558.14151-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/m68k: fix set_cc_op()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 12/21/2017 08:05 AM, Laurent Vivier wrote:
> The first call of set_cc_op() in a new translation sequence
> is done with old_op set to CC_OP_DYNAMIC (-1).
> 
> This will do an out of bound access to the array cc_op_live[].
> 
> We fix that by adding an entry in cc_op_live[] for CC_OP_DYNAMIC.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v2: no need to discard QREG_CC_OP (rth)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
