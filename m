Received: from eggs.gnu.org ([2001:4830:134:3::10]:60944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMjQ-0002Du-OR
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMjM-0005hl-Ab
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:54:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-8-git-send-email-peter.maydell@linaro.org>
	<918b7d17-8a0a-1ff5-d31a-5ee09479ee2f@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a007e3eb-3de0-5604-2ab1-afca97c56346@amsat.org>
Date: Tue, 5 Sep 2017 19:53:59 -0300
MIME-Version: 1.0
In-Reply-To: <918b7d17-8a0a-1ff5-d31a-5ee09479ee2f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 07/20] target/arm: Make PRIMASK
 register banked for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, patches@linaro.org

> On 08/22/2017 08:08 AM, Peter Maydell wrote:
>> Make the PRIMASK register banked if v8M security extensions are enabled.
>>
>> Note that we do not yet implement the functionality of the new
>> AIRCR.PRIS bit (which allows the effect of the NS copy of PRIMASK to
>> be restricted).
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   target/arm/cpu.h      | 2 +-
>>   hw/intc/armv7m_nvic.c | 2 +-
>>   target/arm/helper.c   | 4 ++--
>>   target/arm/machine.c  | 9 +++++++--
>>   4 files changed, 11 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
