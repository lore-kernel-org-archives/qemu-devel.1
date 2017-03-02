Received: from eggs.gnu.org ([2001:4830:134:3::10]:36734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjX2s-0004Y4-5u
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjX2r-0002Ce-A9
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:09:50 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjX2r-0002B5-3j
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:09:49 -0500
Received: by mail-wm0-x232.google.com with SMTP id n11so435645wma.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 12:09:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8dP-Z_srttBZSOOONkXGSka-vXrDdVbPGR64Q+Ko=ooA@mail.gmail.com>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<e160b509a76bcf00d1af4665e26c6870eb363cab.1488068248.git.balaton@eik.bme.hu>
	<CAFEAcA8dP-Z_srttBZSOOONkXGSka-vXrDdVbPGR64Q+Ko=ooA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 20:09:27 +0000
Message-ID: <CAFEAcA_UCiFXy-RyMdduiRhXg4f5m6M=AcR2Uvr_r7=f37zUeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 06/14] sm501: Add missing arbitration
 control register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 2 March 2017 at 20:08, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 3 December 2016 at 15:32, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/sm501.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index d9219bd..b977094 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -477,6 +477,7 @@ typedef struct SM501State {
>>      uint32_t gpio_31_0_control;
>>      uint32_t gpio_63_32_control;
>>      uint32_t dram_control;
>> +    uint32_t arbitration_control;
>>      uint32_t irq_mask;
>>      uint32_t misc_timing;
>>      uint32_t power_mode_control;
>> @@ -760,6 +761,9 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
>>      case SM501_DRAM_CONTROL:
>>          ret = (s->dram_control & 0x07F107C0) | s->local_mem_size_index << 13;
>>          break;
>> +    case SM501_ARBTRTN_CONTROL:
>> +        ret = s->arbitration_control;
>> +        break;
>>      case SM501_IRQ_MASK:
>>          ret = s->irq_mask;
>>          break;
>> @@ -812,6 +816,9 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
>>          /* TODO : check validity of size change */
>>          s->dram_control |=  value & 0x7FFFFFC3;
>>          break;
>> +    case SM501_ARBTRTN_CONTROL:
>> +        s->arbitration_control =  value & 0x37777777;
>> +        break;
>>      case SM501_IRQ_MASK:
>>          s->irq_mask = value;
>>          break;
>> --
>> 2.7.4
>
> Applied, thanks.

Doh, wrong canned-email-reply template! I meant

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
