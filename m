Received: from eggs.gnu.org ([2001:4830:134:3::10]:34876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ebXgn-0006lY-Ai
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ebXgi-00049k-Gz
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:18:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ebXgi-00049A-Ab
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:18:28 -0500
References: <CAFEAcA8F4iO91c8OGtDbHQ_hqzY+9ka41PW4q+ES9sYGRUha0g@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <176e66bb-7990-20da-a82f-fbabd9b4ed88@redhat.com>
Date: Tue, 16 Jan 2018 21:18:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8F4iO91c8OGtDbHQ_hqzY+9ka41PW4q+ES9sYGRUha0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU virt board: extending various limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Wei Huang <wei@redhat.com>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>

(adding Ard, Igor, Wei, Leif)

On 01/16/18 16:07, Peter Maydell wrote:
> We've had discussions before about the various limits in the virt
> board imposed by its current address space layout:
>  * number of CPUs limited to 123 (not enough space for more redistributors)
>  * number of PCIe devices limited by size of ECAM space
>  * max memory size limits
>  * (anything else?)
> 
> If we want to try to fix these this release cycle now would be a good
> point to figure out our approach so that we have plenty of time to do
> it in.
> 
> (Relatedly, I notice patches on list for kvm that allow userspace to
> set the guest physical address size, which may affect how we want
> to do this.)
> 
> I'm not going to have time to look at this but am happy to provide
> my opinions on whatever proposals other people would like to suggest.
> 
> Probably the first thing to do is figure out whether we can
> raise these limits without having to have a flag day (ie just
> with changing the device tree we provide the guest), or if we
> really have a hard compat break here. We should also try to
> fix all these things at once rather than potentially breaking
> guests several times...

I've quite lost the context on this since we last talked about it. :) My
request would be that Drew and Igor please (re)state their preferences,
and Ard and myself should put "firmware price tags" on those ideas.

As far as I remember, the sticking point from last time was whether
guest UEFI remains permitted to rely on the RAM base being fixed at 1GB
(i.e. if UEFI is at liberty to ignore x0 on entry). This decision
provides a framework for all further area movements, and represents a
large difference in firmware difficulty.

(Personally I'd be ready to *accept* a consensus that UEFI should cope
with a dynamic x0 on entry -- I'm neither proposing nor arguing against
the notion. The large additional complexity in the firmware should be
clear up-front however -- it'll take more time, more bugs, more human
resources. My last writeup is at
<http://mid.mail-archive.com/4cce2b8b-a411-bd5d-a06f-b0b80a5fb2f1@redhat.com>,
although I think Ard has modified some of the code since, so parts of
that text are no longer up to date.)

Thanks,
Laszlo
