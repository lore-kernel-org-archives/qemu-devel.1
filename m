Received: from eggs.gnu.org ([2001:4830:134:3::10]:48567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6JU2-00021Q-Fz
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6JTy-0007lT-Il
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:20:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49370
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6JTy-0007kl-B7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:19:58 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44GJ3Gd099609
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 12:19:57 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a7u1bau46-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 12:19:57 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 4 May 2017 17:19:54 +0100
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<38d13582-47f4-2a03-efef-064063c8852f@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA263FC5@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 4 May 2017 18:19:46 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA263FC5@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <9c1c994a-f8ba-1182-8806-d04d44723c1e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] RE: [PATCH v18 1/2] virtio-crypto:
 Add virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, Linqiangmin <linqiangmin@huawei.com>, Zhbzg <zhbzg@huawei.com>, "Chenshanxi (Eety Chen, Euler)" <eety.chen@huawei.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, "lixiao (H)" <lixiao91@huawei.com>



On 05/04/2017 03:53 PM, Gonglei (Arei) wrote:
> Sorry, I missed one comment in the previous reply.
> 
>>
>>> +\end{itemize*}
>>> +
>>
>> What about extensibility regarding "detailed algorithms"? Is the driver
>> required ignore algorithms
>> it does not "know about"? Should we reserve the not (yet) defined bits?
>>
> I mean the device MUST set the algorithms mask bits based on supported
> algorithms by the device, and the driver read them to get the capacity.
> I don't think we should care about the not defined bits.

Let us assume that the driver fails if it encounters an unknown bit
(i.e. bit 13 set in hash_algo). I do not think there is anything in
this document that prohibits the driver doing so -- if there is please
do tell. Now at some point we want to support a new hash algorithm.
If we can't be sure that existing drivers are going to play along with
defining new bits (which are 'not defined bits' using your words for
the existing drivers) we have a small problem.

Was I clear about my concern?

> 
> Thanks,
> -Gonglei
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
