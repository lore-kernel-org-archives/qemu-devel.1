Received: from eggs.gnu.org ([2001:4830:134:3::10]:42148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fH9mp-0002Oa-Vl
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fH9mm-0006fU-QD
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:16:47 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:41042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fH9mm-0006fN-KM
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:16:44 -0400
Received: by mail-pg0-x231.google.com with SMTP id w4-v6so939803pgq.8
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 08:16:44 -0700 (PDT)
References: <20180511004345.26708-1-richard.henderson@linaro.org>
	<20180511004345.26708-3-richard.henderson@linaro.org>
	<87fu2yvdl4.fsf@linaro.org> <87d0y2ut81.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1a95ded2-ef74-dc13-39af-683f91529a36@linaro.org>
Date: Fri, 11 May 2018 08:16:40 -0700
MIME-Version: 1.0
In-Reply-To: <87d0y2ut81.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/19] fpu/softfloat: Split
 floatXX_silence_nan from floatXX_maybe_silence_nan
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

On 05/11/2018 08:06 AM, Alex Bennée wrote:
> but...but...
>>> -float16 float16_maybe_silence_nan(float16 a_, float_status *status)
>>> +
>>> +float16 float16_maybe_silence_nan(float16 a, float_status *status)
>>>  {
>>> +    if (float16_is_signaling_nan(a, status)) {
>>> +        float16_silence_nan(a, status);
> 
> You need a return here.

Oops.

> Amazing what tests pass with those in, but RISU picked them up.

Heh.  In my case I hadn't bothered testing until further down the patch set
when these functions have been removed.


r~
