Received: from eggs.gnu.org ([2001:4830:134:3::10]:60993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cjTuV-0006hp-4z
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cjTuU-0003xE-1r
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:48:59 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-mc6JXzq=s7C5tkH-rokibOPtpcuLee10k1b1PYqxz1A@mail.gmail.com>
References: <20170301182618.22395-1-krzk@kernel.org>
	<20170301182618.22395-5-krzk@kernel.org>
	<CAFEAcA-mc6JXzq=s7C5tkH-rokibOPtpcuLee10k1b1PYqxz1A@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 2 Mar 2017 18:48:48 +0200
Message-ID: <CAJKOXPf0zEF0UTTmLwuNem0w35mwy8fSgf+kcWbXxy1ociXwQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 4/5] hw/timer/exynos4210_mct: Fix
 checkpatch style errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>

On Thu, Mar 2, 2017 at 6:44 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 1 March 2017 at 18:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> Fix checkpatch errors:
>> 1. ERROR: spaces required around that '+' (ctx:VxV)
>> 2. ERROR: spaces required around that '&' (ctx:VxV)
>>
>> No functional changes.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  hw/timer/exynos4210_mct.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
>> index 76634fb1b4fd..4dd3e441e2e6 100644
>> --- a/hw/timer/exynos4210_mct.c
>> +++ b/hw/timer/exynos4210_mct.c
>> @@ -936,7 +936,7 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
>>  {
>>      uint32_t freq = s->freq;
>>      s->freq = 24000000 /
>> -            ((MCT_CFG_GET_PRESCALER(s->reg_mct_cfg)+1) *
>> +            ((MCT_CFG_GET_PRESCALER(s->reg_mct_cfg) + 1) *
>>                      MCT_CFG_GET_DIVIDER(s->reg_mct_cfg));
>>
>>      if (freq != s->freq) {
>> @@ -1160,7 +1160,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>>
>>          DPRINTF("comparator %d write 0x%llx val << %d\n", index, value, shift);
>>
>> -        if (offset&0x4) {
>> +        if (offset & 0x4) {
>>              s->g_timer.reg.wstat |= G_WSTAT_COMP_U(index);
>>          } else {
>>              s->g_timer.reg.wstat |= G_WSTAT_COMP_L(index);
>
> PS: you can shut the patchew robot up if you want by squashing this
> patch into patch 3, since one line is being changed in that patch
> anyway and an extra line in what's a "fix whitespace" patch
> anyway is no big deal. Or you can leave it the way you have
> it now; I don't mind.

Yes, I saw the warning. I could also sent them in reversed order. As
of squashing commits I think it is useful to have them separate
because change of indentation creates a difficult to read diff. Such
diff can sneak by other changes and it would not be spotted.

Best regards,
Krzysztof
