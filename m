Received: from eggs.gnu.org ([2001:4830:134:3::10]:44419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZSr-0007WQ-CO
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZSq-0006ql-Hq
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:08:09 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYZSq-0006p5-By
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:08:08 -0400
Received: by mail-ot0-x242.google.com with SMTP id q11-v6so4516030otk.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:08:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8c0706a5-6601-9945-9312-c3a0775c3d83@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-34-richard.henderson@linaro.org>
	<CAFEAcA_ZfQ1y0=sWBqLGSbd5qoBvhSthUy_udDi-aE5U66DLLg@mail.gmail.com>
	<8c0706a5-6601-9945-9312-c3a0775c3d83@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 17:07:46 +0100
Message-ID: <CAFEAcA9zoojsDy+5NRSd693GVfVCqQOVCQ=15jhFWx8bXB_FFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 33/35] target/arm: Implement SVE dot
 product (indexed)
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

On 28 June 2018 at 16:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 06/28/2018 06:07 AM, Peter Maydell wrote:
>>>  # SVE integer dot product (unpredicated)
>>> -DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5
>>> +DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5 ra=%reg_movprfx
>>
>> Shouldn't this have been in a different patch ?
>
> Dammit, you pointed this out last time and I missed it
> when going back through all of the nits.
>
> Do you want me to re-spin all or part of the patch set?

No, I've just made the fix locally in target-arm.next.

-- PMM
