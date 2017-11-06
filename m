Received: from eggs.gnu.org ([2001:4830:134:3::10]:60105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eBeLW-0006kW-Tw
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eBeLW-0007Z1-1t
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:09:34 -0500
References: <1508772937-21054-1-git-send-email-eric.auger@redhat.com>
	<1508772937-21054-2-git-send-email-eric.auger@redhat.com>
	<CAFEAcA81ogq6py71ejK7JD52A8LrQz1v92M1HZPCfPVBZy1vww@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0686ba45-7a77-f5b0-537d-07e2c3438e5e@redhat.com>
Date: Mon, 6 Nov 2017 11:09:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81ogq6py71ejK7JD52A8LrQz1v92M1HZPCfPVBZy1vww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 1/4] hw/intc/arm_gicv3_its: Don't abort on
 table save failure
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

On 02/11/2017 13:53, Peter Maydell wrote:
> On 23 October 2017 at 16:35, Eric Auger <eric.auger@redhat.com> wrote:
>> The ITS is not fully properly reset at the moment. Caches are
>> not emptied.
>>
>> After a reset, in case we attempt to save the state before
>> the bound devices have registered their MSIs and after the
>> 1st level table has been allocated by the ITS driver
>> (device BASER is valid), the first level entries are still
>> invalid. If the device cache is not empty (devices registered
>> before the reset), vgic_its_save_device_tables fails with -EINVAL.
>> This causes a QEMU abort().
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reported-by: wanghaibin <wanghaibin.wang@huawei.com>
>>
>> ---
>>
>> this patch would deserve being cc'ed stable (2.10)
>> This goes along with patches 1-5 of
>> [PATCH v5 00/10] vITS Migration fixes and reset, candidate
>> for being cc'ed stable
>> ---
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> We could/should put this patch into qemu now, right (it's
> the rest of the series that's RFC) ?

Yes that's correct.

Thanks

Eric
> 
> thanks
> -- PMM
> 
