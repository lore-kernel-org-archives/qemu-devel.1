Received: from eggs.gnu.org ([2001:4830:134:3::10]:54953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6HEZ-0006w1-CJ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6HEW-0006DF-AI
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:55:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33838
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6HEV-0006Cw-IU
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:55:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44Ds5P6130057
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 09:55:48 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a7m0rk6a4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 09:55:48 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 4 May 2017 14:55:45 +0100
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<38d13582-47f4-2a03-efef-064063c8852f@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA263F82@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 4 May 2017 15:55:35 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA263F82@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <17594b34-62c0-bc4e-2fda-fc54837e0732@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v18 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "lixiao (H)" <lixiao91@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Zhbzg <zhbzg@huawei.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Linqiangmin <linqiangmin@huawei.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Chenshanxi (Eety Chen, Euler)" <eety.chen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>



On 05/04/2017 03:33 PM, Gonglei (Arei) wrote:
>>> +\begin{description}
>>> +\item[VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE] Requires
>> VIRTIO_CRYPTO_F_STATELESS_MODE.
>>> +\item[VIRTIO_CRYPTO_F_HASH_STATELESS_MODE] Requires
>> VIRTIO_CRYPTO_F_STATELESS_MODE.
>>> +\item[VIRTIO_CRYPTO_F_MAC_STATELESS_MODE] Requires
>> VIRTIO_CRYPTO_F_STATELESS_MODE.
>>> +\item[VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE] Requires
>> VIRTIO_CRYPTO_F_STATELESS_MODE.
>>> +\end{description}
>>
>> I find feature bit 0 redundant and bit confusing. We had a discussion
>> in v15 and v16.
>>
>> Could you answer:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03214.html
>> (Message-ID: <1fbe30cc-87ec-32bc-4c57-85f9b03b3034@linux.vnet.ibm.com>)
>>
>>
> Please see my reply:
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03186.html
> 
> The main reason is we should keep compatibility to pre-existing driver and
> support some function that different services have different modes.
> We have only one unique crypto request named structure virtio_crypto_op_data_req_mux. 
> Please continue to see the sepc, you'll find the truth.
> 

Sorry, I still do not understand why can't we drop VIRTIO_CRYPTO_F_STATELESS_MODE
and just keep the four service specific modes.

Can you point me to the (published) code where  VIRTIO_CRYPTO_F_STATELESS_MODE is
used (that's what I'm missing -- preferably state the repository, the commit
a file and a line using VIRTIO_CRYPTO_F_STATELESS_MODE)?
