Received: from eggs.gnu.org ([2001:4830:134:3::10]:40037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9Gh8-0001pG-LK
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9Gh5-0000Nr-GZ
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:30:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9Gh5-0000Nc-AM
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:29:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9UKTLix178553
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 16:29:56 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dx8ssqqvb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 16:29:55 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 30 Oct 2017 16:29:55 -0400
References: <20171026202250.6118-1-danielhb@linux.vnet.ibm.com>
	<20171030201213.GA2911@umbus>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 30 Oct 2017 18:29:50 -0200
MIME-Version: 1.0
In-Reply-To: <20171030201213.GA2911@umbus>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <047c570c-10a6-9255-0e4d-f3da594b0a5b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v1 0/3] ppc: adding some RTAS
 calls in tests/libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com



On 10/30/2017 06:12 PM, David Gibson wrote:
> On Thu, Oct 26, 2017 at 06:22:47PM -0200, Daniel Henrique Barboza wrote:
>> This series implements a few RTAS hypercalls in tests/libqos
>> that, used together, implement the DRC state transition described
>> in PAPR 2.7+, 13.4.
>>
>> This started as an attempt of implementing hot unplug qtests for the
>> sPAPR machine but I've found a few issues that will require more time
>> solving:
>>
>> - CPU hot unplug: for some reason the machine freezes after the
>> callback is returned.
>>
>> - LMB hot unplug: not supported by the sPAPR machine if not
>> set in CAS.
>>
>> I have a feeling that the CPU hot unplug  issue might be related
>> with the lack of CAS negotiation step as well, but only way to be
>> sure is to further understanding how the CAS negotation interfere
>> with the device hot unplug. If needed we'll have to implement the
>> client architecture support hypercall as well in the future.
>>
>> Until then, I believe these hypercalls have a value of their own and
>> are worth being pushed upstream.
> Unfortunately, these changes break the Travis build on MacOS.

Hmpf .... how can I run this Travis build to see the errors? I've searched
here and found out something about making a Github pull request and
then https://travis-ci.org/qemu/qemu runs the Travis build in the request.
Is this a valid way of running it?


Thanks,

Daniel

>>
>> Daniel Henrique Barboza (3):
>>    tests: adding 'check_exception' RTAS implementation
>>    tests: adding 'set_indicator' RTAS call
>>    tests: ibm,configure-connector RTAS call implementation
>>
>>   tests/libqos/rtas.c | 105 +++++++++++++++++++++++++
>>   tests/libqos/rtas.h |   5 ++
>>   tests/rtas-test.c   | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 328 insertions(+)
>>
