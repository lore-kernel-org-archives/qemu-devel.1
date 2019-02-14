Received: from eggs.gnu.org ([209.51.188.92]:41004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1guLSU-0004OL-Ql
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1guLSU-0000pI-3k
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:10:02 -0500
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<CAFEAcA9QHxm7ACYBnKibfderjfgg+9p+xHZZB4QmMHk26BqTuw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8b51d0ed-ea6b-1f75-e134-5e51e111bb98@redhat.com>
Date: Thu, 14 Feb 2019 19:00:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9QHxm7ACYBnKibfderjfgg+9p+xHZZB4QmMHk26BqTuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/18] ARM virt: Initial RAM expansion
 and PCDIMM/NVDIMM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

Hi Peter,

On 2/14/19 6:35 PM, Peter Maydell wrote:
> On Tue, 5 Feb 2019 at 17:33, Eric Auger <eric.auger@redhat.com> wrote:
>> This series aims to bump the 255GB RAM limit in machvirt and to
>> support device memory in general, and especially PCDIMM/NVDIMM.
> 
>> Functionally, the series is split into 3 parts:
>> 1) bump of the initial RAM limit [1 - 10] and change in
>>    the memory map
>> 2) Support of PC-DIMM [11 - 14]
>> 3) Support of NV-DIMM [15 - 18]
>>
>> 1) can be upstreamed before 2 and 2 can be upstreamed before 3.
> 
> Hi Eric; sorry I haven't reviewed this series earlier. I think
> that 1-10 are pretty near to ready to go in; maybe the easiest
> path is to do a respin of just those with the review issues fixed?

No problem. Thank you for the review.

Yes I will quickly respin the patches you reviewed.

> 
> I'm a long way from being expert in the PC-DIMM/NV-DIMM stuff, so
> I'm going to be reliant on other people to review those parts.
> 
> I don't know if your series needs anything from linux-headers
> which isn't already in QEMU master after the update to match
> 5.0rc1 -- if not you could drop the header-sync patch.
5.0-rc1 should be OK so I think I can drop the header sync.

Thanks

Eric
> 
> thanks
> -- PMM
> 
