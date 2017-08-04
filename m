Received: from eggs.gnu.org ([2001:4830:134:3::10]:46955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddivD-0003O1-Sc
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 16:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddivA-00064N-NU
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 16:10:11 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:33541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ddivA-00060e-HV
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 16:10:08 -0400
Received: by mail-pf0-x22b.google.com with SMTP id d67so11777930pfc.0
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 13:10:08 -0700 (PDT)
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-7-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <83c6b830-d15a-633a-c310-e3e541f1a6e2@linaro.org>
Date: Fri, 4 Aug 2017 13:10:04 -0700
MIME-Version: 1.0
In-Reply-To: <1501867249-1924-7-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/8] target/arm: Factor out fault delivery
 code
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

On 08/04/2017 10:20 AM, Peter Maydell wrote:
> +    if (fsc == 0x3f) {
> +        /* Caller doesn't have a long-format fault status code. This
> +         * should only happen if this fault will never actually be reported
> +         * to an EL that uses a syndrome register. Check that here.
> +         * 0x3f is a (currently) reserved FSR code, in case the constructed
> +         * syndrome does leak into the guest somehow.
> +         */
> +        assert(target_el != 2 && !arm_el_is_aa64(env, target_el));
> +    }

I see that this is just code movement, but there appears to be a typo in the
comment, confusing fsc vs fsr and the 0x3f reserved value.

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
