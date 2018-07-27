Received: from eggs.gnu.org ([2001:4830:134:3::10]:41834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fj4QV-0005TE-OH
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fj4QU-0007MB-Sh
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:13:07 -0400
References: <cover.1532701430.git.damien.hedde@greensocs.com>
	<CAFEAcA-X=eziUHurc0SEcGEeM25t4YgkTczsVeF8myWHjfp3MQ@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <2d22fcb2-b825-6195-a935-bf2adb3e0a60@adacore.com>
Date: Fri, 27 Jul 2018 17:12:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-X=eziUHurc0SEcGEeM25t4YgkTczsVeF8myWHjfp3MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
To: Peter Maydell <peter.maydell@linaro.org>, Damien Hedde <damien.hedde@greensocs.com>
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>



Le 07/27/2018 =C3=A0 04:59 PM, Peter Maydell a =C3=A9crit=C2=A0:
> On 27 July 2018 at 15:37, Damien Hedde <damien.hedde@greensocs.com> wro=
te:
>> This set of patches add support for power and clock gating in device o=
bjects.
>> It adds two booleans to the state, one for power state and one of cloc=
k state.
>>
>> The state is controlled trough 2 functions, one for power and one for =
clock.
>> Two new methods *power_update* and *clock_update* is added to the devi=
ce class
>> which are called on state change and can be overriden.
>=20
> So, you folks at Greensocs had a series a couple of years ago to try
> to add clocktree support (which included handling things like guests
> configuring clock rates, some clocks being "downstream" of others, and
> so on). It didn't make it into mainline, though it did get a fair amoun=
t
> of design/code review. How does this approach fit into / compare with
> that ?
>=20
> thanks
> -- PMM
>=20

Hi all,

I didn't have time to push a new version of the clock series and
I lost the track a little bit (was 13 months ago). Sorry for
that :(.. Would be still nice to have I think.

Cheers,
Fred
