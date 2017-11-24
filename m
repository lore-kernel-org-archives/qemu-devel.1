Received: from eggs.gnu.org ([2001:4830:134:3::10]:36142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eIFDn-0007wB-8w
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eIFDj-0008Oy-CR
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:44:51 -0500
References: <1511533107-5315-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_K4f=mmuoEbyuFCHP2dor5p2UPyedteELQoxPYFzAcEg@mail.gmail.com>
	<dd80f8f3-26da-5893-fa4b-cfa31790394d@redhat.com>
	<CAFEAcA8mqRsOYPVOu=tPqDuXyHauKpoF3AQ-bQgiqv5514o+Xw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <15186366-0220-96ae-91ff-c10515fbe778@redhat.com>
Date: Fri, 24 Nov 2017 15:44:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8mqRsOYPVOu=tPqDuXyHauKpoF3AQ-bQgiqv5514o+Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/4] ITS Reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Vijay Kilari <vijay.kilari@gmail.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, wu.wubin@huawei.com

Hi Peter,
On 24/11/17 15:35, Peter Maydell wrote:
> On 24 November 2017 at 14:32, Auger Eric <eric.auger@redhat.com> wrote:
>> On 24/11/17 15:20, Peter Maydell wrote:
>>> Thanks. My remaining question is: how important it is to
>>> put some of this into 2.11? We're getting quite close to
>>> the release now so I'm getting gradually more reluctant
>>> to put in changes.
>>
>> I fully understand.
>>
>> Anyway clean and comprehensive reset modality would require v4.15 + full
>> QEMU series (otherwise you get the scary error message even if full
>> reset can be achieved by individual register writes).
>>
>> This means the migration of guests while they are booting will not be
>> functional in 2.11. However it should not abort QEMU as it did before,
>> with a kernel >= v4.14.
> 
> ...so overall, what is your recommendation for what we should
> or should not put into 2.11 ?
I would queue the whole series for 2.12 or whatever.

Thanks

Eric
> 
> thanks
> -- PMM
> 
