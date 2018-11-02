Received: from eggs.gnu.org ([2001:4830:134:3::10]:60618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIW6J-0004og-LQ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIW6H-0002bG-0f
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:50:47 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gIW69-0002Qr-7E
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:50:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id q19-v6so1412505wmc.2
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 02:50:32 -0700 (PDT)
References: <20181101215739.29788-1-richard.henderson@linaro.org>
	<CAFEAcA_HrcAfHaLW+hT0btN6C=GZv7VYWmhz3ri-QSL9ySZ0qg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <72f81077-d400-31b5-0e6f-fb59a4bbae53@linaro.org>
Date: Fri, 2 Nov 2018 09:50:28 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_HrcAfHaLW+hT0btN6C=GZv7VYWmhz3ri-QSL9ySZ0qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Conditionalize arm_div assert
 on aarch32 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/2/18 9:48 AM, Peter Maydell wrote:
>> +static inline bool isar_feature_aa64_a32(const ARMISARegisters *id)
>> +{
>> +    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) == 2;
>> +}
>> +
> 
> Doesn't the stuff in the Arm ARM's "Principles of the ID
> scheme for fields in ID registers" about signed and unsigned
> values for ID register fields strictly mean you want to be
> testing (unsigned) >= 2 here rather than strict equality?

Yes.  Will fix.


r~
