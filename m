Received: from eggs.gnu.org ([2001:4830:134:3::10]:38149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dQdwf-0000Pb-Lf
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dQdwc-0007f2-Ie
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:13:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dQdwc-0007eP-99
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:13:34 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TIDOxf136967
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 14:13:32 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bd34c2ewr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 14:13:32 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 29 Jun 2017 12:13:31 -0600
References: <1498759215-25382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<52874c12-d5ff-518e-a796-3f8de2714fca@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 14:13:26 -0400
MIME-Version: 1.0
In-Reply-To: <52874c12-d5ff-518e-a796-3f8de2714fca@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <5dd0ce53-423f-aa7f-e9e9-45928b8b35b2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] specs: Describe the TPM support in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com, javierm@redhat.com

On 06/29/2017 02:07 PM, Eric Blake wrote:
> On 06/29/2017 01:00 PM, Stefan Berger wrote:
>> This patch adds a description of the current TPM support in QEMU
>> to the specs.
>>
>> Several public specs are referenced via their landing page on the
>> trustedcomputinggroup.org website.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   docs/specs/tpm.txt | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 98 insertions(+)
>>   create mode 100644 docs/specs/tpm.txt
>> +
>> +QEMU files related to TPM TIS interfaceL
> s/interfaceL/interface:/
>
>
>> +
>> +Since the host's TPM device will already be initialize by the host's firmware,
> s/initialize/initialized/
>
applied :-)
