Received: from eggs.gnu.org ([2001:4830:134:3::10]:45507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQBU8-0005D7-Tt
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 08:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQBU5-0005dr-LZ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 08:27:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58508
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gQBU3-0005Yl-Qi
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 08:27:00 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wANDIdjl072109
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 08:26:57 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nxg8vnw2b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 08:26:57 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 23 Nov 2018 13:26:55 -0000
Reply-To: pmorel@linux.ibm.com
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-2-cohuck@redhat.com>
	<853a8421-af17-5130-51b7-3242cc10b989@linux.ibm.com>
	<20181123134517.0b21c263.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 23 Nov 2018 14:26:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181123134517.0b21c263.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <dcf76e4e-95f3-e09d-7110-e66212b393c2@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On 23/11/2018 13:45, Cornelia Huck wrote:
> On Fri, 23 Nov 2018 13:28:25 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> On 22/11/2018 17:54, Cornelia Huck wrote:
>>> Allow to extend the regions used by vfio-ccw. The first user will be
>>> handling of halt and clear subchannel.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    drivers/s390/cio/vfio_ccw_ops.c     | 182 ++++++++++++++++++++++++=
----
>>>    drivers/s390/cio/vfio_ccw_private.h |  38 ++++++
>>>    include/uapi/linux/vfio.h           |   1 +
>>>    3 files changed, 195 insertions(+), 26 deletions(-)
>>>   =20
>>
>> Halt and clear have no parameters (the sub-channel ID is obviously the
>> one of the mediated device).
>>
>> Isn't adding a new sub-region for the purpose of handling halt and cle=
ar
>> superfluous?
>>
>> What is the reason not to use simple ioctls ?
>=20
> Should it turn out that we missed something and need an enhanced
> interface, we can simply stop providing this subregion and add a new
> subregion, without breaking existing userspace. We can't do that with
> ioctls.

OK, it is a good reason, took me a while but I get the interest of=20
capabilities for regions too.

>=20
> And moreover, this is only the first user of this infrastructure.
> There's also that path handling series that Dong Jia had posted early
> this year -- that would be an obvious user as well.
>=20

right.

Thanks.

Regards,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
