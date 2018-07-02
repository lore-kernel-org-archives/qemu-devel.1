Received: from eggs.gnu.org ([2001:4830:134:3::10]:35128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fZw9i-00033q-BR
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fZw9d-0002sZ-B6
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:34:02 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:18331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fZw9c-0002kO-WE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:33:57 -0400
Date: Mon, 2 Jul 2018 12:33:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA_ymngY5i5BWQ6-xAveCWjs0QKrORSAy9nH1A8m9672Fg@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1807021219520.6605@zero.eik.bme.hu>
References: <cover.1530047900.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1806302231400.45338@zero.eik.bme.hu>
	<CAFEAcA_ymngY5i5BWQ6-xAveCWjs0QKrORSAy9nH1A8m9672Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On Mon, 2 Jul 2018, Peter Maydell wrote:
> On 30 June 2018 at 21:34, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Tue, 26 Jun 2018, BALATON Zoltan wrote:
>>>
>>> Version 2 of the sm501 changes with fixes that are needed to get
>>> AmigaOS 4.1FE to boot and able to produce graphics.
>>>
>>> The strange blue-white colors that first appear are actually correct
>>> and because of AmigaOS selecting a low resolution PAL mode by default
>>> instead of a board specific mode. To work around this one can select
>>> the last option to boot the live CD and then select a better board
>>> specific mode from ScreenMode Prefs. It takes a while for the
>>> ScreenMode window to appear and graphics operations are slow which
>>> could use some improvement but at least it seems to work correctly now
>>> apart from some unimplemented drawing modes for compositing.
>>>
>>> If this could be merged before the freeze with the sam460ex patches
>>> and Sebastian's ehci patch then QEMU 3.0 could be the first version
>>> that can boot AmigaOS.
>>
>>
>> Ping? Sorry to push it but it would be great if this could get in for 3.0.
>> Peter, this may need your attention like last time as it's not clear whose
>> tree it should go through and David did not seem to be confident taking it
>> via the ppc tree.
>
> I can have a look, but really I think these should go via the
> ppc tree -- the device is used in a ppc machine and an sh4 one,
> and the ppc tree is much more active than sh4.

Thank you. Please agree on what should be the needed action here. It would 
be a pity if this missed 3.0 because of this. Could it be merged before 
the freeze if no obvious problems are found with that it can be removed 
later if it causes any trouble (I think that's unlikely as it's only 
touches rarely used parts).

Regards,
BALATON Zoltan
