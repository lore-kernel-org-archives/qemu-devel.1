Received: from eggs.gnu.org ([2001:4830:134:3::10]:45046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dJMDx-0003MK-4o
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dJMDw-0005JT-HI
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:53:21 -0400
References: <1492173995-14140-1-git-send-email-eric.auger@redhat.com>
	<1492173995-14140-3-git-send-email-eric.auger@redhat.com>
	<5939F9B2.5050708@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ef34d3dc-91c2-b953-2257-f6415e1992bb@redhat.com>
Date: Fri, 9 Jun 2017 17:53:12 +0200
MIME-Version: 1.0
In-Reply-To: <5939F9B2.5050708@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v5 2/4] hw/intc/arm_gicv3_its: Implement
 state save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: drjones@redhat.com, vijay.kilari@gmail.com, quintela@redhat.com, dgilbert@redhat.com, Vijaya.Kumar@cavium.com, christoffer.dall@linaro.org

Hi Shannon,

On 09/06/2017 03:28, Shannon Zhao wrote:
> 
> 
> On 2017/4/14 20:46, Eric Auger wrote:
> [...]
>> @@ -43,6 +50,7 @@ struct GICv3ITSState {
>>  
>>      /* Registers */
>>      uint32_t ctlr;
>> +    uint32_t iidr;
> I think this should reset in gicv3_its_common_reset

Done.

Thanks!

Eric
> 
> Thanks,
> 
