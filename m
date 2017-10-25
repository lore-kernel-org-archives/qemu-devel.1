Received: from eggs.gnu.org ([2001:4830:134:3::10]:57034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fiuczy@linux.vnet.ibm.com>) id 1e7NJS-0006kd-7P
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fiuczy@linux.vnet.ibm.com>) id 1e7NJM-0001ak-6c
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:09:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59050
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fiuczy@linux.vnet.ibm.com>)
	id 1e7NJL-0001WH-U0
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:09:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PF3Dfo144432
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 11:09:35 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dtu63pxnr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 11:09:34 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <fiuczy@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 16:09:32 +0100
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<d028d04a-9c28-af10-3410-f9007867cc05@de.ibm.com>
	<1ac27ce2-091d-e1b7-fc94-ebdf696a35e9@redhat.com>
From: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 17:09:28 +0200
MIME-Version: 1.0
In-Reply-To: <1ac27ce2-091d-e1b7-fc94-ebdf696a35e9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <9f4037d8-93a3-be0f-8cb4-4424158e236b@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 10/25/2017 12:23 PM, David Hildenbrand wrote:
> On 25.10.2017 12:18, Christian Borntraeger wrote:
>> Ping, I plan to submit belows patch for 2.11. We can then still look i=
nto
>> a libvirt<->qemu interface for limiting host-model depending on machin=
e versions
>> (or not).
>=20
> I think this would be sufficient for now.
>=20
> Having different host models, depending on the the machine type sounds
> wrong. But maybe we'll need it in the future.
>=20

David, I disagree if your proposal is to generally tolerate new cpu=20
features in old machine types. This *might* work for gs but how do you=20
guaranty that guests do not behave differently/wrong when suddenly new=20
cpu features are made available to guest when (re-)starting them.
That is my feedback for the qemu side of this mater.

Regarding the libvirt side of this:
When looking at https://libvirt.org/formatdomain.html#elementsCPU I=20
found the following sentence:
Since the CPU definition is copied just before starting a domain,=20
exactly the same XML can be used on different hosts while still=20
providing the best guest CPU each host supports.

My interpretation of "the best guest CPU each host supports" is that=20
besides limiting factors like hardware, kernel and qemu capabilities the=20
requested machine type for the guest is a limiting factor as well.

Nevertheless if my interpretation is found to be incorrect than we=20
should think about another new cpu mode that includes the machine type=20
into the "best guest CPU" detection.
My assumption is that we must not require the users to know which cpu=20
model they manually need to define to match a specific machine type
AND we want to guarantee that guests run without risking any side=20
effects by tolerating any additional cpu features.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
