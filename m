Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1Vrq-0004Fd-N0
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1Vrk-0004Z2-NW
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:05:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e1Vrk-0004XS-Ec
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:04:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99B4aUg122027
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 07:04:52 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dg3rcuep6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 07:04:51 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 12:04:47 +0100
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
	<2d8ae3d3-438b-da84-4959-cf63f4f4ce99@linux.vnet.ibm.com>
	<59B9D439.10807@huawei.com>
	<7e490af1-9caa-c96d-5f62-308f1b5d8805@linux.vnet.ibm.com>
	<59BF1E9B.2030408@huawei.com>
	<64d90f78-a2ae-be37-672b-e47aa3d4ecb2@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA3FBCC5@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 13:04:37 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA3FBCC5@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <7eaac82c-0d8b-47f1-94dd-772b3abf31f9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [RFC 0/8]
 virtio-crypto: add multiplexing mode support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng <longpeng2@huawei.com>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "mst@redhat.com" <mst@redhat.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, Luonengjun <luonengjun@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "john.griffin@intel.com" <john.griffin@intel.com>, "agraf@suse.de" <agraf@suse.de>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>



On 10/09/2017 11:22 AM, Gonglei (Arei) wrote:
> The next patch refactors make sense to me, 
> but why do we need to decouple the virtio-crypto.h?
> 
> 

I wanted to be able to freely change the host side and test with an unchanged
guest side, that's why I've done that. It's just for testing. I had to do that
because we don't have a mux capable linux driver. Neither of these patches is
intended for inclusion. I'm just trying to make a point with them: we can
make this substantially simpler (compared to this RFC).

So how do we proceed here? It would be nice to see a cleaned up version of
this series soon. If I recall correctly there were also other things which
can be done in a less convoluted manner.

>> The basic idea behind the whole thing is that tinging about the requests put
>> on the virtqueues in terms of just complicates things unnecessarily.
>>
>> I could guess I will post the interesting part as a reply to this and the less
>> interesting part (decoupling) as an attachment. You are supposed to apply first
>> the attachment then the part after the scissors line.
>>
>> Of course should you could respin the series preferably with the test
>> included I can rebase my stuff.
>>
>> Please let me know about your opinion.
>>
> Thanks for your work, Halil. What's your opinion about virtio crypto spec v20?

I'm on it. I've already started witting on Friday but things turned out a bit more
interesting that expected. So I've postponed to today. Of course the two things are
connected. I will try to give some feedback today.

Regards,
Halil

> 
> Thanks,
> -Gonglei
> 
