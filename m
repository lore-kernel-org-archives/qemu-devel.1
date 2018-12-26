Received: from eggs.gnu.org ([208.118.235.92]:51402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbygQ-0001Zk-7j
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 21:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbygJ-0000Cu-QA
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 21:12:29 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:40567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbygI-00009x-Qk
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 21:12:23 -0500
Received: by mail-pf1-x429.google.com with SMTP id i12so7261507pfo.7
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 18:12:22 -0800 (PST)
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
Date: Wed, 26 Dec 2018 13:12:14 +1100
MIME-Version: 1.0
In-Reply-To: <CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Renieris <makren67@gmail.com>
Cc: qemu-devel@nongnu.org

On 12/26/18 12:28 PM, Nick Renieris wrote:
> Hi Richard,
> 
> I did know about https://github.com/andikleen/qemu-avx but didn't
> mention it as it seems abandoned and quite old (also it doesn't use
> `TCGv_vec`).

Yep.  Mine pre-dates tcg-op-gvec.h as well.

> Do you think this could work as a GSoC project? I'm potentially
> interested in working on it this summer.

Could be.  My first guess is something like 4 months work for this.


r~
