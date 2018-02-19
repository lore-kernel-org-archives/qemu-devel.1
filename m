Received: from eggs.gnu.org ([2001:4830:134:3::10]:59218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1enm97-0004uM-3F
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1enm96-0002W9-3v
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:10:21 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:51918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1enm95-0002UW-UR
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:10:20 -0500
Received: by mail-it0-x241.google.com with SMTP id o9so5249244itc.1
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 06:10:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3f009bb2-fb39-36ff-b3ed-a9b8c63db081@amsat.org>
References: <20180217140051.22731-1-linus.walleij@linaro.org>
	<20180217140051.22731-3-linus.walleij@linaro.org>
	<3f009bb2-fb39-36ff-b3ed-a9b8c63db081@amsat.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 19 Feb 2018 15:10:18 +0100
Message-ID: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On Sat, Feb 17, 2018 at 7:28 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 02/17/2018 11:00 AM, Linus Walleij wrote:

>> The assignment of the SiI9022 at address 0x39 and the EDID
>> DDC I2C at address 0x50 is not strictly correct: the DDC I2C
>> is there all the time but in the actual component it only
>> appears once activated inside the SiI9022, so ideally it should
>> be added and removed to the bus by the SiI9022. However for this
>> purpose it works fine to just have it around.
>
> This seems easier to just do it now rather than postpone :)
>
> In your patch #2:
>
> static void sii9022_realize(DeviceState *dev, Error **errp)
> {
>     I2CBus *bus;
>
>     bus =3D I2C_BUS(qdev_get_parent_bus(dev));
>     i2c_create_slave(bus, TYPE_I2CDDC, 0x50);
> }

I tried an approach like this but the I2C_BUS() macro was not
publicly visible in any header file and trying to pry it out just
brought along a lot of refactoring in the i2c core.c file that
scared me away...

Has someone else fixed it already?

Yours,
Linus Walleij
