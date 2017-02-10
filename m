Received: from eggs.gnu.org ([2001:4830:134:3::10]:50476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cc7Aj-00036D-N0
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cc7Ai-0001fk-Pt
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:07:17 -0500
References: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8FWjeV+Gyd5J5zwiM4yajwPjt7obTNiLJa7S7DXDemLg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <fbab658f-fc8b-61b8-5d81-90e93d6c71a3@redhat.com>
Date: Fri, 10 Feb 2017 10:07:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8FWjeV+Gyd5J5zwiM4yajwPjt7obTNiLJa7S7DXDemLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/4] vITS save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>, Andrew Jones <drjones@redhat.com>, Vijay Kilari <vijay.kilari@gmail.com>, "Kumar, Vijaya" <Vijaya.Kumar@cavium.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi Peter, all,

On 07/02/2017 15:36, Peter Maydell wrote:
> On 26 January 2017 at 09:19, Eric Auger <eric.auger@redhat.com> wrote:
>> This series allows ITS save/restore and migration use cases.
>> It relies on not upstreamed kernel series ([1] & [2]) and
>> QEMU not upstreamed series [3].
>>
>> ITS tables are flushed into guest RAM on VM stop while registers
>> are save on pre_save() callback. Tables and registers are restored
>> on ITS post_load().
>>
>> The code is based on Vijaya's "GICv3 live migration support"
>> series [3], based on v2.8.0-rc4.
>>
>> The series also uses one patch from Peter Xu that aims at allowing
>> the explicit ordering of save/restore handlers [4], now upstreamed.
>>
>> That work was tested on Cavium ThunderX using virsh save/restore and
>> virt-manager live migration.
>>
>> Best Regards
>>
>> Eric
> 
> Looks overall OK to me (you've had some review comments from
> others but I don't have anything else particularly to add).

Thank you for your reviews. Yes I have followed each comment and I will
respin shortly. I have been mostly busy with the kernel series respin
taking into account Marc's comments and supporting 2 stage device tables.

Thanks

Eric
> 
> thanks
> -- PMM
> 
