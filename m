Received: from eggs.gnu.org ([2001:4830:134:3::10]:42810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dV253-0002zh-Hz
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dV24y-0000DB-NM
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:48:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dV24y-0000D1-DI
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:48:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6BKinT9117192
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 16:48:18 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bn0mxeuss-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 16:48:18 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 16:48:17 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
	[9.57.199.111])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v6BKmFUn52887590
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:48:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 880A5AC046
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 16:48:22 -0400 (EDT)
Received: from sbct-3.watson.ibm.com (unknown [9.2.141.158])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id 76FCAAC03F
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 16:48:22 -0400 (EDT)
References: <1499783493-15911-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<e75d34d2-9fda-b514-3c22-655bb0c4b455@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 16:48:14 -0400
MIME-Version: 1.0
In-Reply-To: <e75d34d2-9fda-b514-3c22-655bb0c4b455@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <bc640b8c-1b43-1cc2-5b61-db7f843c7e01@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] specs: Describe the TPM support in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 07/11/2017 03:36 PM, Laszlo Ersek wrote:
> On 07/11/17 16:31, Stefan Berger wrote:
>> This patch adds a description of the current TPM support in QEMU
>> to the specs.
>>
>> Several public specs are referenced via their landing page on the
>> trustedcomputinggroup.org website.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>
>> ---
>>
>> v1->v2:
>>    - fixed typos
>>    - added command line for starting an x86_64 VM with TPM passthrough device
>>    - added command lines for checks inside the VM
>> ---
>>   docs/specs/tpm.txt | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 124 insertions(+)
>>   create mode 100644 docs/specs/tpm.txt
> Awesome, thank you very much!
>
> I think I noticed one typo in new text:
>
>> +#> dmesg | grep TCPA
>> +[    0.000000] ACPI: TCP 0x0000000003FFD191C 000032 (v02 BOCHS  \
>> +    BXPCTCPA 0000001 BXPC 00000001)
> I think the prefix here should be "ACPI: TCPA"; the letter "A" probably
> fell victim to wrapping the line nicely.
My bad. I copied from the VM by typing it, which is error prone. :-)

    Stefan
