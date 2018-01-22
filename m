Received: from eggs.gnu.org ([2001:4830:134:3::10]:53411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ediL3-00044d-27
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ediKz-0005b4-Tb
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:05:05 -0500
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:39608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ediKz-0005ai-OR
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:05:01 -0500
Received: by mail-pf0-x231.google.com with SMTP id e11so7918778pff.6
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 12:05:01 -0800 (PST)
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-4-richard.henderson@linaro.org>
	<CAFEAcA_Xy=3Twb_J1VrcT4QnKK=PVbVc_YGBd58ADX7z2YkkaA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <938eb6f2-f8b4-8a32-7da6-b9c8fde047ac@linaro.org>
Date: Mon, 22 Jan 2018 12:04:57 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Xy=3Twb_J1VrcT4QnKK=PVbVc_YGBd58ADX7z2YkkaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10.5 03/20] tcg: Standardize integral
 arguments to expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 01/22/2018 11:17 AM, Peter Maydell wrote:
>> -void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
>> +void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> 
> Does changing these types from unsigned to signed definitely
> not result in any possible change in behaviour of frontend
> code if there's now an unintended sign extension ? I thought
> maybe there was, but now I think I was confused and this is safe...

It definitely does not.

For andi, we pass the value along to movi, which always has examined only the
low 32-bits.  For the shifts, we assert the value is 0 <= x < 32.


r~
