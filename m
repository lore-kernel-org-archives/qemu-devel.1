Received: from eggs.gnu.org ([2001:4830:134:3::10]:42397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.burton@greensocs.com>) id 1fk83O-00026J-G3
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.burton@greensocs.com>) id 1fk83N-000872-Eg
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:17:38 -0400
From: Mark Burton <mark.burton@greensocs.com>
Date: Mon, 30 Jul 2018 15:17:16 +0200
Message-ID: <164eb4a8d68.27d4.d127438ad377917fe05d617879a0d354@greensocs.com>
In-Reply-To: <2d22fcb2-b825-6195-a935-bf2adb3e0a60@adacore.com>
References: <cover.1532701430.git.damien.hedde@greensocs.com>
	<CAFEAcA-X=eziUHurc0SEcGEeM25t4YgkTczsVeF8myWHjfp3MQ@mail.gmail.com>
	<2d22fcb2-b825-6195-a935-bf2adb3e0a60@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Clock and power gating support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, Peter Maydell <peter.maydell@linaro.org>, Damien Hedde <damien.hedde@greensocs.com>
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>

Hi Pete, sorry for the tardy reply, Im not in the office.


Your right  we shoujd have co-ordinated better the 2 patches, sorry for t=
hat.

Regarding this new patchset, we think there is a degree of complementary =
to the
clocktree one.
Here we simply add a couple of generic power states to a device. We
introduce
an interface to control power and clock gating on any devices, with sensi=
ble
generic behaviour (reset on power on, disabling memory regions when
asleep or
off). The device can specialize this to adopt specific behaviours.

It allows easy implementation of commonly found "system controller", "pin
controllers", "power management unit", or similar blocks in SoCs.
Specialization of devices can be implemented as-needed when a machine
requires
it.


Cheers
Mark

On 27 July 2018 17:22:30 KONRAD Frederic <frederic.konrad@adacore.com> wr=
ote:

> Le 07/27/2018 =C3=A0 04:59 PM, Peter Maydell a =C3=A9crit :
>> On 27 July 2018 at 15:37, Damien Hedde <damien.hedde@greensocs.com> wr=
ote:
>>> This set of patches add support for power and clock gating in device =
objects.
>>> It adds two booleans to the state, one for power state and one of clo=
ck state.
>>>
>>> The state is controlled trough 2 functions, one for power and one for=
 clock.
>>> Two new methods *power_update* and *clock_update* is added to the dev=
ice class
>>> which are called on state change and can be overriden.
>>
>> So, you folks at Greensocs had a series a couple of years ago to try
>> to add clocktree support (which included handling things like guests
>> configuring clock rates, some clocks being "downstream" of others, and
>> so on). It didn't make it into mainline, though it did get a fair amou=
nt
>> of design/code review. How does this approach fit into / compare with
>> that ?
>>
>> thanks
>> -- PMM
>
> Hi all,
>
> I didn't have time to push a new version of the clock series and
> I lost the track a little bit (was 13 months ago). Sorry for
> that :(.. Would be still nice to have I think.
>
> Cheers,
> Fred
