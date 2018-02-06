Received: from eggs.gnu.org ([2001:4830:134:3::10]:37919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej8Og-0006Fa-CN
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej8Od-0002cp-A1
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:55:14 -0500
References: <20180206074622.157812-1-borntraeger@de.ibm.com>
	<4181f0ff-5a2d-bdaa-9e40-ae3cb6f4417c@redhat.com>
	<d28909dd-b7fd-3f35-3bf6-94075e840aca@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64a569ea-103c-ad5f-267d-f54a5d7200c7@redhat.com>
Date: Tue, 6 Feb 2018 12:55:00 -0600
MIME-Version: 1.0
In-Reply-To: <d28909dd-b7fd-3f35-3bf6-94075e840aca@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/1] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 02/06/2018 12:21 PM, Christian Borntraeger wrote:

>>
>>> +=C2=A0=C2=A0=C2=A0 CRASH_REASON_UNKNOWN,=C2=A0 /* default value of 0=
 on reset */
>>> +=C2=A0=C2=A0=C2=A0 CRASH_REASON_PGM,
>>> +=C2=A0=C2=A0=C2=A0 CRASH_REASON_EXT,
>>> +=C2=A0=C2=A0=C2=A0 CRASH_REASON_WAITPSW,
>>> +=C2=A0=C2=A0=C2=A0 CRASH_REASON_OPEREXC,
>>
>> ...you have an internal enum for decoding some of those integer values=
 into specific human readable strings, but don't expose the enum over QAP=
I.=C2=A0 Are we sure that's the interface we want to go with?=C2=A0 As lo=
ng as you are okay with that, then I can live with the interface change; =
I just want to make sure that you are certain that the machine-based cons=
umer of the QMP command does not need to decode crash_reasons because you=
 left it as an internal enum.
>=20
> We might want to have temporary or intermediate crash reasons (e.g. emu=
lation failure or whatever),
> so not requiring changes in both components might be less error prone. =
(the way it is today)
> But if there is a strong wish for an on-the-wire enum, we could do that=
 as well.

I don't have a strong wish for an on-the-wire enum, so much as a request=20
to at least document in the commit message why you decided one was not=20
needed at this time.  And in all reality, would you really have to keep=20
two different enums in sync, or if you expose something over the wire,=20
can't that just be your only enum type?  If a temporary or intermediate=20
crash reason is useful enough to give a different string to the human=20
reader, why would it not be useful as also exposing as a different enum?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
