Received: from eggs.gnu.org ([2001:4830:134:3::10]:58354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEAib-00008K-Ox
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEAiY-000889-Hy
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:07:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eEAiY-00087b-9V
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:07:46 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAD94Vxj086932
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:07:40 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e7505s3pa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:07:39 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 09:07:35 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id vAD97WwT42205416
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:07:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DE7242045
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:02:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 740DF42042
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:02:29 +0000 (GMT)
Received: from [9.145.26.235] (unknown [9.145.26.235])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:02:29 +0000 (GMT)
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-4-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109175126.23c9cb33.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 10:07:32 +0100
MIME-Version: 1.0
In-Reply-To: <20171109175126.23c9cb33.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <4001bafb-0b51-e823-22fa-cf629a5968e2@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/7] s390x/pci: rework PCI LOAD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 09/11/2017 17:51, Cornelia Huck wrote:
> On Tue,  7 Nov 2017 18:24:35 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> Enhance the fault detection, correction of the fault reporting.
>=20
> Basically the same comments as for the previous patch (but looks good
> in general).

thanks I will process it the same way as patch 2 then.

>=20
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 27 ++++++++++++++++-----------
>>   1 file changed, 16 insertions(+), 11 deletions(-)
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
