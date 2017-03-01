Received: from eggs.gnu.org ([2001:4830:134:3::10]:35159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cj3hg-0003Kq-G2
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cj3hd-000079-En
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:50:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1cj3hd-000071-4n
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:49:57 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21CmbCZ032675
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 07:49:54 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28wxmk04f3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 07:49:53 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 1 Mar 2017 05:43:15 -0700
References: <20160120154657.GF13215@redhat.com>
	<569FADC7.7060301@linux.vnet.ibm.com>
	<20160120162220.GH13215@redhat.com> <20160121113632.GC2446@work-vm>
	<57FA3A002D66E049AA7792D931B894C7060F5494@MOKSCY3MSGUSRGB.ITServices.sbc.com>
	<945CA011AD5F084CBEA3E851C0AB28894B8C3A14@SHSMSX101.ccr.corp.intel.com>
	<575E92DB.3080904@linux.vnet.ibm.com> <20160615193019.GB7300@work-vm>
	<5761C092.5070702@linux.vnet.ibm.com> <20160616080520.GA2249@work-vm>
	<20160616082517.GC11426@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 1 Mar 2017 07:25:28 -0500
MIME-Version: 1.0
In-Reply-To: <20160616082517.GC11426@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <5075d390-a1d1-b707-6b57-deb0154c2e37@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Berger <stefanb@us.ibm.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "SERBAN, CRISTINA" <cs1731@att.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH, CHING C" <cs1815@att.com>

On 06/16/2016 04:25 AM, Daniel P. Berrange wrote:
> On Thu, Jun 16, 2016 at 09:05:20AM +0100, Dr. David Alan Gilbert wrote:
>> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
>>> On 06/15/2016 03:30 PM, Dr. David Alan Gilbert wrote:
>> <snip>
>>
>>>> So what was the multi-instance vTPM proxy driver patch set about?
>>> That's for containers.
>> Why have the two mechanisms? Can you explain how the multi-instance
>> proxy works; my brief reading when I saw your patch series seemed
>> to suggest it could be used instead of CUSE for the non-container case.
> One of the key things that was/is not appealing about this CUSE approach
> is that it basically invents a new ioctl() mechanism for talking to
> a TPM chardev. With in-kernel vTPM support, QEMU probably doesn't need
> to have any changes at all - its existing driver for talking to TPM

We still need the control channel with the vTPM to reset it upon VM 
reset, for getting and setting the state of the vTPM upon 
snapshot/suspend/resume, changing locality, etc.

    Stefan
