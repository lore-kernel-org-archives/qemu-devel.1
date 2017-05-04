Received: from eggs.gnu.org ([2001:4830:134:3::10]:38114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6Kcj-00046f-54
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6Kcf-0003ga-5J
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:33:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50967
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6Kce-0003fR-V2
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:33:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44HSvkw149563
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 13:33:00 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a87fdbw03-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 13:32:59 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 4 May 2017 18:32:57 +0100
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<38d13582-47f4-2a03-efef-064063c8852f@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA263F82@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 4 May 2017 19:32:47 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA263F82@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <7cf81231-5a18-1525-deae-125ce2646144@linux.vnet.ibm.com>
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



On 05/04/2017 03:33 PM, Gonglei (Arei) wrote:
>>> +\drivernormative{\subsubsection}{Device configuration layout}{Device Types
>> / Crypto Device / Device configuration layout}
>>> +
>>> +\begin{itemize*}
>>> +\item The driver MUST read the ready \field{status} from the bottom bit of
>> status to check whether the backend crypto accelerator
>>> +      is ready or not, and the driver MUST reread it after device reset.
>>> +\item The driver MUST NOT transmit any requests to the device if the ready
>> \field{status} is not set.
>>> +\item The driver MUST read \field{max_dataqueues} field to discover the
>> number of data queues the device supports.
>>> +\item The driver MUST read \field{crypto_services} field to discover which
>> services the device is able to offer.
>>> +\item The driver MUST read the detailed algorithms fields based on
>> \field{crypto_services} field.
>>> +\item The driver SHOULD read \field{max_size} to discover the maximum
>> size of crypto request the device supports.
>>> +\item The driver SHOULD read \field{max_cipher_key_len} to discover the
>> maximum length of cipher key the device supports.
>>> +\item The driver SHOULD read \field{max_auth_key_len} to discover the
>> maximum length of authenticated key the device supports.
>>
>> Qouting a discussion from v15:
>> """
>>>>> +The value of the \field{status} field is VIRTIO_CRYPTO_S_HW_READY or
>>> ~VIRTIO_CRYPTO_S_HW_READY.
>>>> Not entirely happy with this. What you want to say is reserved
>>>> for future use, or? Would it make sense to have a general note
>>>> -- in a similar fashion like for 'sizes are in bytes' -- for
>>>> reserved for future use?
>>>>
>>>> One possible formulation would be:
>>>>
>>>> "In this specification, unless explicitly stated otherwise,
>>>> fields and bits reserved for future use shall be zeroed out.
>>>> Both the a device or a driver device and the driver should
>>>> detect violations of this rule, and deny the requested
>>>> operation in an appropriate way if possible."
>>> If we go with reserved-and-must-be-zero, we need to make rejecting
>>> non-zero for reserved value a MUST, or we may run into problems later.
>>>
>>> In this case, I'd opt for a specific formulation, though; like
>>>
>>> "The \field{status} field can be either zero or have one or more flags
>>> set. Valid flags are listed below."
>>>
>>> And then state that non-valid flags MUST NOT be set resp. MUST be
>>> rejected in a normative statement.
>>>
>> Sounds good.
>> """
>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01596.html
>>
>> I can't find this. Did we agree on something else in the meanwhile?
>>
> Please see above description:
> 
> """
> \begin{description}
> \item[\field{status}] is used to show whether the device is ready to work or not, it can be either zero or have one or more flags
>     Only one read-only bit (for the driver) is currently defined for the \field{status} field: VIRTIO_CRYPTO_S_HW_READY:
> \begin{lstlisting}
> #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
> \end{lstlisting}
> """
> 

I miss 

>>> And then state that non-valid flags MUST NOT be set resp. MUST be
>>> rejected in a normative statement.
>>>
that is 'MUST BE REJECTED in a normative statement' in particular!
