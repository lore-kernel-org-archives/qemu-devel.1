Received: from eggs.gnu.org ([2001:4830:134:3::10]:55373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNgWo-0003ba-Eo
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNgWn-0001wl-EY
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:27:14 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-22-f4bug@amsat.org>
	<CAFEAcA_PRH_BuUOTtC=cvRFT7Gtiwt50T6C3avm+Sy13aDS4tg@mail.gmail.com>
	<ae090923-3523-3e56-fbc1-65b270680939@amsat.org>
	<e0d37c83-537a-5288-b033-e5be3b8858ca@redhat.com>
	<c1078250-30a0-0d4c-d830-88591fb6ba43@redhat.com>
	<713f16f9-3faa-7644-38c6-0797252d5922@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63a61375-ef2e-970c-7f43-6cfe1d7666b1@redhat.com>
Date: Tue, 29 May 2018 10:27:03 -0500
MIME-Version: 1.0
In-Reply-To: <713f16f9-3faa-7644-38c6-0797252d5922@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 21/35] arm/sysbus-fdt: fix null
 pointer dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

[adding Markus, as the error maintainer]

On 05/29/2018 09:33 AM, Philippe Mathieu-Daud=C3=A9 wrote:

>>>> Ok I see, Clang is unaware than error_setg(&error_fatal) is a noretu=
rn.
>>>
>>> Indeed, and that's because error_setg(&error_fatal) is not in preferr=
ed
>>> form.
>>>
>>>>
>>>> Patch dropped.
>>>
>>> That's a shame.  Rather, we should patch this file (and others) to av=
oid
>>> all the inconsistent uses of error_setg(&error_*), to comply with the
>>> error.h documentation.
>=20
> I started to port/clean this up.
> To avoid future inconsistencies, do you think we should/can enforce thi=
s
> check in checkpatch (which is stricter than human review)?

Sure, automating good code style is worthwhile.

> Is the "Qemu error function tests" section a good place to put this che=
ck?

Probably works.  I'm not familiar enough with checkpatch as a whole to=20
have any different suggestions off the top of my head (basically, any=20
time I've touched that file, it's been grepping for something that is=20
similar to what I want to be tweaking, rather than reading the whole thin=
g).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
