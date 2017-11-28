Received: from eggs.gnu.org ([2001:4830:134:3::10]:59261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fiuczy@linux.vnet.ibm.com>) id 1eJeO7-0004kj-BZ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fiuczy@linux.vnet.ibm.com>) id 1eJeO4-00072e-6K
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:49:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fiuczy@linux.vnet.ibm.com>)
	id 1eJeO3-00072B-UW
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:49:16 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASBmqlT034422
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 06:49:11 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eh6a4jvyq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 06:49:10 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <fiuczy@linux.vnet.ibm.com>;
	Tue, 28 Nov 2017 11:49:08 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<594e1952-7097-0927-d913-d3b915df2305@linux.vnet.ibm.com>
	<20171122172522.281cfb4b.cohuck@redhat.com>
	<76f95c6f-641e-2fe0-73b4-3ab24fc1a93f@linux.vnet.ibm.com>
	<20171124134650.46665791.cohuck@redhat.com>
	<7eaa796e-7815-f943-58b5-ecb5a0bb252e@de.ibm.com>
	<20171124142758.39d7726f.cohuck@redhat.com>
	<131b311b-c262-3636-c7ee-1c59ee283823@de.ibm.com>
	<1ddb44db-2c5c-d64f-56e0-e4582f82b572@linux.vnet.ibm.com>
	<20171124171510.2343ccdf.cohuck@redhat.com>
	<8c18df3e-92a0-f88f-6d24-e1df051c8138@linux.vnet.ibm.com>
	<20171127135624.28052dc5.cohuck@redhat.com>
	<57f95f61-b9d9-1341-78c7-259006cb5945@linux.vnet.ibm.com>
	<20171127141929.1d692aad.cohuck@redhat.com>
	<39cb6a69-7f32-80d4-214d-26e1e81a9fd7@linux.vnet.ibm.com>
	<2933e058-0217-9696-2c52-613da8ba7a1c@linux.vnet.ibm.com>
	<20171127175607.75bd999e.cohuck@redhat.com>
	<c49e91f1-0f8a-8f6c-9784-21aa4623e2cf@linux.vnet.ibm.com>
	<20171128112233.0a1c8c04.cohuck@redhat.com>
From: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 12:49:04 +0100
MIME-Version: 1.0
In-Reply-To: <20171128112233.0a1c8c04.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <377c7bcb-403b-ed66-a9fd-07793c27ea5c@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

On 11/28/2017 11:22 AM, Cornelia Huck wrote:
> On Tue, 28 Nov 2017 09:53:15 +0100
> Boris Fiuczynski <fiuczy@linux.vnet.ibm.com> wrote:
>=20
>> On 11/27/2017 05:56 PM, Cornelia Huck wrote:
>>> Proposal 2: Export the default cssid as a machine property. If this
>>> property exists, it also implies that devices can be put into any css
>>> image (although it makes the most sense to put them into the default
>>> css image as indicated by the property). Can be made r/w later if it =
is
>>> too much for 2.12.
>> Just as a side discussion:
>> I know of qom command query-machines but that does not seem to provide
>> the information you suggest to use with proposal 2.
Sorry, I meant query-command-line-options.

>> What qom command do you suggest to use for the introspection of the
>> machine options access mode?
>>
>=20
> Is qom-get what you are looking for?
>=20
> virsh # qemu-monitor-command vm1 --pretty '{ "execute": "qom-get", "arg=
uments": { "path": "/machine/", "property": "accel"} }'
> {
>    "return": "kvm",
>    "id": "libvirt-18"
> }
>=20
How do you find out from returned values that accel is r/o or r/w?

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
