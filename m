Received: from eggs.gnu.org ([2001:4830:134:3::10]:52701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRKnb-00023C-PH
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRKnY-0006g3-RH
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:31:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eRKnY-0006fQ-Kn
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:31:20 -0500
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-4-marcandre.lureau@redhat.com>
	<0a657570-b763-558d-69cb-357e2cdf6c3f@redhat.com>
	<CAJ+F1C+kddTNemSB7yzf7uVpyrM3by2n3bscp56BTBRXuxoFZw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8374b80f-76c8-66c9-9fb4-6be3032231e2@redhat.com>
Date: Tue, 19 Dec 2017 10:31:18 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+kddTNemSB7yzf7uVpyrM3by2n3bscp56BTBRXuxoFZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/13] build-sys: add a rule to print a
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On 12/19/2017 09:45 AM, Marc-Andr=C3=A9 Lureau wrote:

>>> +Useful make targets
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +- help
>>> +
>>> +  Print a help message for the most common build targets.
>>
>> Except that this patch forgot to tweak 'make help' to mention 'make
>> print-VAR' ;)
>=20
> Well, I don't think print-VAR is a common build target, it's a
> build-sys hack/debug imho, so having it described in build-system.txt
> only make sense.
>=20
> Do you agree?

With the bash-completion library installed, performing tab-completion on=20
'make ' produces a large list of targets, which includes 'help', but=20
even with your patch does NOT include 'print-CFLAGS' or any variant of=20
print-.  If I use just tab-completion and 'make help', then having=20
'print-FOO' listed under the "Generic targets:" section of the help=20
output would let me discover it without me having to read build-system.tx=
t.

Does anyone else have a strong opinion for or against the additional=20
output in 'make help'?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
