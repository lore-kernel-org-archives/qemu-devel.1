Received: from eggs.gnu.org ([2001:4830:134:3::10]:33658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPW28-0003ar-Bs
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPW24-0000o3-B3
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:11:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gPW24-0000kP-4e
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:11:20 -0500
References: <20181119154737.9840-1-liq3ea@163.com>
	<87bm6j8rvm.fsf@dusky.pond.sub.org>
	<8e31bbc2-20c9-86b7-97f9-d4cc8fd35656@redhat.com>
	<169ff9e0.8b5b.16734530e0c.Coremail.liq3ea@163.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7fe10f10-d913-4060-9e17-7b3e2dff1ac9@redhat.com>
Date: Wed, 21 Nov 2018 11:11:00 -0600
MIME-Version: 1.0
In-Reply-To: <169ff9e0.8b5b.16734530e0c.Coremail.liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] fw_cfg: fix boot bootsplash and
 reboot-timeout error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, kraxel@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 11/20/18 9:31 PM, =E6=9D=8E=E5=BC=BA wrote:

>=20
> Nice, when 4.0 window open? I don't find the release planning.

https://wiki.qemu.org/Planning gives the overview, and=20
https://wiki.qemu.org/Planning/3.1 gives the dates we are trying to hit=20
for 3.1.

> Maybe my another fw_cfg patches can be merged:
> -->https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00004.html
> -->https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00005.html

Any new features have missed 3.1, especially since -rc2 has already been=20
cut.  There is still room for bug fixes in -rc3, but the bar gets=20
progressively higher (we are reluctant to take something that might=20
destabilize the binaries without adequate time for testing), and while=20
we want to avoid an -rc4, past history says we'll probably have one,=20
although it will be as limited as possible.

> PS: I'm quite surprise the qemu's version up to 4 quickly(anyway, the 3=
.1 is just begin)...

Version numbers are somewhat arbitrary.  We recently switched to bumping=20
the major version every year (it's arbitrary, after all), so 2019 will=20
have 4.0, 4.1, and probably 4.2 (if we stick to a release every 4=20
months) before 2020 starting with 5.0.  The change from 3.0 to 3.1 will,=20
in reality, be about the same as the change from 3.1 to 4.0.  A better=20
way to think of it is that both the old and new naming schemes are both=20
arbitrary, but the new naming scheme has the benefit of not resulting in=20
large minor numbers.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
