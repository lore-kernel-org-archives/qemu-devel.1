Received: from eggs.gnu.org ([2001:4830:134:3::10]:45738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ef8R8-0002zH-8C
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ef8R4-00016q-2o
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:09:14 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:44304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ef8R3-00016R-Sw
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:09:10 -0500
Received: by mail-pf0-x242.google.com with SMTP id m26so755325pfj.11
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 10:09:09 -0800 (PST)
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-12-richard.henderson@linaro.org>
	<878tcl6j68.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e2e4e748-f37f-e306-658e-bc4c24f94d65@linaro.org>
Date: Fri, 26 Jan 2018 08:43:15 -0800
MIME-Version: 1.0
In-Reply-To: <878tcl6j68.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v10.5 11/20] target/arm: Align vector
 registers
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

On 01/26/2018 01:52 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 96316700dd..3ff4dea6b8 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -492,7 +492,7 @@ typedef struct CPUARMState {
>>           * the two execution states, and means we do not need to explicitly
>>           * map these registers when changing states.
>>           */
>> -        float64 regs[64];
>> +        float64 regs[64] QEMU_ALIGNED(16);
> 
> There is a minor conflict that needs to be fixed with the now merged: 3f68b8a5a6862f856524bb347bf348ae364dd43c


Already done in v11 which I posted last night.


r~
