Received: from eggs.gnu.org ([2001:4830:134:3::10]:36053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQa56-0008Om-LY
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQa51-0005dh-J3
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:10:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1528069840.git.balaton@eik.bme.hu>
	<6f3e8e1070c12d1a8321f4fdb6f65d56adc2767b.1528069840.git.balaton@eik.bme.hu>
	<20180606063606.GJ17757@umbus.fritz.box>
	<alpine.BSF.2.21.1806061558010.42561@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fe2799d9-0a74-774a-1b97-59365afa1c8b@amsat.org>
Date: Wed, 6 Jun 2018 12:10:26 -0300
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806061558010.42561@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] ppc4xx_i2c: Rewrite PPC4xx I2C
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

Hi Zoltan,

On 06/06/2018 11:03 AM, BALATON Zoltan wrote:
> On Wed, 6 Jun 2018, David Gibson wrote:
>> On Mon, Jun 04, 2018 at 01:50:40AM +0200, BALATON Zoltan wrote:
>>> I2C emulation currently is just enough for U-Boot to access SPD
>>> EEPROMs but features that guests use to access I2C devices are not
>>> correctly emulated. Rewrite to implement missing features to make it
>>> work with all clients.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> Maybe this could be split up into more patches but because the
>>> previous implementation was wrong only allowing U-Boot to pass and no
>>> clients could access I2C devices before this rewrite it probably does
>>> not worth to try to make it a lot of small changes instead of dropping
>>> the previous hack and rewrite following features of real hardware more
>>> closely. (It turns out that each client driver accesses I2C in a
>>> different way so we need to implement almost all features of the
>>> hardware to please everyone.)
>>
>> The trouble is that because I don't really have a good test setup for
>> this, I'm pretty reluctant to apply such a total rewrite without acks
>> from more people who've tested it.  That or reviewing the changes
>> myself, which I can't really do when it's in one big lump like this.
> 
> OK, I've sent a v2 where this patch is split up to smaller pieces that
> are hopefully easier to review. However this i2c emulation was only a
> stub originally which was hacked together to make U-Boot happy when
> added the sam460ex machine and this is the first version that attempts
> to really model the device so that guests can also use it. Therefore I
> think there's not a high chance of breaking anything important. I've
> tested this with AROS, Linux, AmigaOS and MorphOS and they seem to be
> able to read the RTC so it should work better than the previous version.

Are those images publicly accessible? (thinking about adding acceptance
qtests).

> (Only AROS boots fully on sam460ex of these yet, others still need some
> more work.)
