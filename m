Received: from eggs.gnu.org ([2001:4830:134:3::10]:47530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpd4l-0004Ho-PI
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpd4g-0005Xr-QI
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:21:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60191
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjrosato@linux.vnet.ibm.com>)
	id 1dpd4g-0005Wo-Jy
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:21:10 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v86GJvVj037903
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 12:21:08 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cth6xe473-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 12:21:08 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mjrosato@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 12:21:08 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<67bc4b1b-d934-dff6-9ce6-f5f34c11c9ca@de.ibm.com>
	<58b1ddef-e588-b976-824e-ed537740ad3a@redhat.com>
From: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 12:21:04 -0400
MIME-Version: 1.0
In-Reply-To: <58b1ddef-e588-b976-824e-ed537740ad3a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <aa512cc9-ff96-36a4-63e6-5351d8c7f08d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/19] s390x cleanups and CPU hotplug
 via device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>

On 09/06/2017 12:03 PM, David Hildenbrand wrote:
> On 05.09.2017 09:51, Christian Borntraeger wrote:
>> I think we certainly want to have device_add as well (as long as the old
>> interface stays for a while).
>>
>> Adding Matt. Can you have a look at the cpu hotplug bits?
> 
> If there is no further feedback, I'll be sending a new version out
> tomorrow, including the suggested changes. In addition, I'll be
> including support to hotplug VCPUs in random order (2 additional patches).
> 

Hi David, just returning from vacation -- Will look at this set today.

Matt
