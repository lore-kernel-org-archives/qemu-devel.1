Received: from eggs.gnu.org ([2001:4830:134:3::10]:59781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5gf-0003ou-CE
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 06:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5gc-00084Y-A6
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 06:50:49 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5gc-00084D-3l
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 06:50:46 -0500
Received: by mail-wr0-x243.google.com with SMTP id p104so12603035wrc.12
	for <qemu-devel@nongnu.org>; Sat, 03 Mar 2018 03:50:45 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215221325.7611-1-f4bug@amsat.org>
	<20180215221325.7611-21-f4bug@amsat.org>
	<CAFEAcA_x_pubHXUkAe-mFD5Xw2L4Uo+3sYFYd=c+yV2+NuSDmQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ad2012ef-cf8f-5627-a76c-bac57c5f37cb@amsat.org>
Date: Sat, 3 Mar 2018 08:50:19 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_x_pubHXUkAe-mFD5Xw2L4Uo+3sYFYd=c+yV2+NuSDmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 20/20] sdcard: add an enum for the SD
 PHY Spec version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On 02/22/2018 11:26 AM, Peter Maydell wrote:
> On 15 February 2018 at 22:13, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> So far this device intends to model the Spec v1.10
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>  hw/sd/sd.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index b9429b06ca..d4565626ce 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -47,6 +47,11 @@
>>
>>  //#define DEBUG_SD 1
>>
>> +typedef enum {
>> +    SD_PHY_SPEC_VER_1_10 = 110,
>> +    SD_PHY_SPEC_VER_2_00 = 200, /* not yet supported */
>> +} sd_phy_spec_ver_t;
>> +
>>  typedef enum {
>>      sd_r0 = 0,    /* no response */
>>      sd_r1,        /* normal response command */
>> @@ -122,6 +127,7 @@ struct SDState {
>>      qemu_irq inserted_cb;
>>      QEMUTimer *ocr_power_timer;
>>      const char *proto_name;
>> +    int spec_version;
>>      bool enable;
>>      uint8_t dat_lines;
>>      bool cmd_line;
>> @@ -2169,6 +2175,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
>>      int ret;
>>
>>      sd->proto_name = sd->spi ? "SPI" : "SD";
>> +    sd->spec_version = SD_PHY_SPEC_VER_1_10;
>>
>>      if (sd->blk && blk_is_read_only(sd->blk)) {
>>          error_setg(errp, "Cannot use read-only drive as SD card");
> 
> I think I'd prefer to see this patch with the ones that actually use
> the field -- as it stands it's never used.

Indeed I see, thanks.
