Received: from eggs.gnu.org ([2001:4830:134:3::10]:50048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1euGCU-0001cD-2L
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1euGCQ-0003yi-U4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:28:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1euGCQ-0003yN-L7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:28:34 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w29BONpI140258
	for <qemu-devel@nongnu.org>; Fri, 9 Mar 2018 06:28:33 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gkq5awm9t-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 06:28:32 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Fri, 9 Mar 2018 11:28:30 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
	[9.149.105.60])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id w29BSRWT1835506
	for <qemu-devel@nongnu.org>; Fri, 9 Mar 2018 11:28:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C777E42049
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 11:20:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE24D42041
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 11:20:47 +0000 (GMT)
Received: from [9.152.224.146] (unknown [9.152.224.146])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 11:20:47 +0000 (GMT)
References: <20180307162958.11232-1-nia.alarie@gmail.com>
	<9fdc51f3-edcb-1811-2501-da1e17e52c97@linux.vnet.ibm.com>
	<20180309112703.5edfb386.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 9 Mar 2018 12:28:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180309112703.5edfb386.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <1a88ed26-8446-aff3-a273-6801e0657cfc@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x/virtio: Convert virtio-ccw from
 *_exit to *_unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 09/03/2018 11:27, Cornelia Huck wrote:
> On Fri, 9 Mar 2018 10:23:31 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> On 07/03/2018 17:29, Nia Alarie wrote:
>>> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
>> What you do seems right to me, naming seems more logical, but=C2=A0 ca=
n you
>> please
>> add a little commit message explaining why you change the interface?
> I had asked Nia to do this; see the comments in qdev-core.h regarding
> usage of exit vs. unrealize.

OK thanks.

>
> (I have already queued this for a pull request, since I'll be out
> starting tomorrow.)

have fun where you go. :)

See you.
bye

>
>> Thanks,
>>
>> Pierre
>>
>>> ---
>>>    hw/s390x/virtio-ccw.c | 34 +++++++++++++++++-----------------
>>>    hw/s390x/virtio-ccw.h |  2 +-
>>>    2 files changed, 18 insertions(+), 18 deletions(-)


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
