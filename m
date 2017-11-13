Received: from eggs.gnu.org ([2001:4830:134:3::10]:35829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEBIR-00039n-Fb
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEBIM-0002mq-Jw
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:44:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59218
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eEBIM-0002mV-Dw
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:44:46 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAD9iL0L018703
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:44:41 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e77j5c0p4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:44:40 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 09:44:39 -0000
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-4-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109175126.23c9cb33.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 10:44:36 +0100
MIME-Version: 1.0
In-Reply-To: <20171109175126.23c9cb33.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <69e3e7ac-5fa7-021e-a6f6-22be0245a20b@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On 09/11/2017 17:51, Cornelia Huck wrote:
> On Tue,  7 Nov 2017 18:24:35 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> Enhance the fault detection, correction of the fault reporting.
>=20
> Basically the same comments as for the previous patch (but looks good
> in general).

thanks I will process it the same way as patch 2/7 then.


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
