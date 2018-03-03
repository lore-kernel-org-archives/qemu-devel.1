Received: from eggs.gnu.org ([2001:4830:134:3::10]:34810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5uU-0008Cb-4j
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 07:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5uP-000109-8V
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 07:05:06 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5uP-0000zc-2R
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 07:05:01 -0500
Received: by mail-wr0-x242.google.com with SMTP id v18so11991631wrv.0
	for <qemu-devel@nongnu.org>; Sat, 03 Mar 2018 04:05:00 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215221325.7611-1-f4bug@amsat.org>
	<20180215221325.7611-11-f4bug@amsat.org>
	<CAKmqyKMPvYDu_m8O3LuAzMBm4y3YdXCTGHTUipo1KrLi8qt_ig@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2543f0d5-90be-6f13-e279-869b8ea3f8ca@amsat.org>
Date: Sat, 3 Mar 2018 09:04:51 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMPvYDu_m8O3LuAzMBm4y3YdXCTGHTUipo1KrLi8qt_ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 10/20] sdcard: handle the Security
 Specification commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 02/15/2018 07:54 PM, Alistair Francis wrote:
> On Thu, Feb 15, 2018 at 2:13 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> returning sd_illegal, since they are not implemented.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/sd/sd.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 30acd04ad7..0457f5214b 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -1551,6 +1551,17 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>>          }
>>          break;
>>
>> +    case 18:    /* Reserved for SD security applications */
>> +    case 25:
>> +    case 26:
>> +    case 38:
>> +    case 43 ... 49:
>> +        /* Refer to the "SD Specifications Part3 Security Specification" for
>> +         * information about the SD Security Features */
> 
> The */ should be on a new line.

Thanks Peter for fixing this :)

> 
> Otherwise:
> 
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks!

> 
> Alistair
> 
>> +        qemu_log_mask(LOG_UNIMP, "SD: CMD%i Security not implemented\n",
>> +                      req.cmd);
>> +        return sd_illegal;
>> +
>>      default:
>>          /* Fall back to standard commands.  */
>>          return sd_normal_command(sd, req);
>> --
>> 2.16.1
>>
>>
