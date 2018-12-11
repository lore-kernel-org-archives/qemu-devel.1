Received: from eggs.gnu.org ([208.118.235.92]:58887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWmf0-0005dZ-81
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWmew-0003Jk-A7
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:21:34 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWmew-0003Hh-1A
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:21:30 -0500
Received: by mail-ot1-x341.google.com with SMTP id k98so15008820otk.3
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 10:21:29 -0800 (PST)
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-18-richard.henderson@linaro.org>
	<CAFEAcA_stGu-L5oH2gLbmsnS2QVPOxz4kg-ToJQfWSHmMf1unA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cece9872-74a9-3db6-456a-7a42e7f1a44d@linaro.org>
Date: Tue, 11 Dec 2018 12:21:25 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_stGu-L5oH2gLbmsnS2QVPOxz4kg-ToJQfWSHmMf1unA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/26] target/arm: Reuse aa64_va_parameters
 for setting tbflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On 12/11/18 10:52 AM, Peter Maydell wrote:
> This has lost the bit of the old functions that converted
> the stage 1+2 MMU index into a stage 1 MMU index. The call
> to regime_el() in aa64_va_parameters() will assert if it is
> passed ARMMMUIdx_S12NSE0 or ARMMMUIdx_S12NSE1. (In the code
> paths in the get_phys_addr() functions, this is handled by
> the top level get_phys_addr() code, so get_phys_addr_lpae()
> never sees a stage 1+2 MMU index.)

Yes, I've got a fixup patch on my branch for this.
It showed up quite early booting bios.  ;-)


r~
