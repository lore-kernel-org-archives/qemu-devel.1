Received: from eggs.gnu.org ([2001:4830:134:3::10]:50050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fIJ02-0003ds-LI
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fIIzz-0004ng-C5
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:19:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fIIzz-0004ma-3t
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:19:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4EJIo5u117182
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:19:06 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hydx7p94y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:19:05 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Mon, 14 May 2018 13:19:03 -0600
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-5-git-send-email-akrowiak@linux.vnet.ibm.com>
	<c36ec83f-8cba-cf7b-3054-35cf4cd65c14@linux.ibm.com>
	<1806faa3-dc46-f638-5c87-8a7415c9025a@linux.vnet.ibm.com>
	<59037385-06ae-e7e6-97a0-73b8acb4bee1@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Mon, 14 May 2018 15:18:54 -0400
MIME-Version: 1.0
In-Reply-To: <59037385-06ae-e7e6-97a0-73b8acb4bee1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <0dea8e93-703d-8237-864d-a64ce157cfe1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/6] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 05/11/2018 06:29 AM, Halil Pasic wrote:
>
>
> On 05/10/2018 03:10 PM, Tony Krowiak wrote:
>>> If I did not. I think this is a big problem. We need to at least
>>> zeroize the queues (e.g. on system reset)  to avoid leaking
>>> sensitive information. Without this, there is no sane way to use
>>> ap-passthrough. Or am I wrong?
>>
>> I do not have a definitive answer, I will have to look into it.
>> I'm thinking that since we are using ap-passthrough, the AP bus
>> running on the guest would be responsible for handling reset possibly
>> by resetting or zeroizing its queues. I'll get back to you on this.
>
> You are on the wrong track. What I'm talking about is the responsibility
> of the hypervisor and not the responsibility of the guest.

I think Pierre covered it in his reply.

>
>
> Regards,
> Halil
>
>
