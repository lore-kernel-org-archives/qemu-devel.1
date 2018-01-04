Received: from eggs.gnu.org ([2001:4830:134:3::10]:48833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eX1Jp-0007cZ-6E
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eX1Jk-0007ki-8E
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:56:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2062 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1eX1Jj-0007ej-7K
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:56:04 -0500
Message-ID: <5A4DEC04.7040705@huawei.com>
Date: Thu, 4 Jan 2018 16:55:32 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
	<1512545840-10256-2-git-send-email-longpeng2@huawei.com>
	<db20b680-e7c8-6563-ebd7-27ab7e06ad6a@linux.vnet.ibm.com>
	<5A4746F3.6090201@huawei.com>
	<41e46c1a-025f-7d03-50ac-c29e008fb9d8@linux.vnet.ibm.com>
In-Reply-To: <41e46c1a-025f-7d03-50ac-c29e008fb9d8@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [v22 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, mst@redhat.com, xin.zeng@intel.com, jasowang@redhat.com, Cornelia Huck <cohuck@redhat.com>, luonengjun@huawei.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, liang.j.ma@intel.com, stefanha@redhat.com, jianjay.zhou@huawei.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com



On 2018/1/4 4:43, Halil Pasic wrote:

> 
> 
> On 12/30/2017 08:57 AM, Longpeng (Mike) wrote:
>>> What you actually do is the following. You define a
>>> 'VIRTIO_CRYPTO_F_<SERVICE_NAME>_STATELESS_MODE feature bit is negotiated'
>>> (A) mode and a '... bit is not negotiated (B)' mode for each service. 
>>
>>> In
>>> mode A the driver has to use type A sateful requests (to which you refer
>>> as session mode).  In mode B however the driver can use both stateless
>>> requests (to which you refer as stateless mode) and B type stateful
>>> requests (to which you also refer as session mode).
>> Sorry, I think the driver can use both in mode A and has to use stateful mode in
>> mode B.
>>
> 
> You are right I've mixed up A and B. I think you got my point despite
> of this slip up. 
> 
> I'm on holiday this week. Will try to review v23 next week.
> 

OK. Hoping you have a good holiday :)

> Regards,
> Halil
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
