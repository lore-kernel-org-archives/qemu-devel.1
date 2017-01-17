Received: from eggs.gnu.org ([2001:4830:134:3::10]:39284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cTITE-0007yP-Fi
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cTITD-0005qf-OT
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:21:56 -0500
Message-ID: <587D7196.8080209@huawei.com>
Date: Tue, 17 Jan 2017 09:21:26 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1484477462-14088-1-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA_pKX-v6q2uE-5+mWXYyEfooYCUFu4kVEL1N_DS5yjA2A@mail.gmail.com>
In-Reply-To: <CAFEAcA_pKX-v6q2uE-5+mWXYyEfooYCUFu4kVEL1N_DS5yjA2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] arm: virt: Fix the segmentation fault when
 specifying an unsupported CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wu.wubin@huawei.com



On 2017/1/17 1:27, Peter Maydell wrote:
> On 15 January 2017 at 10:51, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> For example, using -cpu generic will cause qemu segmentation fault.
>>
>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> ---
>>  hw/arm/virt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 7a03f84..4b301c2 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -175,7 +175,7 @@ static bool cpuname_valid(const char *cpu)
>>      int i;
>>
>>      for (i = 0; i < ARRAY_SIZE(valid_cpus); i++) {
>> -        if (strcmp(cpu, valid_cpus[i]) == 0) {
>> +        if (valid_cpus[i] != NULL && strcmp(cpu, valid_cpus[i]) == 0) {
>>              return true;
>>          }
>>      }
> 
> A better fix is to just remove the NULL entry from the
> valid_cpus[] array. We already have one "stop when we
> run out of entries" condition (the ARRAY_SIZE check),
> we don't need two...
> 
Right. Will send the update one.

Thanks,
-- 
Shannon
