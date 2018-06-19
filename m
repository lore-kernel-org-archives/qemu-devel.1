Received: from eggs.gnu.org ([2001:4830:134:3::10]:36742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fVHIz-0007ti-5L
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fVHIt-00031y-EE
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:08:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64398
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fVHIt-00030w-8V
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:08:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5JE4sBU108562
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 10:08:13 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jq02j0e7h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 10:08:12 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 19 Jun 2018 15:08:11 +0100
References: <cover.1528921468.git.alifm@linux.ibm.com>
	<44ccc5db-e1d4-27b7-8942-c77f467f422e@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 19 Jun 2018 16:08:05 +0200
In-Reply-To: <44ccc5db-e1d4-27b7-8942-c77f467f422e@linux.ibm.com>
Content-Language: en-US
Message-Id: <0c5d7e42-e6c5-6aa2-8c1b-487c8cc9eb21@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Detect & register virtio-crypto
 algos only if it can be supported by backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: mst@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com, longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com, Jason Wang <jasowang@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>

On 06/19/2018 03:26 PM, Farhan Ali wrote:
> A polite ping :)
>=20
> If no one has any more comments/feedback then I would like to how to merg=
e these patches to the mainline kernel tree.

I think it should go via Michael Tsirkin or Jason Wang (Adding Jason).
Also adding Herbert Xu as FYI.


I have not looked into the details of the patch, but I like the idea.
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>



>=20
> Thanks
> Farhan
>=20
> On 06/13/2018 04:38 PM, Farhan Ali wrote:
>> Hi,
>>
>> Currently the Linux virtio-crypto driver registers the crypto
>> algorithm without verifying if the backend actually supports the
>> algorithm.
>>
>> This kernel patch series adds support for registering algorithm
>> with Linux crypto layer, only if the algorithm is supported by
>> the backend device. This also makes the driver more compliant with
>> the virtio-crypto spec [1].
>>
>> I would appreciate any feedback or comments on this.
>>
>> Thank you
>> Farhan
>>
>> Reference
>> ---------
>> [1] Virtio crypto spec proposal https://lists.gnu.org/archive/html/qemu-=
devel/2017-12/msg00816.html
>>
>> ChangeLog
>> ---------
>> v1 -> v2
>> =C2=A0=C2=A0=C2=A0 - Modify comment as suggested by Arei (patch 1)
>> =C2=A0=C2=A0=C2=A0 - Modify error message as suggested by Arei (patch 2)
>>
>>
>> Farhan Ali (2):
>> =C2=A0=C2=A0 crypto/virtio-crypto: Read crypto services and algorithm ma=
sks
>> =C2=A0=C2=A0 crypto/virtio-crypto: Register an algo only if it's support=
ed
>>
>> =C2=A0 drivers/crypto/virtio/virtio_crypto_algs.c=C2=A0=C2=A0 | 112 ++++=
++++++++++++++---------
>> =C2=A0 drivers/crypto/virtio/virtio_crypto_common.h |=C2=A0 25 +++++-
>> =C2=A0 drivers/crypto/virtio/virtio_crypto_core.c=C2=A0=C2=A0 |=C2=A0 29=
 +++++++
>> =C2=A0 drivers/crypto/virtio/virtio_crypto_mgr.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 81 +++++++++++++++++--
>> =C2=A0 4 files changed, 202 insertions(+), 45 deletions(-)
>>
>=20
