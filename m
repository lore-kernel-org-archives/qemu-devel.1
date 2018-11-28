Received: from eggs.gnu.org ([2001:4830:134:3::10]:38143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gS3es-0003s0-51
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gS3eq-0005Q7-Un
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:29:53 -0500
References: <20181126154616.18173-1-eric.auger@redhat.com>
	<CAFEAcA9B_jLiHLzJZrKuhT3SfXB+pzj03D=NiVNWqRc+zc=qTA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ac1e7ca7-e050-1f56-03fb-cafaf2fd6ae5@redhat.com>
Date: Wed, 28 Nov 2018 18:29:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9B_jLiHLzJZrKuhT3SfXB+pzj03D=NiVNWqRc+zc=qTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/arm/virt-acpi-build: Fix SMMUv3
 ACPI integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Eric Auger <eric.auger.pro@gmail.com>

Hi Peter,

On 11/27/18 2:32 PM, Peter Maydell wrote:
> On Mon, 26 Nov 2018 at 15:46, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> The AcpiIortSmmu3 misses 2 32b fields corresponding to the
>> proximity domain and the device id mapping index.
>>
>> Also let's report IO-coherent access is supported for
>> translation table walks, descriptor fetches and queues by
>> setting the COHACC override flag. Without that, we observe
>> wrong command opcodes. The DT description also advertises
>> the dma coherency.
>>
>> Fixes a703b4f6c1ee ("hw/arm/virt-acpi-build: Add smmuv3 node in IORT table")
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> 
> Hi; it looks (from looking at the code) like this isn't a
> regression from 3.0 -- is that right?
Correct, the lack of COHACC override flag has been there from the very
beginning.
> 
> I think this fix has missed rc3 (discussion seems to be ongoing
> and it needs more time on-list for review), which means it's
> likely to miss the 3.1 release. So at the moment I'm expecting
> it to go into 4.0. (Maybe if we need an rc4 for some other reason
> we might be able to put it in.)
OK

Thanks

Eric
> 
> thanks
> -- PMM
> 
