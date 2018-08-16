Received: from eggs.gnu.org ([2001:4830:134:3::10]:46698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHjx-0003gL-Ct
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHjv-00042Q-1j
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:51:01 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqHjr-000417-TW
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:50:58 -0400
Received: by mail-oi0-x242.google.com with SMTP id b15-v6so7731089oib.10
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 05:50:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180810193129.1556-1-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 13:50:34 +0100
Message-ID: <CAFEAcA_Hs7oyHBu6vS5p0eaA1KEQaW4Zzn7m7eR3UYwmvY+i=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/6] target/arm: More sve-ish fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 10 August 2018 at 20:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> All from problems reported by Laurent this week.  Five of them are
> SVE related, but while trying to simplify one of the reports I
> discovered that I had broken ARMv8.3 just before final commit.
>
>
> r~
>
>
> Richard Henderson (6):
>   target/arm: Adjust FPCR_MASK for FZ16
>   target/arm: Ignore float_flag_input_denormal from fp_status_f16
>   target/arm: Use fp_status_fp16 for do_fmpa_zpzzz_h
>   target/arm: Use FZ not FZ16 for SVE FCVT single-half and double-half
>   target/arm: Fix aa64 FCADD and FCMLA decode
>   softfloat: Fix missing inexact for floating-point add



Applied to target-arm.next, thanks.

-- PMM
