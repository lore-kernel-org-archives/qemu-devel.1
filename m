Received: from eggs.gnu.org ([2001:4830:134:3::10]:38048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ey2SR-0007pi-30
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ey2SN-0000ht-2O
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:36:43 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:64404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ey2SM-0000gv-OP
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:36:38 -0400
Date: Mon, 19 Mar 2018 22:36:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180319191534.GM12302@localhost.localdomain>
Message-ID: <alpine.BSF.2.21.1803192232570.44730@zero.eik.bme.hu>
References: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
	<20180221052735.GA2919@localhost.localdomain>
	<CAFEAcA8AA643WJGwF3fHEOtjw_Sx_1TeOf5UZFg9x_L2Ot6XYw@mail.gmail.com>
	<alpine.BSF.2.21.1803191426370.9395@zero.eik.bme.hu>
	<20180319191534.GM12302@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] Moving seabios-hppa git submodule to use a
 qemu.org mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 19 Mar 2018, Jeff Cody wrote:
> On Mon, Mar 19, 2018 at 02:32:22PM +0100, BALATON Zoltan wrote:
>> On Mon, 19 Mar 2018, Peter Maydell wrote:
>>> On 21 February 2018 at 05:27, Jeff Cody <jcody@redhat.com> wrote:
>>>> On Tue, Feb 20, 2018 at 06:43:22PM +0000, Peter Maydell wrote:
>>>>> I just noticed that we seem to have acquired another git
>>>>> submodule that isn't pointing to a qemu.org git url:
>>>>>
>>>>> [submodule "roms/seabios-hppa"]
>>>>>        path = roms/seabios-hppa
>>>>>        url = git://github.com/hdeller/seabios-hppa.git
>>>>>
>>>>> Jeff, could we set up so we can mirror this repo on qemu.org?
>>>>> Then we can send a patch to update the .gitmodules to point to it.
>>>>>
>>>>
>>>> Yes, of course... Although Paolo has suggested making it a branch of the
>>>> existing SeaBIOS repo instead.  But I can go ahead and get the clone setup,
>>>> in case we go that route.
>>>
>>> Hi; can we get the mirror set up for seabios-hppa, and also for
>>> the other new repo:
>>> git://github.com/zbalaton/u-boot-sam460ex
>>
>> I'd suggest to move the u-boot-sam460ex repo to qemu repo completely instead
>> of mirrorring it. I don't intend to change it in the future (apart from
>> maybe occasional bugfixes if needed which chould be submitted as patches) so
>> no need to keep an external repo and mirror it when it could be held in qemu
>> as primary.
>>
>> Please let me know how you decide, I can then remove the the above repo and
>> refer to the qemu one in the future if you move it there or keep the current
>> one up if you choose to mirror it.
>>
>
> I went ahead and created it as a mirror.  If there is consensus on moving it
> to qemu.org as a primary host, I can convert it (and I'll need to set you up
> an account on qemu.org as well at that point, for those occasional
> bugfixes).

No need for an account as I can submit changes if needed as patches (as I 
do with other changes to qemu) and then whoever has access to that repo 
can commit it. As I've said there's no further development on this u-boot 
branch so only changes expected are bugfixes if it's ever found to be 
needed. Otherwise this repo should be really static.

> For now, keep your repo up as a primary source until we know if we are
> moving it to qemu.org rather than just mirroring it.

I'm OK with that as well, I'll keep the repo on github until you tell me 
it's not needed any more. Thank you.

Regards,
BALATON Zoltan
