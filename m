Received: from eggs.gnu.org ([2001:4830:134:3::10]:59231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUAp5-00023S-W5
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUAp0-000684-Lu
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:33:11 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gUAp0-00066y-8I
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:33:06 -0500
Received: by mail-ot1-x344.google.com with SMTP id k98so15160778otk.3
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 05:33:05 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-8-cota@braap.org> <87h8ft3295.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e39db85e-52b5-bdc8-d9a7-e3a14f78ce4b@linaro.org>
Date: Tue, 4 Dec 2018 07:33:01 -0600
MIME-Version: 1.0
In-Reply-To: <87h8ft3295.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 07/13] fpu: introduce hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 12/4/18 6:28 AM, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
>> This assumes that QEMU is running on an IEEE754-compliant FPU and
>> that the rounding is set to the default (to nearest). The
>> implementation-dependent specifics of the FPU should not matter; things
>> like tininess detection and snan representation are still dealt with in
>> soft-fp. However, this approach will break on most hosts if we compile
>> QEMU with flags such as -ffast-math. We control the flags so this should
>> be easy to enforce though.
> 
> We don't currently enforce this though although maybe that would be too
> much hand holding for compiler ricers hell bent on not understanding the
> flags they use.

We could always

#ifdef __FAST_MATH__
#error "Silliness like this will get you nowhere"
#endif


r~
