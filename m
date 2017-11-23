Received: from eggs.gnu.org ([2001:4830:134:3::10]:40389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eHu0Z-0004N6-Hg
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eHu0T-0002UZ-Mx
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:05:47 -0500
References: <1511448975-28326-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8T4cShPYONdo8hiaZKvd+zq9Uo1o5awU3rA03uu8Vsiw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1bede1e5-cc11-dca6-9f0b-ef16b9031d7a@redhat.com>
Date: Thu, 23 Nov 2017 17:05:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8T4cShPYONdo8hiaZKvd+zq9Uo1o5awU3rA03uu8Vsiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 0/4] vITS Reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Vijay Kilari <vijay.kilari@gmail.com>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, wu.wubin@huawei.com, wanghaibin.wang@huawei.com, Christoffer Dall <christoffer.dall@linaro.org>, eric.auger.pro@gmail.com

Hi Peter,

On 23/11/17 16:19, Peter Maydell wrote:
> On 23 November 2017 at 14:56, Eric Auger <eric.auger@redhat.com> wrote:
>> At the moment the ITS is not properly reset. On System reset or
>> reboot, previous ITS register values and caches are left
>> unchanged. Some of the registers might point to some guest RAM
>> tables which are not valid anymore. This leads to state
>> inconsistencies that are detected by the kernel save/restore
>> code. And eventually this may cause qemu abort.
>>
>> This series adds vITS reset modality:
>> - the 2 first patches bring a minimalist reset through individual
>>   register writes. However, with kernel versions < 4.15, this reset
>>   is not complete (vITS caches are not voided).
>> - With kernel versions >= 4.15 we can rely on a new ITS KVM device
>>   reset IOTCL. The last 2 patches introduce the full reset.
>>
>> Patches 1-2 have all kernel dependencies resolved.
>> Patches 3-4' dependencies were pulled for v4.15-rc0 but as the tag is
>> not set, the kernel header update still is partial.
> 
> We don't need the change to be tagged for us to sync with the
> kernel headers: if it's in mainline that's good enough.

OK. do you allow me to keep a partial update for:
 linux-headers/asm-arm/kvm.h
 linux-headers/asm-arm64/kvm.h?

When using update-linux-headers.sh I get suspicious errors at the end:
grep: /tmp/tmp.A5NjLtHOij/include/asm/kvm_virtio.h: No such file or
directory
sed: can't read /tmp/tmp.A5NjLtHOij/include/asm/kvm_virtio.h: No such
file or directory

and include/standard-headers/asm-s390/virtio-ccw.h deleted

I would prefer having s390 people checking and testing that.

Thanks

Eric

> 
> thanks
> -- PMM
> 
