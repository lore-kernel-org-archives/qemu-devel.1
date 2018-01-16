Received: from eggs.gnu.org ([2001:4830:134:3::10]:35481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ebUtr-00067W-7Z
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ebUto-0005xL-3q
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:19:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ebUtn-0005wm-RC
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:19:48 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GHHtup012266
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 12:19:46 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fhkxap3ey-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 12:19:45 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 10:19:44 -0700
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-2-git-send-email-walling@linux.vnet.ibm.com>
	<34c87c41-eb49-0e2b-3857-9bb3ba86c8d4@redhat.com>
	<e0653416-ea6a-f801-2c30-4d01ed1fcf42@linux.vnet.ibm.com>
	<272fa2f6-8a75-3c05-e373-d7d1b65a7e23@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 12:19:38 -0500
MIME-Version: 1.0
In-Reply-To: <272fa2f6-8a75-3c05-e373-d7d1b65a7e23@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <d6805f2b-34b2-7e1f-f27b-1b244e5c36df@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 1/8] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, borntraeger@de.ibm.com, david@redhat.com

On 01/16/2018 05:00 AM, Thomas Huth wrote:
> On 15.01.2018 18:23, Collin L. Walling wrote:
>> On 01/15/2018 12:05 PM, Eric Blake wrote:
>>> On 01/15/2018 10:44 AM, Collin L. Walling wrote:
> [...]
>>>> +/**
>>>> + * atoi:
>>>> + * @str: the string to be converted.
>>>> + *
>>>> + * Given a string @str, convert it to an integer. Any non-numerical
>>>> value
>>>> + * will terminate the conversion.
>>>> + *
>>>> + * Returns: an integer converted from the string @str.
>>>> + */
>>>> +int atoi(const char *str)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 int i;
>>>> +=C2=A0=C2=A0=C2=A0 int val =3D 0;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; str[i]; i++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char c =3D str[i];
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!isdigit(c)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val *=3D 10;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val +=3D c - '0';
>>> Silently gives garbage on integer overflow, but matches the fact that
>>> POSIX atoi() can't flag errors.=C2=A0 However, it does not handle lea=
ding
>>> whitespace nor '-', which means it is NOT doing a POSIX-compatible
>>> atoi() implementation; naming it atoi() is perhaps thus a disservice =
to
>>> end users.
>> Fair enough. Perhaps the "strtoi" convention suits this better.
> Or maybe simply add an assert(str[0] !=3D '-') for now. If we ever hit =
the
> assert, we can still add the support for negative numbers if necessary.


Eh... honestly it's easy enough to just add a flag for the negative sign
and handle it at the end.=C2=A0 We don't need it for this patch series, b=
ut at
least the support will be there. :)

[...]

--=20
- Collin L Walling
