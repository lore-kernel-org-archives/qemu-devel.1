Received: from eggs.gnu.org ([2001:4830:134:3::10]:35637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMuI-0006dG-Gd
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 19:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMuD-0006Z8-Tg
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 19:05:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-18-git-send-email-peter.maydell@linaro.org>
	<dfd92b0b-45c5-cdb3-702c-c746d77d74ab@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bc503ce4-d2f6-1d42-341c-f3bccf15fc7a@amsat.org>
Date: Tue, 5 Sep 2017 20:05:13 -0300
MIME-Version: 1.0
In-Reply-To: <dfd92b0b-45c5-cdb3-702c-c746d77d74ab@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 17/20] target/arm: Make MMFAR
 banked for v8M
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

On 08/29/2017 01:10 PM, Richard Henderson wrote:
> On 08/22/2017 08:08 AM, Peter Maydell wrote:
>> Make the MMFAR register banked if v8M security extensions are
>> enabled.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   target/arm/cpu.h      | 2 +-
>>   hw/intc/armv7m_nvic.c | 4 ++--
>>   target/arm/helper.c   | 4 ++--
>>   target/arm/machine.c  | 3 ++-
>>   4 files changed, 7 insertions(+), 6 deletions(-)
> 
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
