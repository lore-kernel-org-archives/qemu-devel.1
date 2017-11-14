Received: from eggs.gnu.org ([2001:4830:134:3::10]:33144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eEZXH-0000tO-Fz
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 06:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eEZXD-0007T3-DY
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 06:37:47 -0500
Received: from mail.ispras.ru ([83.149.199.45]:47692)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eEZXD-0007S6-0i
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 06:37:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 14 Nov 2017 14:37:40 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <CABdb737buNdep007xMsBR2ZxOpmZXiSd_fz_mcQhnrbZGP2kgw@mail.gmail.com>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
	<CABdb736bkcafKPCHsQGEmB6wYOGB4s4S4+sVkuygDe7SjqZDYA@mail.gmail.com>
	<CABdb736w49GjXwNOsj4o8RHQKAfmWnu+jJQgAZjzHwwzOW-+gA@mail.gmail.com>
	<1b94bfaac633fc76c8633bbcec9ff4a9@ispras.ru>
	<CABdb735OHqGVf_0D=zDy9D4HzG4s+w8OjUX5MG2pWrqOrQc=pg@mail.gmail.com>
	<3205f50a0ec9089fcaf452911e60637b@ispras.ru>
	<CABdb737buNdep007xMsBR2ZxOpmZXiSd_fz_mcQhnrbZGP2kgw@mail.gmail.com>
Message-ID: <c7047af12c8908b2596a367cb9425339@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/43] Windbg supporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-11-13 15:23:
> On Wed, Nov 8, 2017 at 3:28 PM, Mihail Abakumov
> <mikhail.abakumov@ispras.ru> wrote:
>> Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-11-08 16:43:
>>=20
>>> On Wed, Nov 8, 2017 at 12:54 PM, Mihail Abakumov
>>> <mikhail.abakumov@ispras.ru> wrote:
>>>>=20
>>>> Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-11-06 18:15:
>>>>=20
>>>> In your case windbg does not send packets, more specifically, does=20
>>>> not
>>>> continue to do it. What is your version of windbg. Also, windbg stub=
=20
>>>> has
>>>> been supported only for windbg x64, yet.
>>>=20
>>>=20
>>> Ah, so that's a pretty important piece of information and not very
>>> intuitive given the "Only i386 is supported now." sentence in the
>>> cover email.
>>>=20
>>> Microsoft (R) Windows Debugger Version 10.0.15063.468 X86
>>> Microsoft (R) Windows Debugger Version 10.0.15063.468 AMD64
>>> Microsoft (R) Windows Debugger Version 10.0.16299.15 X86
>>> Microsoft (R) Windows Debugger Version 10.0.16299.15 AMD64
>>>=20
>>> are the versions I have tried. I don't see any difference between x86
>>> and amd64, all versions never connect and crash after the second
>>> break.
>>>=20
>>> What guest OS are you running? Can you maybe zip up your QEMU=20
>>> binaries
>>> and share them with me?
>>>=20
>>> Thanks,
>>> Ladi
>>=20
>>=20
>> Oh, it looks like a problem in the versions. I use the Windbg from=20
>> Windows
>> 7.
>> Windbg version: 6.12.0002.633 AMD64. I will try to test with your=20
>> version.
>=20
> Looks like it's the -b switch making the difference here. It was
> removed in later versions of windbg.
>=20
>=20
> Windbg docs (older):
>=20
> -b
> (Kernel mode only) This option has two effects:
> 1. The debugger will break into the target computer immediately upon=20
> connection.
>=20
> 2. After a reboot, the debugger will break into the target computer
> once the kernel is initialized. See Crashing and Rebooting the Target
> Computer for details and for other methods of changing this status.
>=20
>=20
> Windbg docs (newer):
>=20
> -b
> This option is no longer supported.
>=20
>=20
> -b makes windbg send a break-in right after connecting. Apparently
> there is a short time window when the break-in will work. I can
> actually successfully connect with a Win10 windbg (so without -b) if I
> hit Ctrl+Break shortly after the initial handshake. This also explains
> why I was able to connect once during my initial testing. I was just
> lucky and hit Ctrl+Break soon enough after connecting.
>=20
> By initial handshake I mean this sequence (I have added a simple
> logging, should be clear what it means):
>=20
> Received control PACKET_TYPE_KD_RESET
> Sending data 7
> Sending control 6
>=20
> Newer debuggers without -b will stop here. Older debuggers with -b
> will continue with:
>=20
> Received RESULT_BREAKIN_BYTE
> Sending data 7
> Received RESULT_BREAKIN_BYTE
> Sending data 7
> Received data PACKET_TYPE_KD_STATE_MANIPULATE (12614)
> Sending control 4
> Sending data 2
> Received data PACKET_TYPE_KD_STATE_MANIPULATE (12592)
> Sending control 4
> Sending data 2
> Received data PACKET_TYPE_KD_STATE_MANIPULATE (12592)
> Sending control 4
> Sending data 2
> ...
>=20
>=20
> Next step, when I have time, is to find the differences between
> sending the break-in early and sending it later. Also interesting
> would be recording the exchange between windbg and the target when
> doing regular remote kernel debugging. I would still expect to see the
> "Connected to Windows 7 7601 x86 compatible target ..." output always,
> even when not breaking in immediately. The handshake is likely still
> missing something.
>=20
> Thanks,
> Ladi

I tested the new windbg. And as it turned out, three new api appeared in=20
it.
Naturally, it falls due to the fact that they are not realized. I will=20
try
to implement these api.

--=20
Thanks,
Mihail
