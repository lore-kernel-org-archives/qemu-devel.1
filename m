Received: from eggs.gnu.org ([2001:4830:134:3::10]:50125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fUrOO-00025B-BO
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fUrOK-0000wA-BG
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:28:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40688
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1fUrOK-0000vY-4u
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:28:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5IANoiB049920
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 06:28:06 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jp94dvhe4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 06:28:06 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 18 Jun 2018 11:28:04 +0100
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
	<20180613093700.GG27901@redhat.com>
	<7b51465a-b7c1-58ec-1ef6-9fe791e96bbf@linux.ibm.com>
	<20180613150512.GA19901@redhat.com>
	<5833f4ec-dcd1-19ac-2848-facf31aec7cf@linux.ibm.com>
	<20180614082155.GI6355@redhat.com>
	<79597909-fdb5-2983-19ac-74332229c8ef@linux.ibm.com>
	<20180614151048.GA18967@redhat.com>
	<28dca328-6920-91a1-0962-b336a3ffcb5b@linux.ibm.com>
	<921fea52-8e68-57d3-154d-26cf063a164a@linux.vnet.ibm.com>
	<ca88315c-75a0-ddc2-ba81-e1dfdb2d6d25@linux.ibm.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 12:27:59 +0200
MIME-Version: 1.0
In-Reply-To: <ca88315c-75a0-ddc2-ba81-e1dfdb2d6d25@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <f8b2d1d2-2747-dbe5-3b02-f84e2f401972@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC v1 1/1] virtio-crypto: Allow disabling of
 cipher algorithms for virtio-crypto device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org, frankja@linux.ibm.com, mst@redhat.com, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, mjrosato@linux.vnet.ibm.com

On 15.06.2018 17:10, Farhan Ali wrote:
> 
> 
> On 06/15/2018 09:17 AM, Viktor VM Mihajlovski wrote:
[...]
>>
>> With the current virtio-crypto backend functionality offered (CBC AES
>> only) it may seem a bit over-engineered to offer a configuration option
>> to remove the only supported algorithm...
>>
>> What I could imagine to be useful though, would be to allow the backend
>> to advertise its capabilities to the guest virtio-crypto device, so that
>> the guest driver can register the algorithms supported dynamically.
>> Currently, the algorithms are hard-coded on both sides which makes it a
>> bit hard to extend the backends to support new algorithms (or write new
>> backends if so desired).
> 
> I posted some kernel patches
> (https://www.spinics.net/lists/kvm/msg170332.html), that takes care of
> registering algorithms based on what the backend advertises.
> 
Sorry, I missed that. Sounds as if the principal mechanism to configure
guest virtio-crypto based on the host capabilities would be established
with the patches.
> 
>>
>> Whether the backend itself was configurable would be of less importance
>> then (but still could make sense).
>>
> 
> 


-- 
Regards,
  Viktor Mihajlovski
