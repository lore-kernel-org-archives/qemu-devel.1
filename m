Received: from eggs.gnu.org ([2001:4830:134:3::10]:33978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dFxwk-0002fT-39
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dFxwj-0000Bc-5Y
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:21:34 -0400
References: <1494697399-352-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_LNipd3oxtcLdm7g_65E39YHKxkd--1Tf6LhVOytgY=A@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8a967ae6-b047-9d09-acc0-1cd9540312fd@redhat.com>
Date: Wed, 31 May 2017 09:21:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_LNipd3oxtcLdm7g_65E39YHKxkd--1Tf6LhVOytgY=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 0/5] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, prem.mallappa@gmail.com, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>

Hi Peter,

On 30/05/2017 18:09, Peter Maydell wrote:
> On 13 May 2017 at 18:43, Eric Auger <eric.auger@redhat.com> wrote:
>> This series introduces the emulation code for ARM SMMUv3.
>> This is the continuation of Prem's work [1].
>>
>> This v4 is yet another visibility step as many restrictions apply
>> to the model at the moment:
> 
> I had a quick scan through to see if anything leapt out
> as odd, and have sent a few comments, but I'm assuming
> you don't want in-depth review at this time (and hoping
> that somebody else will provide it when you do want it ;-)).

Thank you for this quick scan. Indeed this is what I expect at the
moment since the model clearly misses maturity and features. I will ping
people for proper review when this makes sense.

At the moment people can start testing it for stage 1 only. I was
reported and reproduced boot problems with a guest using virtio-blk-pci.
This is currently under debug and then my next step is to complete the
VFIO integration.

Thanks

Eric

> 
> thanks
> -- PMM
> 
