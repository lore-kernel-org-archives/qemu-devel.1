Received: from eggs.gnu.org ([2001:4830:134:3::10]:48294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ennAz-0001Qt-Ub
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ennAt-0003Gf-J6
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:16:21 -0500
Reply-To: minyard@acm.org
References: <20180217140051.22731-1-linus.walleij@linaro.org>
	<20180217140051.22731-3-linus.walleij@linaro.org>
	<3f009bb2-fb39-36ff-b3ed-a9b8c63db081@amsat.org>
	<CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <f4bcb303-ee95-9cc5-cc0a-b3e26592386e@gmail.com>
Date: Mon, 19 Feb 2018 09:16:11 -0600
MIME-Version: 1.0
In-Reply-To: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 3/3] arm/vexpress: Add proper display
 connector emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 02/19/2018 08:10 AM, Linus Walleij wrote:
> On Sat, Feb 17, 2018 at 7:28 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 02/17/2018 11:00 AM, Linus Walleij wrote:
>>> The assignment of the SiI9022 at address 0x39 and the EDID
>>> DDC I2C at address 0x50 is not strictly correct: the DDC I2C
>>> is there all the time but in the actual component it only
>>> appears once activated inside the SiI9022, so ideally it should
>>> be added and removed to the bus by the SiI9022. However for this
>>> purpose it works fine to just have it around.
>> This seems easier to just do it now rather than postpone :)
>>
>> In your patch #2:
>>
>> static void sii9022_realize(DeviceState *dev, Error **errp)
>> {
>>      I2CBus *bus;
>>
>>      bus = I2C_BUS(qdev_get_parent_bus(dev));
>>      i2c_create_slave(bus, TYPE_I2CDDC, 0x50);
>> }
> I tried an approach like this but the I2C_BUS() macro was not
> publicly visible in any header file and trying to pry it out just
> brought along a lot of refactoring in the i2c core.c file that
> scared me away...
>
> Has someone else fixed it already?

I have a patch that does this.  Well, it's a small cleanup patch and another
patch, but it's really no that bad.  I'll send it.

-corey

>
> Yours,
> Linus Walleij
>
