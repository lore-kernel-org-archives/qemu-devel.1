Received: from eggs.gnu.org ([209.51.188.92]:40562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gp9LF-0002Bz-Ul
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gp9LF-0003M4-4s
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:13:05 -0500
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
	<300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
	<87d0oddxu2.fsf@dusky.pond.sub.org>
	<f4528a7d-4bb5-f607-760e-72db3eaa34ad@redhat.com>
	<877eelcgf9.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c4e222f-3941-426e-3195-5598b2af1501@redhat.com>
Date: Thu, 31 Jan 2019 11:12:45 +0100
MIME-Version: 1.0
In-Reply-To: <877eelcgf9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Krempa <pkrempa@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

On 31/01/19 10:41, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 31/01/19 09:40, Markus Armbruster wrote:
>>>> Maybe we should just add pflash block properties to the machine?  An=
d
>>>> then it can create the devices if the properties are set to a non-em=
pty
>>>> value.
>>> What exactly do you have in mind?  Something like
>>>
>>>     -machine q35,ovmf-code=3DOVMF-CODE-NODE,ovmf-data=3DOVMF-DATA-NOD=
E
>>>
>>> where OVMF-CODE-NODE and OVMF-DATA-NODE are block backend node names,
>>> i.e.
>>>
>>>     -blockdev file,node-name=3DOVMF-CODE-NODE,read-only=3Don,filename=
=3D/usr/share/edk2/ovmf/OVMF_CODE.fd
>>>     -blockdev file,node-name=3DOVMF-DATA-NODE,read-only=3Don,filename=
=3D...
>>
>> Yes, though I would call it pflash0 and pflash1.
>=20
> Digression... should we put traditional BIOS in flash as well?  Only fo=
r
> new machine types, obviously.

The blocker was that very old KVM didn't support ROMD memory regions.
Now on one hand we don't support those old kernel versions anymore; on
the other hand we have HAX and WHPX that do not support ROMD at all.

Paolo
