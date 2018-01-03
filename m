Received: from eggs.gnu.org ([2001:4830:134:3::10]:54785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eWpsl-0003Du-8g
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:43:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eWpsh-0000gI-BG
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:43:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58258
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eWpsh-0000ex-5S
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:43:23 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w03Kcg65062970
	for <qemu-devel@nongnu.org>; Wed, 3 Jan 2018 15:43:21 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2f92xv9a35-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 15:43:20 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 3 Jan 2018 20:43:18 -0000
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
	<1512545840-10256-2-git-send-email-longpeng2@huawei.com>
	<db20b680-e7c8-6563-ebd7-27ab7e06ad6a@linux.vnet.ibm.com>
	<5A4746F3.6090201@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 3 Jan 2018 21:43:09 +0100
MIME-Version: 1.0
In-Reply-To: <5A4746F3.6090201@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <41e46c1a-025f-7d03-50ac-c29e008fb9d8@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, mst@redhat.com, xin.zeng@intel.com, jasowang@redhat.com, Cornelia Huck <cohuck@redhat.com>, luonengjun@huawei.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, liang.j.ma@intel.com, stefanha@redhat.com, jianjay.zhou@huawei.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com



On 12/30/2017 08:57 AM, Longpeng (Mike) wrote:
>> What you actually do is the following. You define a
>> 'VIRTIO_CRYPTO_F_<SERVICE_NAME>_STATELESS_MODE feature bit is negotiated'
>> (A) mode and a '... bit is not negotiated (B)' mode for each service. 
> 
>> In
>> mode A the driver has to use type A sateful requests (to which you refer
>> as session mode).  In mode B however the driver can use both stateless
>> requests (to which you refer as stateless mode) and B type stateful
>> requests (to which you also refer as session mode).
> Sorry, I think the driver can use both in mode A and has to use stateful mode in
> mode B.
> 

You are right I've mixed up A and B. I think you got my point despite
of this slip up. 

I'm on holiday this week. Will try to review v23 next week.

Regards,
Halil
