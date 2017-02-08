Received: from eggs.gnu.org ([2001:4830:134:3::10]:52946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cbTDs-00062m-JC
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cbTDo-0005i1-Jj
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:27:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40406
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cbTDo-0005hY-E0
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:27:48 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v18EO0dL107463
	for <qemu-devel@nongnu.org>; Wed, 8 Feb 2017 09:27:47 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28g1qvgfxm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 09:27:47 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 8 Feb 2017 14:27:44 -0000
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<20170203103316.GA29200@stefanha-x1.localdomain>
	<33183CC9F5247A488A2544077AF19020DA1AED04@DGGEMA505-MBX.china.huawei.com>
	<20170206154625.GB32590@stefanha-x1.localdomain>
	<20170206201814-mutt-send-email-mst@kernel.org>
	<33183CC9F5247A488A2544077AF19020DA1AF46A@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 8 Feb 2017 15:27:36 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1AF46A@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <5eff6d39-4905-41e7-6819-9514ed2b2ca3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v16 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, longpeng <longpeng2@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, Luonengjun <luonengjun@huawei.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "claudio.fontana@huawei.com" <claudio.fontana@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>



On 02/07/2017 01:59 AM, Gonglei (Arei) wrote:
> Hi,
> 
>> From: Michael S. Tsirkin [mailto:mst@redhat.com]
>> Sent: Tuesday, February 07, 2017 2:20 AM
>> Subject: Re: [Qemu-devel] [PATCH v16 1/2] virtio-crypto: Add virtio crypto
>> device specification
>>
>> On Mon, Feb 06, 2017 at 03:46:25PM +0000, Stefan Hajnoczi wrote:
>>> On Mon, Feb 06, 2017 at 01:48:09AM +0000, Gonglei (Arei) wrote:
>>>>>> +\item The device MUST set \field{max_size} to show the maximum size
>> of
>>>>> crypto request the device supports.
>>>>>
>>>>> In bytes?
>>>>>
>>>>>> +\item The device MUST set \field{max_cipher_key_len} to show the
>>>>> maximum length of cipher key if the device supports CIPHER service.
>>>>>
>>>>> In bits or bytes?
>>>>>
>>>>>> +\item The device MUST set \field{max_auth_key_len} to show the
>> maximum
>>>>> length of authenticated key if the device supports MAC service.
>>>>>
>>>>> In bits or bytes?
>>>>>
>>>>
>>>> All lengths in virtio crypto spec are bytes.
>>>
>>> Please move this before the first length field is defined:
>>>
>>>   +\begin{note}
>>>   +The basic unit of all data length the byte.
>>>   +\end{note}
>>
>> And I'd rewrite as
>>
>>    All data length fields specify the length in bytes.
>>
> 
> Okay, will do it.
> 
> BTW if no other objections or comments, 
> I'd like to send v17 as the final version to ballot, can I?
> 
> Thanks,
> -Gonglei
> 

I think it's a bit early for a 'final version' and a 'ballot'.
We need at least one more iteration (IMHO).

Halil

>>>
>>> It should be at the beginning of the spec.
>>
> 
> 
