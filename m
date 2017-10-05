Received: from eggs.gnu.org ([2001:4830:134:3::10]:49312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e096v-00031s-Tl
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e096u-0004gi-VP
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:34:57 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:45907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e096u-0004gJ-S1
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:34:56 -0400
Received: by mail-qt0-x22a.google.com with SMTP id k1so15487516qti.2
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:34:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-9-git-send-email-peter.maydell@linaro.org>
	<0136d727-d125-7eed-ca13-02011cbdf921@linaro.org>
Message-ID: <4aa8a101-7de4-43d5-716a-b188a7190277@linaro.org>
Date: Thu, 5 Oct 2017 12:34:53 -0400
MIME-Version: 1.0
In-Reply-To: <0136d727-d125-7eed-ca13-02011cbdf921@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/20] target/arm: Don't warn about
 exception return with PC low bit set for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 10/05/2017 12:32 PM, Richard Henderson wrote:
>     if (env->regs[15] & 1) {
>         if (!arm_feature(env, ARM_FEATURE_V8)) {
>             qemu_log_mask(...);
>         }
>         env->regs[15] &= ~1U;
>     }

Bah.  Even better to move the bit clear statement before the feature check.
The two loads from env->regs[15] will no longer be separated by a function call
and therefore CSEd by the compiler.


r~
