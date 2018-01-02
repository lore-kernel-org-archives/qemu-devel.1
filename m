Received: from eggs.gnu.org ([2001:4830:134:3::10]:53934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWRRc-00006c-Jf
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWRRY-0007qt-DH
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:37:48 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:54208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWRRY-0007q8-3j
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:37:44 -0500
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-6-laurent@vivier.eu>
	<ec748459-b9d7-b485-ffd0-11266d229c14@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b6abdd69-3abf-a887-10db-6e80180f2d1c@vivier.eu>
Date: Tue, 2 Jan 2018 19:37:40 +0100
MIME-Version: 1.0
In-Reply-To: <ec748459-b9d7-b485-ffd0-11266d229c14@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 05/17] target/m68k: add CPU_LOG_INT trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

Le 02/01/2018 à 17:10, Richard Henderson a écrit :
> On 01/01/2018 05:10 PM, Laurent Vivier wrote:
>> Display the interrupts/exceptions information
>> in QEMU logs (-d int)
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +    if (qemu_loglevel_mask(CPU_LOG_INT)) {
>> +        static int count;
>> +        qemu_log("INT %6d: %s(%#x) pc=%08x sp=%08x sr=%04x\n",
>> +                 ++count, m68k_exception_name(cs->exception_index),
>> +                 vector, env->pc, env->aregs[7], env->sr);
>> +    }
>> +
>>      fmt |= 0x40000000;
>>      fmt |= vector << 16;
>>      fmt |= env->sr;
> 
> Just so long as you're aware that you're printing the SR without CCR here...

I will update the qemu_log() to have the real SR value with the CCR.

Thanks,
Laurent
