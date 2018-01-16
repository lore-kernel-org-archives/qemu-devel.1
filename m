Received: from eggs.gnu.org ([2001:4830:134:3::10]:36903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebZIZ-0003e4-Sk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebZIV-0008UM-Pv
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:01:38 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:56144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ebZIV-0008T8-Gl
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:01:35 -0500
References: <20180116172510.28878-1-laurent@vivier.eu>
	<20180116172510.28878-5-laurent@vivier.eu>
	<b9a0f743-3f5d-56a0-3647-5785d1b14e89@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <745b1f1b-2930-0f30-5c6f-4ea47969509e@vivier.eu>
Date: Tue, 16 Jan 2018 23:01:17 +0100
MIME-Version: 1.0
In-Reply-To: <b9a0f743-3f5d-56a0-3647-5785d1b14e89@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] linux-user: MIPS set cpu to r6 CPU
 if binary is R6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Aaron Sierra <asierra@xes-inc.com>

Le 16/01/2018 à 21:26, Richard Henderson a écrit :
> On 01/16/2018 09:25 AM, Laurent Vivier wrote:
>> From: YunQiang Su <syq@debian.org>
>>
>> So here we need to detect the version of binaries and set
>> cpu_model for it.
>>
>> [lv: original patch modified to move code into cpu_get_model()]
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
>>  static inline const char *cpu_get_model(uint32_t eflags)
>>  {
>> +     if ((eflags & EF_MIPS_ARCH_32R6) != 0) {
>> +         return "mips32r6-generic";
>> +     }
>>      return "24Kf";
> 
> That said, I don't suppose it's worth diagnosing cases that we can't support
> somehow?  E.g. mips-linux-user and EF_MIPS_ARCH_64.  Or even coldfire ISA-C.

Yes, the idea is "if we don't know, do as before":
the real error will be reported by the loader.

Thanks,
Laurent
