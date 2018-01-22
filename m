Received: from eggs.gnu.org ([2001:4830:134:3::10]:44606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edegm-0005vb-IT
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edegh-0000ty-Cr
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:11:16 -0500
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:38963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edegh-0000tU-7i
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:11:11 -0500
Received: by mail-pg0-x232.google.com with SMTP id w17so7428454pgv.6
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:11:11 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-12-richard.henderson@linaro.org>
	<87shayj9jx.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2efd8a70-3eba-680b-27db-230d5f2088e9@linaro.org>
Date: Mon, 22 Jan 2018 08:11:07 -0800
MIME-Version: 1.0
In-Reply-To: <87shayj9jx.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/16] target/arm: Add SVE to migration
 state
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

On 01/22/2018 05:40 AM, Alex Bennée wrote:
>> +#ifdef TARGET_AARCH64
>> +/* The expression ARM_MAX_VQ - 2 is 0 for pure AArch32 build,
>> + * and ARMPredicateReg is actively empty.  This triggers errors
>> + * in the expansion of the VMSTATE macros.
>> + */
> 
> This makes me think that #ifdef-ing out the pregs might be better for
> the 32 bit target build.

Fair.


r~
