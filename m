Received: from eggs.gnu.org ([2001:4830:134:3::10]:33835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnq1J-0003uQ-V0
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnq1G-0000ZC-38
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:50:50 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fnq1F-0000Yw-R0
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:50:46 -0400
Received: by mail-pg1-x542.google.com with SMTP id n7-v6so3161653pgq.4
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 11:50:45 -0700 (PDT)
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-9-richard.henderson@linaro.org>
	<87bmabpggu.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <accbf705-44bd-dae5-9765-3e4f25db23d0@linaro.org>
Date: Thu, 9 Aug 2018 11:50:41 -0700
MIME-Version: 1.0
In-Reply-To: <87bmabpggu.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/20] target/arm: Pass in current_el to fp
 and sve_exception_el
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org

On 08/09/2018 11:01 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> We are going to want to determine whether sve is enabled
>> for EL than current.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Are these patches meant to apply to origin/master or on top of the
> user-mode fixes? This didn't apply for me:

On top of the user-mode fixes.

Based-on: <20180809034033.10579-1-richard.henderson@linaro.org>

And of course you can see it all on my sve-3.1 branch.


r~
