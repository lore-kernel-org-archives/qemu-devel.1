Received: from eggs.gnu.org ([2001:4830:134:3::10]:47399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMH8c-0004GO-HU
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMH8Z-0002ox-AX
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:08:26 -0400
References: <20180524175828.3143-1-pasic@linux.ibm.com>
	<20180524175828.3143-2-pasic@linux.ibm.com>
	<20180525114033.3c514091.cohuck@redhat.com>
	<c1c246bd-c0a8-7e30-dd0c-ba99c2346d15@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0787e807-53c3-7288-6d3f-e354f7fb4db9@redhat.com>
Date: Fri, 25 May 2018 13:08:13 -0500
MIME-Version: 1.0
In-Reply-To: <c1c246bd-c0a8-7e30-dd0c-ba99c2346d15@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] vfio-ccw: add force unlimited
 prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 05/25/2018 12:46 PM, Halil Pasic wrote:

>>> +static inline void warn_once(bool *warned, const char *fmt, ...)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 va_list ap;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!warned || *warned) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 *warned =3D true;
>>> +=C2=A0=C2=A0=C2=A0 va_start(ap, fmt);
>>> +=C2=A0=C2=A0=C2=A0 warn_vreport(fmt, ap);
>>> +=C2=A0=C2=A0=C2=A0 va_end(ap);
>>> +}
>>> +
>>> +static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchDev *sc=
h,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *msg)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 warn_once(&vcdev->warned_orb_pfch, "vfio-ccw (dev=
no %x.%x.%04x):=20
>>> %s",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sch->cssid, sch->ssid, sch->devno, msg);
>>> +}
>>> +
>>
>> While I still think we want warn_once() in common error handling code,
>> this looks reasonable enough. We can still move it later.
>>
>=20
> I agree. I was a bit surprised to not find any warn_once functionality.

That has been proposed:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05457.html

> Let see what Markus says.

Yes, it's still pending review.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
