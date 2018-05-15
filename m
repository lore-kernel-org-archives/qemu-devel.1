Received: from eggs.gnu.org ([2001:4830:134:3::10]:39091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIc4f-0006xI-Az
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIc4a-0001gC-EC
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:13 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:42974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIc4a-0001f5-7U
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:08 -0400
Received: by mail-pf0-x244.google.com with SMTP id p14-v6so236811pfh.9
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 08:41:07 -0700 (PDT)
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-29-richard.henderson@linaro.org>
	<87a7t1f2x0.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96c3d0f3-9a8e-5c64-0c7a-a8024f90930a@linaro.org>
Date: Tue, 15 May 2018 08:41:04 -0700
MIME-Version: 1.0
In-Reply-To: <87a7t1f2x0.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 28/28] fpu/softfloat: Define
 floatN_silence_nan in terms of parts_silence_nan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 05/15/2018 06:45 AM, Alex Bennée wrote:
>> +float64 float64_silence_nan(float64 a, float_status *status)
>> +{
>> +    return float64_pack_raw(parts_silence_nan(float64_unpack_raw(a), status));
>> +}
>> +
> 
> Not that I'm objecting to the rationalisation but did you look at the
> code generated now we unpack NaNs? I guess NaN behaviour isn't the
> critical path for performance anyway....

Yes, I looked.  It's about 5 instructions instead of 1.
But as you say, it's nowhere near critical path.

Ug.  I've also just realized that the shift isn't correct though...


r~
