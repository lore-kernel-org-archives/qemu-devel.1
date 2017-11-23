Received: from eggs.gnu.org ([2001:4830:134:3::10]:59002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHvp2-0000TU-Da
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 13:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHvoy-0003RP-QG
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 13:02:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36794
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eHvoy-0003PG-LP
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 13:01:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vANI0U5W131674
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 13:01:53 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ee1etkvx0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 13:01:53 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 23 Nov 2017 18:01:51 -0000
References: <1511448975-28326-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8T4cShPYONdo8hiaZKvd+zq9Uo1o5awU3rA03uu8Vsiw@mail.gmail.com>
	<1bede1e5-cc11-dca6-9f0b-ef16b9031d7a@redhat.com>
	<CAFEAcA_ZUGR+t2T3cvVo2OkyOccVjtRW+YTN-5KXaw+rFRiRqg@mail.gmail.com>
	<20171123181402.627fd5df.cohuck@redhat.com>
	<f3a550ab-5eff-1c9c-15e0-32ac70a4c2a6@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 23 Nov 2017 19:01:46 +0100
MIME-Version: 1.0
In-Reply-To: <f3a550ab-5eff-1c9c-15e0-32ac70a4c2a6@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <619fb88b-7ab1-a48a-a82c-53c21c691807@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC v3 0/4] vITS Reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Vijay Kilari <vijay.kilari@gmail.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, wu.wubin@huawei.com, wanghaibin.wang@huawei.com, Christoffer Dall <christoffer.dall@linaro.org>, eric.auger.pro@gmail.com



On 11/23/2017 06:44 PM, Auger Eric wrote:
> Hi Cornelia, Peter,
> 
> On 23/11/17 18:14, Cornelia Huck wrote:
>> On Thu, 23 Nov 2017 17:01:32 +0000
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>>> On 23 November 2017 at 16:05, Auger Eric <eric.auger@redhat.com> wrote:
>>>> When using update-linux-headers.sh I get suspicious errors at the end:
>>>> grep: /tmp/tmp.A5NjLtHOij/include/asm/kvm_virtio.h: No such file or
>>>> directory
>>>> sed: can't read /tmp/tmp.A5NjLtHOij/include/asm/kvm_virtio.h: No such
>>>> file or directory
>>>>
>>>> and include/standard-headers/asm-s390/virtio-ccw.h deletedch
>>>>
>>>> I would prefer having s390 people checking and testing that.  
>>>
>>> I think the kvm_virtio.h problem should be fixed by
>>> http://patchwork.ozlabs.org/patch/838230/
>>> which removes it from the set of headers the script imports.
>>>
>>> Cornelia/Christian -- any idea about the virtio-ccw.h issue ?
>>>
>>> thanks
>>> -- PMM
>>
>> I had that commit queued for post-2.11, but I can also send it for 2.11.
>>
>> The virtio-ccw.h one looks weird... if I run the script on my s390-next
>> branch against recent-ish Linux master, I just get the SPDX notice
>> update for virtio-ccw.h.
>>
> 
> http://patchwork.ozlabs.org/patch/838230/ effectively fixes all issues:
> - no errors anymore and
> - no deletion of include/standard-headers/asm-s390/virtio-ccw.h anymore,
> which is consistent with include/standard-headers/asm-s390/virtio-ccw.h.
> 

I assume the vITS code is post 2.11? If not, we can certainly submit 3 or 4 
s390 patches (including 838230) for 2.11.
