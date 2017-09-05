Received: from eggs.gnu.org ([2001:4830:134:3::10]:36708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMyc-00084r-D2
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 19:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMyX-0000Hb-Ga
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 19:09:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-4-git-send-email-peter.maydell@linaro.org>
	<9af3401e-031a-3ae3-d2fc-315dab3ef9e1@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3495db71-0325-29be-1943-b8344a023984@amsat.org>
Date: Tue, 5 Sep 2017 20:09:41 -0300
MIME-Version: 1.0
In-Reply-To: <9af3401e-031a-3ae3-d2fc-315dab3ef9e1@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/20] target/arm: Add state field,
 feature bit and migration for v8M secure state
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

On 08/29/2017 12:28 PM, Richard Henderson wrote:
> On 08/22/2017 08:08 AM, Peter Maydell wrote:
>> As the first step in implementing ARM v8M's security extension:
>>   * add a new feature bit ARM_FEATURE_M_SECURITY
>>   * add the CPU state field that indicates whether the CPU is
>>     currently in the secure state
>>   * add a migration subsection for this new state
>>     (we will add the Secure copies of banked register state
>>     to this subsection in later patches)
>>   * add a #define for the one new-in-v8M exception type
>>   * make the CPU debug log print S/NS status
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   target/arm/cpu.h       |  3 +++
>>   target/arm/cpu.c       |  4 ++++
>>   target/arm/machine.c   | 20 ++++++++++++++++++++
>>   target/arm/translate.c |  8 +++++++-
>>   4 files changed, 34 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
