Received: from eggs.gnu.org ([2001:4830:134:3::10]:40036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eHvYZ-0004NN-W0
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eHvYY-0004Lj-TH
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:45:00 -0500
References: <1511448975-28326-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8T4cShPYONdo8hiaZKvd+zq9Uo1o5awU3rA03uu8Vsiw@mail.gmail.com>
	<1bede1e5-cc11-dca6-9f0b-ef16b9031d7a@redhat.com>
	<CAFEAcA_ZUGR+t2T3cvVo2OkyOccVjtRW+YTN-5KXaw+rFRiRqg@mail.gmail.com>
	<20171123181402.627fd5df.cohuck@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f3a550ab-5eff-1c9c-15e0-32ac70a4c2a6@redhat.com>
Date: Thu, 23 Nov 2017 18:44:44 +0100
MIME-Version: 1.0
In-Reply-To: <20171123181402.627fd5df.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
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
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Vijay Kilari <vijay.kilari@gmail.com>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, wanghaibin.wang@huawei.com, Christian Borntraeger <borntraeger@de.ibm.com>, wu.wubin@huawei.com, eric.auger.pro@gmail.com

Hi Cornelia, Peter,

On 23/11/17 18:14, Cornelia Huck wrote:
> On Thu, 23 Nov 2017 17:01:32 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> On 23 November 2017 at 16:05, Auger Eric <eric.auger@redhat.com> wrote:
>>> When using update-linux-headers.sh I get suspicious errors at the end:
>>> grep: /tmp/tmp.A5NjLtHOij/include/asm/kvm_virtio.h: No such file or
>>> directory
>>> sed: can't read /tmp/tmp.A5NjLtHOij/include/asm/kvm_virtio.h: No such
>>> file or directory
>>>
>>> and include/standard-headers/asm-s390/virtio-ccw.h deleted
>>>
>>> I would prefer having s390 people checking and testing that.  
>>
>> I think the kvm_virtio.h problem should be fixed by
>> http://patchwork.ozlabs.org/patch/838230/
>> which removes it from the set of headers the script imports.
>>
>> Cornelia/Christian -- any idea about the virtio-ccw.h issue ?
>>
>> thanks
>> -- PMM
> 
> I had that commit queued for post-2.11, but I can also send it for 2.11.
> 
> The virtio-ccw.h one looks weird... if I run the script on my s390-next
> branch against recent-ish Linux master, I just get the SPDX notice
> update for virtio-ccw.h.
> 

http://patchwork.ozlabs.org/patch/838230/ effectively fixes all issues:
- no errors anymore and
- no deletion of include/standard-headers/asm-s390/virtio-ccw.h anymore,
which is consistent with include/standard-headers/asm-s390/virtio-ccw.h.


Thanks

Eric
