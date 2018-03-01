Received: from eggs.gnu.org ([2001:4830:134:3::10]:55003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erNci-0004QF-FT
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erNch-00069B-QK
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:47:48 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erNch-00068v-KE
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:47:47 -0500
Received: by mail-ot0-x241.google.com with SMTP id w2so5432726otg.2
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 04:47:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <98d79ce8-3ab0-3c3e-f4ef-9ad381015daf@linaro.org>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-18-peter.maydell@linaro.org>
	<98d79ce8-3ab0-3c3e-f4ef-9ad381015daf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 12:47:26 +0000
Message-ID: <CAFEAcA9Xm6iFg-QsOOL__s2vdSRyRWZZTGb5xegbJrvCccdkyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 17/19] hw/misc/iotkit-secctl: Add remaining
 simple registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 27 February 2018 at 22:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 02/20/2018 10:03 AM, Peter Maydell wrote:
>> +    case A_BRGINTEN:
>> +        s->brginten = value & 0xffff;
>> +        break;
>
> Looks to me like bits 0-15 are read-only 0x0000,
> so, that 0xffff should be 0xffff0000.

Oops, yes, misread that. The relevant bits are [31:16], not [15:0],
for all the BRG registers. This is the only place where it makes a
difference to us, though.

thanks
-- PMM
