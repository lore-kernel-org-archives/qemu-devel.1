Received: from eggs.gnu.org ([2001:4830:134:3::10]:47592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eCT8p-0000x1-Vp
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eCT8p-0002Aj-AA
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:23:51 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171108153245.20740-1-alex.bennee@linaro.org>
	<20171108153245.20740-2-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <42f49754-f402-694e-fbe4-acad66761863@twiddle.net>
Date: Wed, 8 Nov 2017 17:23:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171108153245.20740-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] accel/tcg/translate-all: expand
 cpu_restore_state addr check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 11/08/2017 04:32 PM, Alex Bennée wrote:
> We are still seeing signals during translation time when we walk over
> a page protection boundary. This expands the check to ensure the host
> PC is inside the code generation buffer. The original suggestion was
> to check versus tcg_ctx.code_gen_ptr but as we now segment the
> translation buffer we have to settle for just a general check for
> being inside.
> 
> I've also fixed up the declaration to make it clear it can deal with
> invalid addresses. A later patch will fix up the call sites.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
