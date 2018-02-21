Received: from eggs.gnu.org ([2001:4830:134:3::10]:39101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoXr1-0007hD-U9
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoXqx-0004Ys-LN
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:06:51 -0500
Date: Wed, 21 Feb 2018 18:06:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA-p_og1Dc3DOTbAYofqAUEn0rnuuizoU8xtWrtOtzpp-w@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1802211754370.60913@zero.eik.bme.hu>
References: <cover.1519150239.git.balaton@eik.bme.hu>
	<CAFEAcA8UnMNoGbpx+Mhh8AT9MfOMuUZvMd139tGQFokTAWqWpA@mail.gmail.com>
	<20180220204450.GA27101@flamenco>
	<CAFEAcA-p_og1Dc3DOTbAYofqAUEn0rnuuizoU8xtWrtOtzpp-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 0/2] Firmware blob and git submodule for
 Sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On Wed, 21 Feb 2018, Peter Maydell wrote:
> On 20 February 2018 at 20:44, Emilio G. Cota <cota@braap.org> wrote:
>> On Tue, Feb 20, 2018 at 18:31:17 +0000, Peter Maydell wrote:
>>> On 20 February 2018 at 18:10, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>> I've created a git repo for the Sam460ex u-boot sources and this adds
>>>> that as a submodule and a separate patch to add the binary built from
>>>> these sources. Feel free to keep this as two patches, squash them into
>>>> one patch or take the git repo and commit the content under the QEMU
>>>> repo and use that as a submodule as you see fit (or let me know if any
>>>> changes are needed for these patches).
>>>>
>>>> BALATON Zoltan (2):
>>>>   roms: Added git submodule for u-boot-sam460 (firmware for sam460ex)
>>>>   pc-bios: Added u-boot-sam460 firmware binary
>>>
>>> We already have a submodule for u-boot. Is it not possible to
>>> build this bios blob from those upstream u-boot sources?
>>
>> This is discussed in the following thread:
>>   Re: [Qemu-ppc] [PATCH v3 2/2] ppc: Add aCube Sam460ex board
>>   http://lists.gnu.org/archive/html/qemu-ppc/2018-02/msg00268.html
>
> If upstream u-boot have abandoned the board support I'm not very
> enthusiastic about our taking it on :-(

It's not that upstream u-boot has abandoned board support (it only removed 
support for the PPC440 CPU it once had). The board itself never had 
support in upstream u-boot, it only exists in vendor's fork which is the 
reason we need a separate source and cannot use upstream u-boot source we 
already have.

In my opinion we don't aim to take on support for this board in u-boot, we 
only need to include the firmware binary for the emulation to be useful 
which then requires us to also include the source for the GPL it's 
licensed under. I've also found a few bugs in the firmware which I've 
fixed but apart from such occasional bug fixes when needed I don't expect 
to take over support for the board from the hardware vendor so this source 
is only so we can include the firmware binary which is needed for the 
board emulation. Does this answer your concerns?

Regards,
BALATON Zoltan
