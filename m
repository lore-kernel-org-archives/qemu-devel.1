Received: from eggs.gnu.org ([2001:4830:134:3::10]:40552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYZIS-0008Bj-G5
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYZIN-0002wZ-M3
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:57:24 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:35765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYZIN-0002vn-72
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:57:19 -0400
Received: by mail-pg0-x233.google.com with SMTP id i7-v6so2659771pgp.2
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:57:19 -0700 (PDT)
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-34-richard.henderson@linaro.org>
	<CAFEAcA_ZfQ1y0=sWBqLGSbd5qoBvhSthUy_udDi-aE5U66DLLg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8c0706a5-6601-9945-9312-c3a0775c3d83@linaro.org>
Date: Thu, 28 Jun 2018 08:57:15 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ZfQ1y0=sWBqLGSbd5qoBvhSthUy_udDi-aE5U66DLLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 06/28/2018 06:07 AM, Peter Maydell wrote:
>>  # SVE integer dot product (unpredicated)
>> -DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5
>> +DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5 ra=%reg_movprfx
> 
> Shouldn't this have been in a different patch ?

Dammit, you pointed this out last time and I missed it
when going back through all of the nits.

Do you want me to re-spin all or part of the patch set?


r~
