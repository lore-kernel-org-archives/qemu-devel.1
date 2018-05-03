Received: from eggs.gnu.org ([2001:4830:134:3::10]:50588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFCH-0004Ml-Re
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFC8-0002zC-Jn
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:27:01 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:33098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEFC8-0002ym-8n
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:26:52 -0400
Received: by mail-ot0-x233.google.com with SMTP id l22-v6so20850188otj.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 07:26:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_trFkyHOofragLEKpsNP67t4-3ZbSyCAgU2nYG75Zg5A@mail.gmail.com>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-7-richard.henderson@linaro.org>
	<CAFEAcA_trFkyHOofragLEKpsNP67t4-3ZbSyCAgU2nYG75Zg5A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 15:26:31 +0100
Message-ID: <CAFEAcA9VKUfy3_GC-=+ZqwMdYOwaG-bUKZjNXvm=wsLksRv5cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 6/9] target/arm: Introduce
 ARM_FEATURE_V8_ATOMICS and initial decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 3 May 2018 at 14:59, Peter Maydell <peter.maydell@linaro.org> wrote:
> What about LDAPRB, LDAPRH, LDAPR (which are o3_opc == 0b1100) ?

Ah, my mistake, those are part of RCPC, not atomics.



thanks
-- PMM
